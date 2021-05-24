//
//  LoginViewController.swift
//  Nani
//
//  Created by Jeff on 2021/5/6.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FBSDKCoreKit
import SwiftSpinner

class LoginViewController: UIViewController, GIDSignInDelegate, UITextFieldDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          // ...
          return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        // ...
          
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
              let authError = error as NSError
              // ...
              print(authError)
              return
            }
            // User is signed in
            // ...
            //print(authResult?.user.photoURL)
//            let url = URL(string: (authResult?.user.photoURL!.absoluteString)!)
//            CurrentUser.photoURL = url
//            CurrentUser.chef_name = (authResult?.user.displayName)!
//            CurrentUser.name = (authResult?.user.displayName)!
//            CurrentUser.uid = (authResult?.user.uid)!
//            CurrentUser.didLogin = true
//            UserDefaults.standard.set(url, forKey: "photoURL")
//            UserDefaults.standard.set(CurrentUser.chef_name, forKey: "chef_name")
//            UserDefaults.standard.set(CurrentUser.name, forKey: "name")
//            UserDefaults.standard.set(CurrentUser.uid, forKey: "uid")
//            UserDefaults.standard.set(CurrentUser.didLogin, forKey: "didLogin")
//            UserDefaults.standard.synchronize()
//            CurrentUser.needUpdate = self.users[CurrentUser.uid] == nil
            self.updateUserDefault((authResult?.user.photoURL!.absoluteString)!, (authResult?.user.displayName)!, (authResult?.user.uid)!)
            if (CurrentUser.needUpdate){
                let new_user = [
                    "Allergies": [0],
                    "Average_Rating": 0,
                    "Chef_label": "Newbie",
                    "Chef_name": CurrentUser.chef_name,
                    "Food_items": [0], //need to revise
                    "ID": CurrentUser.uid,
                    "Name": CurrentUser.name,
                    "Reviews": "",
                    "Total_Ratings": 0,
                    "photoURL": CurrentUser.photoURL?.absoluteString,
                    "Index": self.total_users
                ] as [String : Any]
                CurrentUser.index = self.total_users
                self.ref.child("Users").child(String(self.total_users)).setValue(new_user)
                self.ref.child("Total_users").setValue(self.total_users+1)
                CurrentUser.needUpdate = false
            }
            self.dismiss(animated: true, completion: nil)
          }
    }
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    var users: [String: User] = [:]
    var total_users: Int = 0
    var errorMessage: String?
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var LoginLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    
    @IBOutlet weak var ForgetButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var NewHereLabel: UILabel!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var GoogleSignInButton: GIDSignInButton!
    @IBOutlet weak var FacebookSignInButton: UIView!
    @IBOutlet weak var AppleSignInButton: UIView!
    @IBAction func signIn(_ sender: Any) {
        if let email = EmailTextField.text, let password = PasswordTextField.text{
            SwiftSpinner.show(delay: 0.0, title: "Login to your account...", animated: true)
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
              // ...
                guard let user = authResult?.user, error == nil else {
                    print(error?.localizedDescription)
                    print(error?.localizedDescription.count)
                    if (error?.localizedDescription.count == 61){
                        strongSelf.errorMessage = "The password is invalid"
                    }
                    else if(error?.localizedDescription.count == 89){
                        strongSelf.errorMessage = "No user record corresponding to this identifier."
                    }
                    else{
                        strongSelf.errorMessage = error?.localizedDescription ?? ""
                    }
                    SwiftSpinner.show(strongSelf.errorMessage!, animated: false).addTapHandler({
                        SwiftSpinner.hide()
                    }, subtitle: "Tap to continue")
                    return
                }
                strongSelf.updateUserDefault((authResult?.user.photoURL!.absoluteString)!, (authResult?.user.displayName)!, (authResult?.user.uid)!)
                print("CurrentUser.uid \(CurrentUser.uid)")
                print("CurrentUser.photoURL \(CurrentUser.photoURL)")
                print("CurrentUser.name \(CurrentUser.name)")
                SwiftSpinner.show("Login account successfully!", animated: false).addTapHandler({
                    SwiftSpinner.hide()
                    strongSelf.dismiss(animated: true, completion: nil)
                }, subtitle: "Tap to continue")
            }
        }
    }
    
    
    @IBAction func emailEndEditing(_ sender: Any) {
    }
    @IBAction func passwordEndEditing(_ sender: Any) {
    }
    @IBAction func register(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        //checkIfUserIsSignedIn()
        setupViews()
        getData()
//        hideKeyboardWhenTappedAround()
        //GIDSignIn.sharedInstance().signIn()
        //var loginButton = GIDSignInButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
//        NotificationCenter.default.addObserver(self,selector:#selector(self.keyboardWillShow),name:UIResponder.keyboardDidShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide),name:UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    func setupViews(){
        self.view.backgroundColor = hexStringToUIColor(hex: "#575759")
        
        LoginLabel.font = UIFont(name: "Comfortaa-Bold", size: 36)
        LoginLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        EmailLabel.font = UIFont(name: "Comfortaa-Regular", size: 14)
        EmailLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        PasswordLabel.font = UIFont(name: "Comfortaa-Regular", size: 14)
        PasswordLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        EmailTextField.setBorder()
        EmailTextField.textColor = .white
        EmailTextField.font = UIFont(name: "Comfortaa-Regular", size: 14)
        PasswordTextField.setBorder()
        PasswordTextField.textColor = .white
        PasswordTextField.font = UIFont(name: "Comfortaa-Regular", size: 14)
        PasswordTextField.isSecureTextEntry = true
        
        ForgetButton.setTitle("Forget Password?", for: .normal)
        ForgetButton.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 14)
        ForgetButton.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        
        GoogleSignInButton.style = .iconOnly
        
        NewHereLabel.text = "New Here?"
        NewHereLabel.font = UIFont(name: "Comfortaa-Regular", size: 16)
        NewHereLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        let attributedText = NSAttributedString(string: "Register", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        RegisterButton.setAttributedTitle(attributedText, for: .normal)
        RegisterButton.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        RegisterButton.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        
        LoginButton.setTitle("Login", for: .normal)
        LoginButton.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        LoginButton.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 24)
        LoginButton.backgroundColor = hexStringToUIColor(hex: "#575759")
        LoginButton.layer.cornerRadius = 5
        LoginButton.layer.borderWidth = 1
        LoginButton.layer.borderColor = hexStringToUIColor(hex: "#F0B357").cgColor
        
    }
    
    func getData(){
        self.ref.child("Users").observe(DataEventType.value, with: { (snapshot) in
            if let new_users = snapshot.value as? [[String : Any]] {
                self.users = [:]
                for user in new_users {
                    self.users[user["ID"] as! String] = User(user)
                }
                
            }
        })
        
        self.ref.child("Total_users").observe(DataEventType.value, with: { (snapshot) in
            if let usersNumber = snapshot.value as? Int{
                self.total_users = usersNumber
            }
        })
    }
    
    private func checkIfUserIsSignedIn() {

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed in
                // go to feature controller
                print(user?.uid)
                print(user?.email)
                print(user?.displayName)
                print(user?.photoURL)
            } else {
                 // user is not signed in
                 // go to login controller
                print("not login")
            }
        }
    }
    
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
}

