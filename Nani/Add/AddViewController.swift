//
//  AddViewController.swift
//  Nani
//
//  Created by Jeff on 2021/4/7.
//

import UIKit
import YPImagePicker
import Firebase
import SwiftSpinner

class AddViewController: UIViewController, UITextFieldDelegate{
    
    var dishName:String = ""
    var apt:String = ""
    var price:String = ""
    var totalServing:String = ""
    var expiryHour:String = ""
    var contains:[Int] = []
    var notes:String = ""
    var allergensTable:[String] = []
    var delegate: HomeViewController? = nil
    var image: Data? = nil
    var total_items: Int = 0
    var total_users: Int = 0
    var tBController: UITabBarController? = nil
    
    var buttonCell: DishContainsCollectionViewCell? = nil
    var needRefresh: Bool = false
    
    var ref = Database.database().reference()
    let storage = Storage.storage(url: "gs://nani-e9074.appspot.com")
    
    lazy var imageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View Info", for: UIControl.State.normal)
//        button.showsTouchWhenHighlighted = true
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)\
//        button.frame = CGRect(x: 160, y: 100, width: 40, height: 40)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.clipsToBounds = true
        let photo = UIImage(named: "nani_placeholder")
        button.clipsToBounds = true
        button.setImage(photo, for: .normal)
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.font = UIFont(name: "Comfortaa-Bold", size: 20)
        label.textColor = hexStringToUIColor(hex: "#F0B357")
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View Info", for: UIControl.State.normal)
//        button.showsTouchWhenHighlighted = true
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)\
//        button.frame = CGRect(x: 160, y: 100, width: 40, height: 40)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.clipsToBounds = true
        //let photo = UIImage(named: "nani_placeholder")
        //button.clipsToBounds = true
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 16)
        button.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        //button.setImage(photo, for: .normal)
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
        cv.register(ShortAddCollectionViewCell.self, forCellWithReuseIdentifier: "ShortCell")
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        cv.register(DishContainsCollectionViewCell.self, forCellWithReuseIdentifier: "DishContainsCell")
        cv.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "NoteCell")
//        cv.register(InfoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "InfoDetailCell")
//        cv.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCell")
//        cv.register(DetailHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeader")
//        cv.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
//        cv.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyCell")
        cv.contentInsetAdjustmentBehavior = .never
        cv.backgroundColor = .white
        cv.keyboardDismissMode = .onDrag
        return cv
    }()
    
    
    
    func setupView(){
        let top: CGFloat = 20
        let leading: CGFloat = 20
        let labelHeight: CGFloat = 20
        let labelWidth: CGFloat = 100
        
        //self.delegate?.getAllergens(delegatedFrom: self)
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: top),
            titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
            titleLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -leading),
            titleLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
//        self.view.addSubview(imageButton)
//        NSLayoutConstraint.activate([
//            imageButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: top),
//            imageButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
//            imageButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -leading),
//            imageButton.heightAnchor.constraint(equalToConstant: 250)
//            ])
//        imageButton.addTarget(self, action: #selector(showImagePicker(sender:)), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(confirmButtonTapped(sender:)), for: .touchUpInside)
        self.view.addSubview(uploadButton)
        NSLayoutConstraint.activate([
            uploadButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: top),
            //uploadButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
            uploadButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            uploadButton.heightAnchor.constraint(equalToConstant: labelHeight),
            uploadButton.widthAnchor.constraint(equalToConstant: labelWidth)
            ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.delegate?.getAllergens(delegatedFrom: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkIfUserIsSignedIn()
//        NotificationCenter.default.addObserver(self,selector:#selector(self.keyboardWillShow),name:UIResponder.keyboardDidShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide),name:UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {

            guard let userInfo = notification.userInfo,

                let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                else{
                    return

            }

            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.collectionView.contentInset = contentInset
        }, completion: nil)
        
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//               // if keyboard size is not available for some reason, dont do anything
//               return
//            }
//
//          // move the root view up by the distance of keyboard height
//        self.view.frame.origin.y = 0 - keyboardSize.height

    }

    @objc func keyboardWillHide(notification: Notification){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            self.collectionView.contentInset = UIEdgeInsets.zero
        }, completion: nil)
        
