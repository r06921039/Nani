//
//  RegisterViewController.swift
//  Nani
//
//  Created by Jeff on 2021/5/22.
//

import Foundation
import UIKit
import Firebase

class RegisterViewController:UIViewController{
    
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alreadyMemberLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var delegate: LoginViewController?
    
    @IBAction func login(_ sender: Any) {
        self.dismissView()
    }
    @IBAction func register(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print(error)
                    return
                }
                print("\(user.email!) created")
//                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                changeRequest?.displayName = "nani"
//                changeRequest?.photoURL = URL(string: "https://drive.google.com/file/d/11f_9BHW552AH0ZZ1pqA-LM3hkssl92Wz/view?usp=sharing")
//                changeRequest?.commitChanges { (error) in
//                  // ...
//                }
                CurrentUser.didLogin = true
                self.dismissView()
                self.delegate?.dismissLogin()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    func setupViews(){
        self.view.backgroundColor = hexStringToUIColor(hex: "#575759")
        
        registerLabel.font = UIFont(name: "Comfortaa-Bold", size: 36)
        registerLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        emailLabel.font = UIFont(name: "Comfortaa-Regular", size: 14)
        emailLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        passwordLabel.font = UIFont(name: "Comfortaa-Regular", size: 14)
        passwordLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        fullNameLabel.font = UIFont(name: "Comfortaa-Regular", size: 14)
        fullNameLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        fullNameTextField.setBorder()
        emailTextField.setBorder()
        passwordTextField.setBorder()
        
        alreadyMemberLabel.text = "Already Member?"
        alreadyMemberLabel.font = UIFont(name: "Comfortaa-Regular", size: 16)
        alreadyMemberLabel.textColor = hexStringToUIColor(hex: "#F0B357")
        
        let attributedText = NSAttributedString(string: "Login", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        loginButton.setAttributedTitle(attributedText, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        loginButton.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 24)
        registerButton.backgroundColor = hexStringToUIColor(hex: "#575759")
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = hexStringToUIColor(hex: "#F0B357").cgColor
    }
    
    func dismissView(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