extension UITextField {
    func setBorder() {
        //self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.borderColor = hexStringToUIColor(hex: "#F0B357").cgColor
        self.layer.cornerRadius = 8
        self.backgroundColor = hexStringToUIColor(hex: "#575759")
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = hexStringToUIColor(hex: "#F0B357").cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//extension LoginViewController{
//
//
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if keyboardAdjusted == false {
//            lastKeyboardOffset = getKeyboardHeight(notification: notification) / 2
//            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
//                self.view.frame.origin.y -= self.lastKeyboardOffset
//            }, completion: nil)
//            keyboardAdjusted = true
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if keyboardAdjusted == true {
//            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
//                self.view.frame.origin.y += self.lastKeyboardOffset
//            }, completion: nil)
//            keyboardAdjusted = false
//        }
//    }
//
//    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
//        let userInfo = notification.userInfo
//        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
//        return keyboardSize.cgRectValue.height
//    }
//
//}

extension LoginViewController:RegisterDelegate{
    func dismissLogin() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController{
    func updateUserDefault(_ url:String, _ name:String, _ uid:String){
        let photoURL = URL(string: url)
        CurrentUser.photoURL = photoURL
        CurrentUser.chef_name = name
        CurrentUser.name = name
        CurrentUser.uid = uid
        CurrentUser.didLogin = true
        if let current_user = self.users[CurrentUser.uid]{
            CurrentUser.food_items = current_user.food_items
            CurrentUser.index = current_user.index
            CurrentUser.chef_label = current_user.chef_label
            CurrentUser.average_Rating = current_user.average_rating
            CurrentUser.allergies = current_user.allergies
            CurrentUser.chef_label = current_user.chef_label
            CurrentUser.reviews = current_user.reviews ?? [0]
            UserDefaults.standard.set(CurrentUser.food_items, forKey: "food_items")
            UserDefaults.standard.set(CurrentUser.chef_label, forKey: "chef_label")
            UserDefaults.standard.set(CurrentUser.average_Rating, forKey: "rating")
            UserDefaults.standard.set(CurrentUser.allergies, forKey: "allergies")
        }
        UserDefaults.standard.set(url, forKey: "photoURL")
        UserDefaults.standard.set(CurrentUser.chef_name, forKey: "chef_name")
        UserDefaults.standard.set(CurrentUser.name, forKey: "name")
        UserDefaults.standard.set(CurrentUser.uid, forKey: "uid")
        UserDefaults.standard.set(CurrentUser.didLogin, forKey: "didLogin")
        UserDefaults.standard.synchronize()
        CurrentUser.needUpdate = self.users[CurrentUser.uid] == nil
    }
}
