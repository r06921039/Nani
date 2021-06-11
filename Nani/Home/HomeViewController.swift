//
//  HomeViewController.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//

import UIKit
import Firebase
import SwiftSpinner
import Kingfisher
//import Crashlytics

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

//    @IBOutlet var collectionView_storyboard: UICollectionView!
    lazy var bizs: [Biz] = []
    lazy var filteredBizs: [Biz] = []
    lazy var isFiltered: Bool = false
    
    var item: HomeViewCell!
    var itemFrame: CGRect!
    var food_item: FoodCard!
    let interactor = Interactor()
    var selectedFrame: CGRect?
    var navAddressTitle: String = "2590 N Moreland Blvd"
    var mealSections: [String] = Meal.loadFoodSections()
    var foodCard: [Int: FoodCard] = [:]
    var allergens: [String] = []
    var foodTags: [String] = []
    var users: [String: User] = [:]
    var reviews: [Review] = []
    var total_items: Int = 0
    var total_users: Int = 0
    var total_food_tags: [Int] = []
    var initialFoodCard: [Int: FoodCard] = [:]
    
    var ref = Database.database().reference()
    let storage = Storage.storage(url: "gs://nani-e9074.appspot.com")
   
    var isLoading = false
    var loadingPostNum = 5
    var offset = 0
    var isSearching = false
    var isFiltering = false
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
//        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }()
    

//    lazy var onbardingViewController: OnboardingViewController = {
//        let vc = OnboardingViewController()
//        vc.delegate = self
//        return vc
//    }()
    
    lazy var grayBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 0.75)
        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeFilterView)))
        return view
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "button-filter").withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = UIColor(red: 240/255, green: 237/255, blue: 240/255, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.clipsToBounds = true
        button.layer.cornerRadius = button.layer.frame.height/2
//        button.addTarget(self, action: #selector(showFilterView), for: .touchUpInside)
        return button
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nani.today?"
        label.font = UIFont(name: "Comfortaa-Bold", size: 20)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var userButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        let photo = UIImage(named: "Logo")
        if CurrentUser.photoURL == URL(string: ""){
            button.setImage(photo, for: .normal)
        }
        else{
            button.kf.setImage(with: CurrentUser.photoURL, for: .normal)
        }
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        let screenSize: CGRect = UIScreen.main.bounds
        let offset = screenSize.width == 375 ? 30 : 0
        bar.frame = CGRect(x: 0, y: 130 - offset, width: Int(screenSize.width), height: 70)
        bar.showsCancelButton = false
        bar.searchBarStyle = UISearchBar.Style.default
        bar.placeholder = " What are you looking for?"
        bar.layer.borderWidth = 1
        bar.layer.borderColor = UIColor.white.cgColor
        bar.sizeToFit()
        return bar
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
        cv.isHidden = false
        return cv
    }()
    
    private let footerView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
//    lazy var filterViewController: FilterViewController = {
//        let vc = FilterViewController()
//        vc.transitioningDelegate = self
//        return vc
//    }()
    
//    @objc func showFilterView() {
//
//        filterViewController.modalPresentationStyle = .overCurrentContext
//        filterViewController.delegate = self
//        present(filterViewController, animated: true) {
//            self.view.addSubview(self.grayBackgroundView)
//
//        }
//    }
    
//    @objc func closeFilterView() {
//        print("closeFilterView")
//        self.filterViewController.dismiss(animated: true) {
//            self.grayBackgroundView.removeFromSuperview()
//        }
//    }
    
//    @objc func showLocationView() {
//        print("showLocationView")
//        let locationViewController: LocationViewController = LocationViewController()
//        locationViewController.delegate = self
//        navigationController?.present(locationViewController, animated: true, completion: nil)
//    }
    
//    func setFilterOptions(opts: [String], enable: Bool) {
//        filteredBizs = bizs.filter({ (biz) -> Bool in
//            return ( biz.review_count! > 500 )
//        })
//        print(filteredBizs)
//        isFiltered = enable
//        collectionView?.reloadData()
//    }