//        self.view.frame.origin.y = 0
    }

    
//    @objc func showImagePicker(sender: UIButton){
//        var config = YPImagePickerConfiguration()
//        config.isScrollToChangeModesEnabled = false
//        config.startOnScreen = YPPickerScreen.library
//        config.hidesStatusBar = false
//        config.icons.capturePhotoImage = UIImage(named: "Camera_Capture")!
//        config.colors.tintColor = hexStringToUIColor(hex: "#F0B357")
//        let picker = YPImagePicker(configuration: config)
//        picker.didFinishPicking { [unowned picker] items, _ in
//            if let photo = items.singlePhoto {
//                self.imageButton.setImage(photo.image, for: .normal)
//                self.imageButton.imageView!.contentMode = .scaleAspectFill
//            }
//            picker.dismiss(animated: true, completion: nil)
//        }
//        present(picker, animated: true, completion: nil)
//    }
    
    
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = hexStringToUIColor(hex: "#F0B357").cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}

extension UITextView {
    func setBottomBorder() {
        //self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.borderColor = hexStringToUIColor(hex: "#F0B357").cgColor
        self.layer.cornerRadius = 8
        self.isScrollEnabled = false
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = hexStringToUIColor(hex: "#F0B357").cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
    }
    
}

extension AddViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
            cell.delegate = self
            if (self.image == nil){
                cell.imageButton.setImage(UIImage(named: "nani_placeholder"), for: .normal)
            }
            return cell
        }
        if (indexPath.row == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! AddCollectionViewCell
            cell.delegate = self
            if (self.dishName == ""){
                cell.dishTextField.text = ""
            }
            return cell
        }
        else if (2 <= indexPath.row && indexPath.row <= 5){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortCell", for: indexPath) as! ShortAddCollectionViewCell
            cell.delegate = self
            switch indexPath.row {
            case 2:
                cell.dishLabel.text = "Your apartment"
                if (self.apt == ""){
                    cell.dishTextField.text = ""
                }
            case 3:
                cell.dishLabel.text = "Price per serving"
                cell.dishTextField.keyboardType = .decimalPad
                if (self.price == ""){
                    cell.dishTextField.text = ""
                }
            case 4:
                cell.dishLabel.text = "Total Serving"
                cell.dishTextField.keyboardType = .decimalPad
                if (self.totalServing == ""){
                    cell.dishTextField.text = ""
                    cell.dishTextField.keyboardType = .decimalPad
                }
            case 5:
                cell.dishLabel.text = "Expire in hours"
                cell.dishTextField.keyboardType = .decimalPad
                if (self.expiryHour == ""){
                    cell.dishTextField.text = ""
                }
            default:
                cell.dishLabel.text = ""
            }
            return cell
        }
        else if (indexPath.row == 6){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishContainsCell", for: indexPath) as! DishContainsCollectionViewCell
            cell.delegate = self
            self.buttonCell = cell
//            if (self.needRefresh){
//                cell.refresh()
//            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCollectionViewCell
            cell.dishLabel.text = "Notes to customers/caption:"
            cell.delegate = self
            if (self.notes == ""){
                cell.dishTextView.text = ""
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0){
            return CGSize(width: view.frame.width, height: 250)
        }
        if (indexPath.row == 6){
            return CGSize(width: view.frame.width, height: 200)
        }
        if (indexPath.row == 7){
            return CGSize(width: view.frame.width, height: 180)
        }
        return CGSize(width: view.frame.width, height: 80)
    }
}

