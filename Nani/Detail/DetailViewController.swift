//
//  ViewController.swift
//  Nani
//
//  Created by Jeff on 2021/3/18.
//

import UIKit
import Firebase
import FirebaseAuth

class DetailViewController: UIViewController {
    
    var interactor:Interactor? = nil
    
    var infoViewController: InfoViewController = {
        let vc = InfoViewController()
        return vc
    }()
    
    lazy var sectionTitleIndexCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = SectionTitleIndexCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self 
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionTitleIndexEmptyCell")
        cv.register(SectionTitleIndexCollectionViewCell.self, forCellWithReuseIdentifier: "SectionTitleIndexCell")
        cv.isHidden = true
        return cv
    }()
    
    var height: CGFloat?
    var delegate: CoverImageDelegate?
    var delegate2: HeaderViewDelegate?
    var yContraint: NSLayoutConstraint?
    var lContraint: NSLayoutConstraint?
    var rContraint: NSLayoutConstraint?
    var meals: [Meal] = Meal.loadDemoMeals()
    var mealSections: [String] = Meal.loadMealSections()
    let headerViewHeight = 115
    var users: [String:User] = [:]
    var reviews: [Review] = []
    var reviews_id: [Int]?
    var food_item: FoodCard? = nil
    var food_id: Int?
    var new_review_id: Int? = nil
    var total_users: Int = 0
    
    var ref = Database.database().reference()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(#imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.setImage(#imageLiteral(resourceName: "back-black").withRenderingMode(.alwaysOriginal), for: UIControl.State.highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissViewController), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.food = self.food_item
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCell")
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCell")
        cv.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCell")
        cv.register(InfoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "InfoDetailCell")
        cv.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCell")
        cv.register(EmptyReviewCollectionViewCell.self, forCellWithReuseIdentifier: "EmptyReviewCell")
        cv.register(DetailHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeader")
        cv.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        cv.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyCell")
        cv.contentInsetAdjustmentBehavior = .never
        cv.backgroundColor = .white
        return cv
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
        getData()
//        self.transitioningDelegate = self
    }
    
    func getData(){
        self.ref.child("Food_items").child(String(self.food_id!)).child("Reviews").observe(DataEventType.value, with: { (snapshot) in
            if let new_reviews_id = snapshot.value as? [Int]{
                if (self.reviews.count != new_reviews_id.count){
                    self.new_review_id = new_reviews_id[0]
                    self.ref.child("Reviews").child(String(self.new_review_id!)).observe(DataEventType.value, with: { (snapshot) in
                        if let new_review = snapshot.value as? [String:Any]{
                            self.reviews.insert(Review(new_review), at: 0)
                            self.collectionView.reloadData()
                        }
                    })
                }
            }
        })
        
        self.ref.child("Total_users").observe(DataEventType.value, with: { (snapshot) in
            if let usersNumber = snapshot.value as? Int{
                self.total_users = usersNumber
            }
        })
        
        self.ref.child("Users").observe(DataEventType.value, with: { (snapshot) in
            if let new_users = snapshot.value as? [[String : Any]] {
                if (new_users.count != self.users.count){
                    let new_user = new_users[new_users.count-1]
                    self.users[new_user["ID"] as! String] = User(new_user)
                }
            }
        })
    }
    
    func setupGesture(){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        edgePan.edges = .left
        self.view.addGestureRecognizer(edgePan)
    }
    
    func setupViews(){
        let screenSize: CGRect = UIScreen.main.bounds
        let top: CGFloat = screenSize.width == 375 ? 15 : -1
        view.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        self.delegate2 = headerView
        view.addSubview(headerView)
        yContraint = headerView.centerYAnchor.constraint(equalTo: collectionView.topAnchor, constant: 298.6)
        lContraint = headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        rContraint = headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        NSLayoutConstraint.activate([
            yContraint!,
            lContraint!,
            rContraint!,
            headerView.heightAnchor.constraint(equalToConstant: CGFloat(headerViewHeight)) //130
            ])
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        view.addSubview(sectionTitleIndexCollectionView)
        NSLayoutConstraint.activate([
            sectionTitleIndexCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            sectionTitleIndexCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sectionTitleIndexCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sectionTitleIndexCollectionView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }

}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            return 1
        } else {
            return (mealSections.count + 1) // added one section for MenuCell and InfoCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            return mealSections.count
        } else {
            if (section == 0) {
                return 1 //2
            }
            else if (section == 3){
                return self.reviews.count + 1 // padding
            }
            else{
                let rows = Meal.loadMealsForSection(sectionName: mealSections[section-1], meals: meals)
                return rows.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionTitleIndexCell", for: indexPath) as! SectionTitleIndexCollectionViewCell
            cell.sectionTitle = mealSections[indexPath.row]
            return cell
        } else {
            if (indexPath.section == 0) && (indexPath.row == 0) {
                let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! InfoCollectionViewCell
                    infoCell.infoButtonCallback = {() -> () in
                        self.present(self.infoViewController, animated: true, completion: nil)
                }
                infoCell.chef = self.users[self.food_item!.user]
                return infoCell
            }
//            } else if (indexPath.section == 0) && (indexPath.row == 1) {
//                let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCollectionViewCell
//                return menuCell
//            }
            else if (indexPath.section == 1) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCollectionViewCell
//                let rows = Meal.loadMealsForSection(sectionName: mealSections[(indexPath.section-1)], meals: meals)
//                cell.meal = rows[indexPath.row]
                cell.nameLabel.text = self.food_item?.notes   
                return cell
            }
            else if (indexPath.section == 2){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoDetailCell", for: indexPath) as! InfoDetailCollectionViewCell
//                let rows = Meal.loadMealsForSection(sectionName: mealSections[(indexPath.section-1)], meals: meals)
//                cell.meal = rows[indexPath.row]
                cell.info = self.food_item
                return cell
            }
            else{
                if (indexPath.row < self.reviews.count){
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCollectionViewCell
    //                let rows = Meal.loadMealsForSection(sectionName: mealSections[(indexPath.section-1)], meals: meals)
                    cell.review = self.reviews[indexPath.row]
                    cell.user = self.users[self.reviews[indexPath.row].user]
                    if (indexPath.row == self.reviews.count - 1){
                        cell.last = true
                    }
                    else{
                        cell.last = false
                    }
                    return cell
                }
                else{
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyReviewCell", for: indexPath) as! EmptyReviewCollectionViewCell
                    return cell
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            let text = mealSections[indexPath.row]
            let length = text.count
//            return CGSize(width: (length*10), height: 40)
            return CGSize(width: 130, height: 40)
        } else {
            if (indexPath.section == 0) && (indexPath.row < 2) {
                return indexPath.row == 0 ?  CGSize(width: view.frame.width, height: 160) : CGSize(width: view.frame.width, height: 50) //120
            }
            else if (indexPath.section == 1){
                return CGSize(width: view.frame.width, height: 90)
            }
            else if (indexPath.section == 2){
                return CGSize(width: view.frame.width, height: 150)
            }
            else{
                if (indexPath.row < self.reviews.count){
                    let height = heightForView(text: self.reviews[indexPath.row].comment, font: UIFont(name: "Comfortaa-Regular", size: 14)!, width: view.frame.width - 30)
                    return CGSize(width: view.frame.width, height: 121 + height)
                }
                else{
                    return CGSize(width: view.frame.width, height: 30)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == self.sectionTitleIndexCollectionView) {
            // note: do nothing
        } else {
            updateHeaderImage(scrollView)
            updateHeaderView(scrollView)
            updateHeaderViewLabel(scrollView)
        }
    }
    
    fileprivate func updateHeaderImage(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        //print(pos)
        if (pos < 0){
            delegate?.updateImageHeight(height: (298.6-pos)) /* screenWidth*0.79625 = 298.6 */
            delegate?.updateImageTopAnchorConstraint(constant: (pos))
        }
    }
    
    fileprivate func updateHeaderView(_ scrollView: UIScrollView){
        let pos = scrollView.contentOffset.y
        let pec = 1 - (pos)/241 //194
        
        
        if pos == 0 {
            yContraint?.constant = 298.6
        }
        if (pos > 0) && (pos < 241){ //234
            yContraint?.constant = 298.6 - pos
            lContraint?.constant = 30 * pec // 30
            rContraint?.constant = -(30 * pec) // 30
        }
        if pos < 0 {
            yContraint?.constant = 298.6 - pos
        }
        if pos > 241 { //234
            yContraint?.constant = CGFloat((headerViewHeight/2))
            
            backButton.setImage(#imageLiteral(resourceName: "back-black").withRenderingMode(.alwaysOriginal), for: .normal)
            sectionTitleIndexCollectionView.isHidden = false
            
            scrollView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        } else {
            sectionTitleIndexCollectionView.isHidden = true
            backButton.setImage(#imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysOriginal), for: .normal)
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    fileprivate func updateHeaderViewLabel(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if (pos > -44) && (pos < 241) { //164
            delegate2?.updateHeaderViewLabelOpacity(constant: pos)
            delegate2?.updateHeaderViewLabelSize(constant: pos)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            let emptyCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionTitleIndexEmptyCell", for: indexPath)
            emptyCell.frame.size.height = 0
            emptyCell.frame.size.width = 0
            return emptyCell
        } else {
            if (kind == UICollectionView.elementKindSectionHeader) && (indexPath.section == 0) && (indexPath.row == 0) {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeader", for: indexPath) as! DetailHeaderCollectionViewCell
                header.coverImageView.image = self.food_item?.image
                self.delegate = header
                return header
            } else if (kind == UICollectionView.elementKindSectionHeader) && (indexPath.section != 0) {
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeaderView
                sectionHeader.title = mealSections[indexPath.section-1]
                if (indexPath.section == 3){
                    sectionHeader.addReviewButton.isHidden = false
                    sectionHeader.delegate = self
                }
                else{
                    sectionHeader.addReviewButton.isHidden = true
                }
                return sectionHeader
            } else {
                let emptyCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyCell", for: indexPath)
                emptyCell.frame.size.height = 0
                emptyCell.frame.size.width = 0
                return emptyCell
            }
        }

    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            return CGSize(width: 0, height: 0)
        } else {
            return section == 0 ? CGSize(width: view.frame.width, height: view.frame.width*0.79625) : CGSize(width: view.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            let row = indexPath.row
            let indx = IndexPath(item: 0, section: row+1)
            self.collectionView.selectItem(at: indx, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
        }
//        } else {
//            let mealItemViewController = MealItemViewController()
//            present(mealItemViewController, animated: true, completion: nil)
//        }
    }
}
protocol CoverImageDelegate {
    func updateImageHeight(height:CGFloat)
    func updateImageTopAnchorConstraint(constant: CGFloat)
}

protocol HeaderViewDelegate {
    func updateHeaderViewLabelOpacity(constant: CGFloat)
    func updateHeaderViewLabelSize(constant: CGFloat)
}

extension DetailViewController /* Section deals with dismiss animator */ {
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: {
            
        })
    }
    
    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {

        let percentThreshold:CGFloat = 0.3
        
        // convert x-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let horizontalMovement = translation.x / view.bounds.width
        let rightMovement = fmaxf(Float(horizontalMovement), 0.0)
        let rightMovementPercent = fminf(rightMovement, 1.0)
        let progress = CGFloat(rightMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    
    func showHelperCircle(){
        let center = CGPoint(x: 10, y: view.bounds.width * 0.5)
        let small = CGSize(width: 30, height: 30)
        let circle = UIView(frame: CGRect(origin: center, size: small))
        circle.layer.cornerRadius = circle.frame.width/2
        circle.backgroundColor = UIColor.white
        circle.layer.shadowOpacity = 0.8
        circle.layer.shadowOffset = CGSize()
        view.addSubview(circle)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [],
            animations: {
                circle.frame.origin.x += 200
                circle.layer.opacity = 0
        },
            completion: { _ in
                circle.removeFromSuperview()
        }
        )
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        showHelperCircle()
//    }
}

extension DetailViewController : UIViewControllerTransitioningDelegate {
   
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
//        return DismissAnimator()
//    }
}

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}

extension DetailViewController:showAddReviewDelegate{
    func showAddReview() {
        if (Auth.auth().currentUser != nil) {
            let vc = AddReviewController(nibName: "AddReviewController", bundle: nil)
            vc.food_id = self.food_id
            if (CurrentUser.needUpdate){
                let new_user = [
                    "Allergies": CurrentUser.allergies,
                    "Average_Rating": CurrentUser.average_Rating,
                    "Chef_label": CurrentUser.chef_label,
                    "Chef_name": CurrentUser.chef_name,
                    "Food_items": [0], //need to revise
                    "ID": CurrentUser.uid,
                    "Name": CurrentUser.name,
                    "Reviews": "",
                    "Total_Ratings": CurrentUser.total_ratings,
                    "photoURL": CurrentUser.photoURL?.absoluteString,
                    "Index": self.total_users
                ] as [String : Any]
                CurrentUser.index = self.total_users
                self.ref.child("Users").child(String(self.total_users)).setValue(new_user)
                self.ref.child("Total_users").setValue(self.total_users+1)
                CurrentUser.needUpdate = false
            }
            self.present(vc, animated: true, completion: nil)
        }
        else{
            let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
}

