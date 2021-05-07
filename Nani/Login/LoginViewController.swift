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

class LoginViewController: UIViewController, GIDSignInDelegate{
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
            print(authResult?.user.photoURL)
          }
    }
    
    @IBOutlet weak var LoginLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ForgetButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var NewHereLabel: UILabel!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var GoogleSignInButton: GIDSignInButton!
    @IBOutlet weak var FacebookSignInButton: UIView!
    @IBOutlet weak var AppleSignInButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        setupViews()
        //GIDSignIn.sharedInstance().signIn()
        //var loginButton = GIDSignInButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        
        
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