extension AddViewController: CollectionViewCellDelegate {

    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: AddCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell), let text = textField.text {
            //print("textField text: \(text) from cell: \(indexPath))")
            dishName = text
//            textFieldsTexts[indexPath] = text
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: AddCollectionViewCell)  -> Bool {
        print("Validation action in textField from cell: \(String(describing: collectionView.indexPath(for: cell)))")
        return true
    }
    
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: ShortAddCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell), let text = textField.text {
            print("textField text: \(text) from cell: \(indexPath.row))")
            switch indexPath.row {
            case 2:
                apt = text
                break
            case 3:
                price = text
                break
            case 4:
                totalServing = text
                break
            case 5:
                expiryHour = text
                break
            default:
                break
            }
            
//            textFieldsTexts[indexPath] = text
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: ShortAddCollectionViewCell)  -> Bool {
        print("Validation action in textField from cell: \(String(describing: collectionView.indexPath(for: cell)))")
        return true
    }
    func collectionViewCell(valueChangedIn textView: UITextView, delegatedFrom cell: NoteCollectionViewCell){
        if let indexPath = collectionView.indexPath(for: cell), let text = textView.text {
            //print("textField text: \(text) from cell: \(indexPath))")
//            textFieldsTexts[indexPath] = text
            notes = text
        }
    }
    func collectionViewCell(selectOn button: UIButton){
        if let text = button.titleLabel?.text{
            let key = allergensTable.firstIndex(of: text)
            contains.append(key!)
        }
    }
    
    func collectionViewCell(deselectOn button: UIButton){
        if let text = button.titleLabel?.text{
            let key = allergensTable.firstIndex(of: text)
            if let index = contains.firstIndex(of: key!) {
                contains.remove(at: index)
            }
        }
    }

}

extension AddViewController: ButtonCollectionViewCellDelegate{
    func showImagePicker(sender: UIButton){
            var config = YPImagePickerConfiguration()
            config.isScrollToChangeModesEnabled = false
            config.startOnScreen = YPPickerScreen.library
            config.hidesStatusBar = false
            config.icons.capturePhotoImage = UIImage(named: "Camera_Capture")!
            config.colors.tintColor = hexStringToUIColor(hex: "#F0B357")
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    //let imageData = UIImage.jpegData(photo.image)
                    //print(type(of: photo.image.pngData()))
                    self.image = photo.image.jpeg(.low)
                    sender.setImage(photo.image, for: .normal)
                    sender.imageView!.contentMode = .scaleAspectFill
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
        }
}


extension AddViewController{
    
    func refresh(){
        self.dishName = ""
        self.apt = ""
        self.price = ""
        self.totalServing = ""
        self.expiryHour = ""
        self.contains = []
        self.notes = ""
        self.image = nil
        self.buttonCell?.refresh()
    }
    
    enum CreateBulletinError: String {
        case EmptyPicture = "Empty picture"
        case EmptyDishName = "Empty dish name"
        case EmptyApt = "Empty apartment number"
        case EmptyPrice = "Empty price per serving"
        case EmptyServings = "Empty total servings"
        case EmptyExpiry = "Empty expire in hours"
        case EmptyNotes = "Empty notes"
        case ErrorPrice = "Price should be numbers"
        case ErrorServings = "Total servings should be numbers"
        case ErrorExpiry = "Expire in hours should be numbers"
        case None = ""
    }
    
    func isContentValid() -> CreateBulletinError {
        if (self.image == nil) {
            return .EmptyPicture
        }
        if (self.dishName == ""){
            return .EmptyDishName
        }
        if (self.apt == ""){
            return .EmptyApt
        }
        if (self.price == ""){
            return .EmptyPrice
        }
        if (self.totalServing == ""){
            return .EmptyServings
        }
        if (self.expiryHour == ""){
            return .EmptyExpiry
        }
        if (self.notes == ""){
            return .EmptyNotes
        }
        if (!self.price.isInt){
            return .ErrorPrice
        }
        if (!self.totalServing.isInt){
            return .ErrorServings
        }
        if (!self.expiryHour.isInt){
            return .ErrorExpiry
        }
        
        return .None
    }
    
