//
//  RegisterViewController.swift
//  Nani
//
//  Created by Jeff on 2021/5/22.
//

import Foundation
import UIKit
import Firebase
import SwiftSpinner

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
    var errorMessage: String?
    var total_users: Int = 0
    var ref = Database.database().reference()
    var defaultURL:String = "https://scontent-lga3-1.xx.fbcdn.net/v/t1.6435-9/187552709_107267058216864_4571187083831167402_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=IT82WeQs2pAAX_vatr4&_nc_ht=scontent-lga3-1.xx&oh=59a89c3b0bacd63a98dade524bf38864&oe=60D03A38"
    
    @IBAction func login(_ sender: Any) {
        self.dismissView()
    }
    @IBAction func register(_ sender: Any) {
        if (fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty){
            let alertController = UIAlertController(title: "Error", message:
                                                        "Full name must be provided", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            SwiftSpinner.show(delay: 0.0, title: "Creating \nnew account...", animated: true)
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard let user = authResult?.user, error == nil else {
                        print(error?.localizedDescription)
                        self.errorMessage = error?.localizedDescription ?? ""
                        if (self.errorMessage!.count == 55){
                            self.errorMessage = "The email address is already in use."
                        }
                        SwiftSpinner.show(self.errorMessage!, animated: false).addTapHandler({
                            SwiftSpinner.hide()
                        }, subtitle: "Tap to continue")
                        return
                    }
                    print("\(user.email!) created")
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.fullNameTextField.text ?? "nani"
                    changeRequest?.photoURL = URL(string: self.defaultURL)
                    changeRequest?.commitChanges { (error) in
                      // ...
                    }
                    SwiftSpinner.show("Create account successfully!", animated: false).addTapHandler({
                        SwiftSpinner.hide()
                        self.uploadUser(user.uid, self.fullNameTextField.text!, self.defaultURL)
                        self.dismissView()
                        self.delegate?.dismissLogin()
                        }, subtitle: "Tap to continue")
                    
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.getData()
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
        fullNameTextField.textColor = .white
        fullNameTextField.font = UIFont(name: "Comfortaa-Regular", size: 14)
        emailTextField.setBorder()
        emailTextField.textColor = .white
        emailTextField.font = UIFont(name: "Comfortaa-Regular", size: 14)
        passwordTextField.setBorder()
        passwordTextField.textColor = .white
        passwordTextField.font = UIFont(name: "Comfortaa-Regular", size: 14)
        passwordTextField.isSecureTextEntry = true
        
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
    
    func getData(){
        self.ref.child("Total_users").observe(DataEventType.value, with: { (snapshot) in
            if let usersNumber = snapshot.value as? Int{
                self.total_users = usersNumber
            }
        })
    }
    
    func uploadUser(_ uid:String, _ name:String, _ photoURL:String){
        let new_user = [
            "Allergies": [0],
            "Average_Rating": 0,
            "Chef_label": "Newbie",
            "Chef_name": name,
            "Food_items": [0], //need to revise
            "ID": uid,
            "Name": name,
            "Reviews": "",
            "Total_Ratings": 0,
            "photoURL": photoURL,
            "Index": self.total_users
        ] as [String : Any]
        CurrentUser.index = self.total_users
        self.ref.child("Users").child(String(self.total_users)).setValue(new_user)
        self.ref.child("Total_users").setValue(self.total_users+1)
        CurrentUser.needUpdate = false
        CurrentUser.uid = uid
        CurrentUser.name = name
        CurrentUser.chef_name = name
        CurrentUser.didLogin = true
        UserDefaults.standard.set(URL(string:photoURL), forKey: "photoURL")
        UserDefaults.standard.set(CurrentUser.chef_name, forKey: "chef_name")
        UserDefaults.standard.set(CurrentUser.name, forKey: "name")
        UserDefaults.standard.set(CurrentUser.uid, forKey: "uid")
        UserDefaults.standard.set(CurrentUser.didLogin, forKey: "didLogin")
        UserDefaults.standard.synchronize()
    }
}
