//
//  ProfileViewController.swift
//  Nani
//
//  Created by Jeff on 2021/5/18.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var signOut: UIButton!
    var handle: AuthStateDidChangeListenerHandle?
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        UserDefaults.standard.removeObject(forKey: "photoURL")
        CurrentUser.didLogin = false
        UserDefaults.standard.set(false, forKey: "didLogin")
        print(CurrentUser.didLogin)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkIfUserIsSignedIn()
        self.setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !CurrentUser.didLogin{
            let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userName.text = Auth.auth().currentUser?.displayName
        if let photoURL = Auth.auth().currentUser?.photoURL{
            let url = URL(string: (Auth.auth().currentUser?.photoURL!.absoluteString)!)
            self.profileImage.kf.setImage(with: url)
        }
        else{
            self.profileImage.image = UIImage(named: "Logo")
        }
    }
    
    private func checkIfUserIsSignedIn() {

        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed in
                // go to feature controller
                //print(user?.photoURL)
                print(user?.uid)
                print(user?.displayName)
                print(user?.photoURL)
                if let displayName = user?.displayName{
                    self.userName.text = user?.displayName
                }
                else{
                    self.userName.text = "nani"
                }
                if let photoURL = user?.photoURL{
                    let url = URL(string: (user?.photoURL!.absoluteString)!)
                    self.profileImage.kf.setImage(with: url)
                }
                else{
                    self.profileImage.image = UIImage(named: "Logo")
                }
            } else {
                 // user is not signed in
                 // go to login controller
                print("not login")
//                let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
//                loginViewController.modalPresentationStyle = .fullScreen
//                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
    
    func setupViews(){
        self.signOut.setTitle("Logout", for: .normal)
        
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.masksToBounds = false
        self.profileImage.layer.borderColor = UIColor.black.cgColor
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        self.profileImage.clipsToBounds = true
    }
}