    func contentErrorAlert(checkResult: CreateBulletinError) {
        let alertController = UIAlertController(title: "Error", message:
                                                    checkResult.rawValue, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func confirmButtonTapped(sender: UIButton) {
        
        self.view.endEditing(true)
        let checkResult = isContentValid()
        switch checkResult {
        case .None:
            contentUploadConfirmAlert()
            break
        default:
            contentErrorAlert(checkResult: checkResult)
            break
        }
    }
    
    func contentUploadConfirmAlert() {
        let alertController = UIAlertController(title: "Alert", message:
                                                    "Ready to share?", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action) in
            self.uploadPost()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func uploadPost(){
        let foodId = self.total_items
        var new_food_items = CurrentUser.food_items as! [Int]
        new_food_items.append(foodId)
        CurrentUser.food_items = new_food_items
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var currentDate = Date()
        let realDate = dateFormatterGet.string(from: currentDate)
        let values = [
            "Chef_name": CurrentUser.chef_name,
            "Contains": self.contains,
            "Expiry_hours": Int(self.expiryHour),
            "Food_tags": [0,1],
            "Notes": self.notes,
            "Order": self.total_items,
            "Pickup": true,
            "Picture": "Foods/" + String(foodId) + ".jpeg",
            "Posted_time": realDate,
            "Price": Int(self.price),
            "Reviews": [0,1,2,3,4,5],
            "Room": self.apt,
            "Servings": Int(self.totalServing),
            "Title": self.dishName,
            "User": CurrentUser.uid
        ] as [String : Any]
        
        let new_user = [
            "Allergies": CurrentUser.allergies,
            "Average_Rating": CurrentUser.average_Rating,
            "Chef_label": CurrentUser.chef_label,
            "Chef_name": CurrentUser.chef_name,
            "Food_items": CurrentUser.food_items,
            "ID": CurrentUser.uid,
            "Name": CurrentUser.name,
            "Reviews": CurrentUser.reviews,
            "Total_Ratings": CurrentUser.total_ratings,
            "photoURL": CurrentUser.photoURL?.absoluteString,
            "Index": self.total_users
        ] as [String : Any]
        
        let storageRef = self.storage.reference()
        let imageRef = storageRef.child("Foods/" + String(foodId) + ".jpeg")
        SwiftSpinner.show("Sharing food!")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = imageRef.putData(self.image!, metadata: nil) { (metadata, error) in
            if let metadata = metadata{
                
                
                SwiftSpinner.show("Share food successfully!", animated: false).addTapHandler({
                    SwiftSpinner.hide()
                    self.ref.child("Food_items").child(String(foodId)).setValue(values)
                    self.ref.child("Total_items").setValue(self.total_items+1)
                    if CurrentUser.needUpdate{
                        CurrentUser.index = self.total_users
                        self.ref.child("Users").child(String(self.total_users)).setValue(new_user)
                        self.ref.child("Total_users").setValue(self.total_users+1)
                        CurrentUser.needUpdate = false
                    }
                    else{
                        self.ref.child("Users").child(String(CurrentUser.index)).child("Food_items").setValue(CurrentUser.food_items)
                    }
                    self.collectionView.reloadData()
                    self.sendPushNotification(title: self.dishName, body: "Click to have a bite!")
                    self.refresh()
                    self.tBController?.selectedIndex = 0
                      //self.performSegue(withIdentifier: "unwindAfterCreateBulletinPostSegue", sender: nil)
                  }, subtitle: "Tap to continue")
            }
            else {
            // Uh-oh, an error occurred!
            return
          }
          
          // Metadata contains file metadata such as size, content-type.
          //let size = metadata.size
          // You can also access to download URL after upload.
//          imageRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
        }
        
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

extension AddViewController{
    func sendPushNotification(title: String, body: String) {
            let urlString = "https://fcm.googleapis.com/fcm/send"
            let url = NSURL(string: urlString)!
            let paramString: [String : Any] = ["to" : "/topics/nani",
                                               "notification" : ["title" : title, "body" : body]
            ]
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("key=AAAA5LKR8qM:APA91bGXcgvgLobEOKcVJZ-Q3ke7OfSlWEvCiYi_Rk_ydAmcStttLzUWic_k-cellbMo-JxOdofBaM0BWKBllfyJz3-PI6UxmQVhu8lrd15PL4O8B_b3f0FAcjurYp73MhO0mucjga9o", forHTTPHeaderField: "Authorization")
            let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
                do {
                    if let jsonData = data {
                        if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                            NSLog("Received data:\n\(jsonDataDict))")
                        }
                    }
                } catch let err as NSError {
                    print(err.debugDescription)
                }
            }
            task.resume()
        }
}


extension AddViewController{
    private func checkIfUserIsSignedIn() {

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed in
                // go to feature controller
                //print(user?.photoURL)
            } else {
                 // user is not signed in
                 // go to login controller
                print("not login")
                let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
}