//    @objc func handleRefresh() {
//        print("handleRefresh")
//        let userDefaults = UserDefaults.standard
//        if let apiKey = userDefaults.object(forKey: "bearToken") as? String {
//            let apiClient = APIClient(apiKey)
//            apiClient.refreshBearToken()
//            apiClient.yelpBusinesses(term: "coffee", lat: 38.906377, long: -77.034788) { (results) in
//                if results.error == nil {
//                    let businesses = apiClient.parseBusinesses(result: results)
//                    self.bizs = businesses
//                    self.collectionView?.reloadData()
//                } else {
//                    print(results.error?.localizedDescription as Any)
//                }
//                self.refreshControl.endRefreshing()
//            }
//        }
//
//    }
    
    func generateMockData() {
        var b = Biz()
        b.name = "On the Rise"
        b.price = "$$"
        b.url = ""
        b.review_count = 10
        bizs.append(b)
        bizs.append(b)
        bizs.append(b)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        view.endEditing(true)
    }
    
    func testGetData(){
        SwiftSpinner.show(delay: 0.0, title: "Connecting \nto Nani...", animated: true)
        
        self.ref.child("Allergens").observe(DataEventType.value, with: { (snapshot) in
            if let allergens = snapshot.value as? [String]{
                self.allergens = allergens
            }
        })
        
        self.ref.child("Food_Tags").observe(DataEventType.value, with: { (snapshot) in
            if let foodTags = snapshot.value as? [String]{
                self.foodTags = foodTags
            }
        })
        
        self.ref.child("Total_food_tags").observe(DataEventType.value, with: { (snapshot) in
            if let totalFoodTags = snapshot.value as? [Int]{
                self.total_food_tags = totalFoodTags
            }
        })
        
        self.ref.child("Total_items").observe(DataEventType.value, with: { (snapshot) in
            if let total_items = snapshot.value as? Int{
                self.total_items = total_items
                self.offset = self.total_items - self.loadingPostNum
                self.retrievePost(callFlag: true)
            }
        })
        
        self.ref.child("Total_users").observe(DataEventType.value, with: { (snapshot) in
            if let total_users = snapshot.value as? Int{
                self.total_users = total_users
            }
        })
        
        self.ref.child("Reviews").observe(DataEventType.value, with: { (snapshot) in
            if let reviews = snapshot.value as? [[String : Any]]{
                self.reviews = []
                for review in reviews{
                    self.reviews.append(Review(review))
                }
            }
        })
        
        self.ref.child("Users").observe(DataEventType.value, with: { (snapshot) in
            if let users = snapshot.value as? [[String : Any]] {
                self.users = [:]
                for user in users {
                    self.users[user["ID"] as! String] = User(user)
                }
                if let current_user = self.users[CurrentUser.uid]{
                    CurrentUser.food_items = current_user.food_items
                    CurrentUser.index = current_user.index
                    CurrentUser.chef_label = current_user.chef_label
                }
            }
        })
        
        
    }
    
