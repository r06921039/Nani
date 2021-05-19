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
            let url = URL(string: (authResult?.user.photoURL!.absoluteString)!)
            CurrentUser.photoURL = url
            CurrentUser.chef_name = (authResult?.user.displayName)!
            CurrentUser.name = (authResult?.user.displayName)!
            CurrentUser.uid = (authResult?.user.uid)!
            CurrentUser.didLogin = true
            UserDefaults.standard.set(url, forKey: "photoURL")
            UserDefaults.standard.set(CurrentUser.chef_name, forKey: "chef_name")
            UserDefaults.standard.set(CurrentUser.name, forKey: "name")
            UserDefaults.standard.set(CurrentUser.uid, forKey: "uid")
            UserDefaults.standard.set(CurrentUser.didLogin, forKey: "didLogin")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion: nil)
          }
    }
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
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
    @IBAction func signOut(_ sender: Any) {
        self.signOut()
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
    }
    @IBAction func passwordEndEditing(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        //checkIfUserIsSignedIn()
        setupViews()
        
        hideKeyboardWhenTappedAround()
        //GIDSignIn.sharedInstance().signIn()
        //var loginButton = GIDSignInButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        NotificationCenter.default.addObserver(self,selector:#selector(self.keyboardWillShow),name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide),name:UIResponder.keyboardDidHideNotification, object: nil)
        
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
        PasswordTextField.setBorder()
        
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

extension LoginViewController{
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification) / 2
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.view.frame.origin.y -= self.lastKeyboardOffset
            }, completion: nil)
            keyboardAdjusted = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.view.frame.origin.y += self.lastKeyboardOffset
            }, completion: nil)
            keyboardAdjusted = false
        }
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}