//    func getData(){
//        SwiftSpinner.show(delay: 0.0, title: "Connecting \nto Nani...", animated: true)
//        var refHandle = self.ref.observe(DataEventType.value, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            if let total_items = postDict["Total_items"] as? Int{
//                self.total_items = total_items
//            }
//            if let total_users = postDict["Total_users"] as? Int{
//                self.total_users = total_users
//            }
//            if let allergens = postDict["Allergens"] as? [String]{
//                self.allergens = allergens
//            }
//            if let reviews = postDict["Reviews"] as? [[String : Any]]{
//                self.reviews = []
//                for review in reviews{
//                    self.reviews.append(Review(review))
//                }
//            }
//            if let users = postDict["Users"] as? [[String : Any]] {
//                self.users = [:]
//                for user in users {
//                    self.users[user["ID"] as! String] = User(user)
////                    if (self.foodCard.count == self.total_items && self.users.count == self.total_users){
////                        self.collectionView.reloadData()
////                        CurrentUser.needUpdate = self.users[CurrentUser.uid] != nil
////                        SwiftSpinner.hide()
////                    }
////                    let pathReference = self.storage.reference()
////                    let path = user["Picture"] as! String
////                    let islandRef = pathReference.child(path)
////                    islandRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
////                        if let error = error {
////                            print(error)
////                        // Uh-oh, an error occurred!
////                        }
////                        else {
////                        // Data for "images/island.jpg" is returned
////                            let image = UIImage(data: data!)
////                            self.users[user["ID"] as! String] = User(user)
////                            if (self.foodCard.count == self.total_items && self.users.count == self.total_users){
////                                self.collectionView.reloadData()
////                                SwiftSpinner.hide()
////                            }
////                        }
////                    }
//                }
//                if let current_user = self.users[CurrentUser.uid]{
//                    CurrentUser.food_items = current_user.food_items
//                    CurrentUser.index = current_user.index
//                    CurrentUser.chef_label = current_user.chef_label
//                }
//            }
//            if let items = postDict["Food_items"] as? [[String : Any]] {
//                self.foodCard = [:]
//                for item in items {
//                    let pathReference = self.storage.reference()
//                    let path = item["Picture"] as! String
//                    let islandRef = pathReference.child(path)
//                    islandRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
//                        if let error = error {
//                        print(error)
//                        // Uh-oh, an error occurred!
//                        }
//                        else {
//                        // Data for "images/island.jpg" is returned
//                            let image = UIImage(data: data!)
//                            var food = FoodCard(item, image!, self.allergens)
//                            self.foodCard[item["Order"] as! Int] = food
//                            if (self.foodCard.count == self.total_items && self.users.count == self.total_users){
//                                self.collectionView.reloadData()
//                                CurrentUser.needUpdate = self.users[CurrentUser.uid] == nil
//                                SwiftSpinner.hide()
//                            }
//                        }
//                    }
//
//                }
//            }
//        })
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        testGetData()
        //getData()
        // checkUserAuth()
        //setupAPIClient()
        //logUser()
        generateMockData()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.collectionView.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        for index in 0..<self.foodCard.count{
            var food = self.foodCard[index]
            food?.updateTime()
            self.foodCard[index] = food
        }
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func setupViews(){
        let screenSize: CGRect = UIScreen.main.bounds
        let leading: CGFloat = 20
        let top: CGFloat = screenSize.width == 375 ? 40 : 70
        self.view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top),
            nameLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
            nameLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -100),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        self.view.addSubview(userButton)
        NSLayoutConstraint.activate([
            userButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0),
            userButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            userButton.widthAnchor.constraint(equalToConstant: 50),
            userButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
            searchBar.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -leading),
//            searchBar.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func setupCollectionView()
    {
//        collectionView?.addSubview(refreshControl)
//        collectionView!.register(HorizontalViewCell.self, forCellWithReuseIdentifier: "HorizontalViewCell")
        self.collectionView.delegate = self
        self.collectionView!.register(HomeViewCell.self, forCellWithReuseIdentifier: "HomeViewCell")
        self.collectionView!.backgroundColor = UIColor(red: 240/255, green: 237/255, blue: 240/255, alpha: 1)
        self.collectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView!.contentInsetAdjustmentBehavior = .never
        NSLayoutConstraint.activate([
            self.collectionView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 190),
            self.collectionView!.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.collectionView!.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.collectionView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
        view.addSubview(sectionTitleIndexCollectionView)
        NSLayoutConstraint.activate([
            sectionTitleIndexCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            sectionTitleIndexCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            sectionTitleIndexCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            sectionTitleIndexCollectionView.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        self.collectionView.register(CollectionViewFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")

    }
    
//    func setupViews(){
//        // navigation title
//        let attributedText = NSMutableAttributedString(string: navAddressTitle, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)])
//        let titleLabel = UILabel()
//        titleLabel.attributedText = attributedText
//        navigationItem.titleView = titleLabel
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(showLocationView))
//        navigationItem.titleView?.isUserInteractionEnabled = true
//        navigationItem.titleView?.addGestureRecognizer(recognizer)
//        navigationController?.navigationBar.isTranslucent = false
//        let barButtonItem = UIBarButtonItem(customView: filterButton)
//        navigationItem.setRightBarButton(barButtonItem, animated: true)
//        filterButton.anchor(top: nil, left: nil, right: nil, bottom: nil,
//                            paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0,
//                            width: 30, height: 30)
//    }
    
//    func setupAPIClient() {
//        let userDefaults = UserDefaults.standard
//        if let apiKey = userDefaults.object(forKey: "bearToken") as? String {
//            let apiClient = APIClient(apiKey)
//            apiClient.refreshBearToken()
//            apiClient.yelpBusinesses(term: "pizza", lat: 38.906377, long: -77.034788) { (results) in
//                if results.error == nil {
//                    let businesses = apiClient.parseBusinesses(result: results)
//                    self.bizs = businesses
//                    self.collectionView?.reloadData()
//                } else {
//                    print(results.error?.localizedDescription as Any)
//                }
//            }
//        }
//    }
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
//        Crashlytics.sharedInstance().setUserEmail("sezhang@aarp.org")
//        Crashlytics.sharedInstance().setUserIdentifier("12345")
//        Crashlytics.sharedInstance().setUserName("Test User")
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            return mealSections.count
        }
        
//        return isFiltered ? filteredBizs.count : bizs.count
        return self.foodCard.count
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if (indexPath.section == 0) {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalViewCell", for: indexPath)
//            return cell
//        } else {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionTitleIndexCell", for: indexPath) as! SectionTitleIndexCollectionViewCell
            cell.sectionTitle = mealSections[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        //cell.biz = isFiltered ? filteredBizs[indexPath.row] : bizs[indexPath.row]
        cell.food = self.foodCard[self.total_items - 1 - indexPath.row]
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if section == 0 {
//            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.sectionTitleIndexCollectionView) {
            let text = mealSections[indexPath.row]
            let length = text.count
//            return CGSize(width: (length*10), height: 40)
            return CGSize(width: 130, height: 40)
        }
        return CGSize(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get the cell frame
        if (collectionView == self.sectionTitleIndexCollectionView){
            self.filter(indexPath.row)
        }
        else{
            let attributes = collectionView.layoutAttributesForItem(at: indexPath)
            self.itemFrame = attributes!.frame
            self.item = collectionView.cellForItem(at: indexPath) as! HomeViewCell
            self.food_item = self.foodCard[self.total_items - 1 - indexPath.row]
            
            let detailViewController = DetailViewController()
            detailViewController.transitioningDelegate = self
            detailViewController.interactor = self.interactor
            detailViewController.modalPresentationStyle = .overFullScreen
            detailViewController.users = self.users
            detailViewController.food_item = self.foodCard[self.total_items - 1 - indexPath.row]
            detailViewController.food_id = self.foodCard[self.total_items - 1 - indexPath.row]?.order
            var temp: [Review] = []
            for index in self.foodCard[self.total_items - 1 - indexPath.row]!.reviews{
                temp.append(self.reviews[index])
            }
            detailViewController.reviews = temp
    //        navigationController?.present(detailViewController, animated: true, completion: nil)
            present(detailViewController, animated: true, completion: nil)
    //        navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

}

//extension HomeViewController: UINavigationControllerDelegate {
//    /*
//        For making the pushed viewcontroller into a full screen mode, custom animation can be used here
//        most of cases, please present the view controller modally. Animators can be found in the following
//        files:
//            - InfoAnimatedTransition.swift
//            - SZAnimatedTransition.swift
//    */
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if (toVC.self is DetailViewController) || (fromVC.self is DetailViewController) {
//            if (toVC.self is InfoViewController) || (fromVC.self is InfoViewController){
//                switch operation {
//                case .push:
//                    return InfoAnimatedTransition(duration: 0.5, isPresenting: true)
//                default:
//                    return InfoAnimatedTransition(duration: 0.5, isPresenting: false)
//                }
//            } else {
//                guard let frame = self.selectedFrame else { return nil }
//                let businessArtwork: UIImageView = UIImageView(image: #imageLiteral(resourceName: "tennesse_taco_co"))
//                switch operation {
//                case .push:
//                    return SZAnimatedTransition(duration: 0.5, isPresenting: true, originFrame: frame, image: businessArtwork.image!)
//                default:
//                    return SZAnimatedTransition(duration: 0.5, isPresenting: false, originFrame: frame, image: businessArtwork.image!)
//                }
//            }
//        }
//        return nil
//    }
//}
//
extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if (presented == self.filterViewController) {
//            return PresentAnimator2()
//        }
        return PresentAnimator(item: item, itemFrame: itemFrame, food_item: food_item)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension HomeViewController: AddViewDelegate{
    func getAllergens(delegatedFrom viewController: AddViewController) {
        viewController.allergensTable = allergens
        viewController.total_items = self.total_items
        viewController.total_users = self.total_users
        viewController.foodTagsTable = self.foodTags
        viewController.total_food_tags = self.total_food_tags
    }
}
//
//extension HomeViewController: NavAddressDelegate {
//    func setAddress(address: String) {
//        navAddressTitle = address
//        setupViews()
//    }
//}
//
//extension HomeViewController: OnboardingDelegate {
//    func checkUserAuth(){
//        let userDefault = UserDefaults.standard
//        let isSignedin = userDefault.bool(forKey: "isSignedin")
//        if (!isSignedin) {
//            print("user isn't signed in yet")
//            present(onbardingViewController, animated: true, completion: nil)
//        } else {
//            print("user has signed in already")
//            onbardingViewController.dismiss(animated: true, completion: nil)
//        }
//    }
//}
//

extension HomeViewController{
    override func viewWillAppear(_ animated: Bool) {
        if CurrentUser.photoURL == URL(string: ""){
            let photo = UIImage(named: "Logo")
            self.userButton.setImage(photo, for: .normal)
        }
        else{
            self.userButton.kf.setImage(with: CurrentUser.photoURL, for: .normal)
        }
        print("needupdate \(CurrentUser.needUpdate)")
        print("foodItems \(CurrentUser.food_items)")
        print("index \(CurrentUser.index)")
    }
}

extension HomeViewController{
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter && collectionView != self.sectionTitleIndexCollectionView  {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
                footer.addSubview(footerView)
                footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 55)
                return footer
            }
        return UICollectionReusableView()
        }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter{
            self.footerView.startAnimating()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter{
            self.footerView.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading || collectionView == self.sectionTitleIndexCollectionView || self.isSearching || self.isFiltering{
            return CGSize.zero
        }
        else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.foodCard.count - 1 && !self.isLoading && !self.isSearching && !self.isFiltering{
            loadMoreData()
        }
    }
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            self.retrievePost(callFlag: true)
        }
    }
}


extension HomeViewController{
    func retrievePost(callFlag: Bool){
        var updateOffset = callFlag
        var refHandle = self.ref.child("Food_items").queryOrderedByKey().queryStarting(atValue: String(self.offset)).queryLimited(toFirst: UInt(self.loadingPostNum)).observe(DataEventType.value, with: {(snapshot) in
            var count = 0
            for child in snapshot.children {
                if let value = (child as! DataSnapshot).value as? [String: Any]{
                    let pathReference = self.storage.reference()
                    let path = value["Picture"] as! String
                    let islandRef = pathReference.child(path)
                    islandRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
                        if let error = error {
                        print(error)
                        // Uh-oh, an error occurred!
                        }
                        else {
                        // Data for "images/island.jpg" is returned
                            let image = UIImage(data: data!)
                            var food = FoodCard(value, image!, self.allergens)
                            count += 1
                            self.foodCard[value["Order"] as! Int] = food
                            if count == self.loadingPostNum{
                                if updateOffset {
                                    self.offset = self.offset - self.loadingPostNum > 0 ? self.offset - self.loadingPostNum : 0
                                    updateOffset = false
                                }
                                self.initialFoodCard = self.foodCard
                                self.collectionView.reloadData()
                                CurrentUser.needUpdate = self.users[CurrentUser.uid] == nil
                                SwiftSpinner.hide()
                                if self.foodCard.count != self.total_items{
                                    self.isLoading = false
                                }
                            }
                        }
                    }
                }
            }
            })
    }
}

extension HomeViewController{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""{
            self.isSearching = false
            self.isFiltering = false
            self.foodCard = self.initialFoodCard
            self.collectionView.reloadData()
        }
    }
    
    func search(){
        var temp: [Int : [String : Any]] = [:]
        var offset = 0
        var count = 0
        
        self.isSearching = true
        self.foodCard = [:]
        var searchText = self.searchBar.text!.prefix(1).capitalized + self.searchBar.text!.dropFirst()
        
        SwiftSpinner.show(delay: 0.0, title: "Searching \nin Nani...", animated: true)
        
        var refHandle = self.ref.child("Food_items").queryOrdered(byChild: "Title").queryStarting(atValue: searchText).observe(DataEventType.value, with: {(snapshot) in
            for child in snapshot.children {
                if let value = (child as! DataSnapshot).value as? [String: Any]{
                    temp[self.total_items - 1 - offset] = value
                    offset += 1
                }
            }
            if temp.count == 0{
                self.collectionView.reloadData()
                SwiftSpinner.hide()
            }
            for (key, value) in temp{
                let pathReference = self.storage.reference()
                let path = value["Picture"] as! String
                let islandRef = pathReference.child(path)
                islandRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
                    if let error = error {
                    print(error)
                    // Uh-oh, an error occurred!
                    }
                    else {
                    // Data for "images/island.jpg" is returned
                        let image = UIImage(data: data!)
                        var food = FoodCard(value, image!, self.allergens)
                        self.foodCard[key] = food
                        count += 1
                        if count == temp.count{
                            self.collectionView.reloadData()
                            SwiftSpinner.hide()
                        }
                    }
                }
            }
            
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search()
        view.endEditing(true)
    }
}

extension HomeViewController{
    func filter(_ index: Int){
        var realIndex = index
        if index == 3{
            realIndex = 14
        }
        
        self.isFiltering = true
        var temp:[Int] = []
        self.foodCard = [:]
        var count = 0
        SwiftSpinner.show(delay: 0.0, title: "Filtering", animated: true)
        
        var refHandler = self.ref.child("Food_items_by_Food_Tags").child(String(realIndex)).observe(DataEventType.value, with: {(snapshot) in
            if let keys = snapshot.value as? [Int]{
                for key in keys{
                    temp.append(key)
                }
            }
            temp = temp.reversed()
            
            if !(temp.count == 1 && temp[0] == -1){
                for (index, key) in temp.enumerated(){
                    self.ref.child("Food_items").child(String(key)).observe(DataEventType.value, with: {(snapshot) in
                        if let value = snapshot.value as? [String:Any]{
                            let pathReference = self.storage.reference()
                            let path = value["Picture"] as! String
                            let islandRef = pathReference.child(path)
                            islandRef.getData(maxSize: 1 * 2048 * 2048) { data, error in
                                if let error = error {
                                print(error)
                                // Uh-oh, an error occurred!
                                }
                                else {
                                // Data for "images/island.jpg" is returned
                                    let image = UIImage(data: data!)
                                    var food = FoodCard(value, image!, self.allergens)
                                    self.foodCard[self.total_items - 1 - index] = food
                                    count += 1
                                    if count == temp.count{
                                        self.collectionView.reloadData()
                                        SwiftSpinner.hide()
                                    }
                                }
                            }
                        }
                    })
                }
            }
            else{
                self.collectionView.reloadData()
                SwiftSpinner.hide()
            }
        })
        
//        var refHandle = self.ref.child("Food_items").child("0").observe(DataEventType.value, with: {(snapshot) in
//            print(snapshot.value)
//        })
    }
}

public class CollectionViewFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeViewController:MessagesControllerDelegate{
    func getUsers(delegatedFrom viewController: MessagesController) {
        viewController.users = self.users
    }
}
