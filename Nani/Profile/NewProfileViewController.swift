//
//  NewProfileViewController.swift
//  Nani
//
//  Created by Jeff on 2021/5/25.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import SwiftSpinner

class NewProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentUser: User?
    var users: [String: User] = [:]
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.checkIfUserIsSignedIn()
        self.getData()
    }
    
    func setupViews(){
        let nibEdit = UINib.init(nibName: "EditImageViewCell", bundle: nil)
        self.tableView.register(nibEdit, forCellReuseIdentifier: "EditImageViewCell")
        let nibImage = UINib.init(nibName: "UserImageCell", bundle: nil)
        self.tableView.register(nibImage, forCellReuseIdentifier: "UserImageCell")
        let nibInfo = UINib.init(nibName: "UserInfoViewCell", bundle: nil)
        self.tableView.register(nibInfo, forCellReuseIdentifier: "UserInfoViewCell")
        let nibMoney = UINib.init(nibName: "MoneyOrderViewCell", bundle: nil)
        self.tableView.register(nibMoney, forCellReuseIdentifier: "MoneyOrderViewCell")
        let nibAction = UINib.init(nibName: "ActionViewCell", bundle: nil)
        self.tableView.register(nibAction, forCellReuseIdentifier: "ActionViewCell")
        let nibLogout = UINib.init(nibName: "LogoutViewCell", bundle: nil)
        self.tableView.register(nibLogout, forCellReuseIdentifier: "LogoutViewCell")
        self.tableView.estimatedRowHeight = 180
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
//        self.tableView.allowsSelection = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditImageViewCell", for: indexPath) as! EditImageViewCell
//            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            return cell
        }
        else if (indexPath.section == 0 && indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserImageCell", for: indexPath) as! UserImageCell
//            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            if CurrentUser.didLogin && self.currentUser != nil{
                cell.chef = self.currentUser
            }
            return cell
        }
        else if indexPath.section == 0 && indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoViewCell", for: indexPath) as! UserInfoViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyOrderViewCell", for: indexPath) as! MoneyOrderViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionViewCell", for: indexPath) as! ActionViewCell
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutViewCell", for: indexPath) as! LogoutViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // UIView with darkGray background for section-separators as Section Footer
        let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 0.5))
        v.backgroundColor = .lightGray
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Section Footer height
        if section == 3{
            return 0
        }
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section != 2{
            return indexPath
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3{
            self.signOut()
            self.tableView.cellForRow(at: indexPath)?.isSelected = false
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return 180
//        }
//        else if indexPath.row == 1{
//            return 160
//        }
//        else{
//            return 120
//        }
//    }
}

extension NewProfileViewController{
    func signOut(){
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
    
    private func checkIfUserIsSignedIn() {

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // user is signed in
                // go to feature controller
                //print(user?.photoURL)
                print(user?.uid)
                print(user?.displayName)
                print(user?.photoURL)
//                if let displayName = user?.displayName{
//                    self.userName.text = user?.displayName
//                }
//                else{
//                    self.userName.text = "nani"
//                }
//                if let photoURL = user?.photoURL{
//                    let url = URL(string: (user?.photoURL!.absoluteString)!)
//                    self.profileImage.kf.setImage(with: url)
//                }
//                else{
//                    self.profileImage.image = UIImage(named: "Logo")
//                }
                self.currentUser = self.users[user!.uid]
                self.tableView.reloadData()
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
    
    override func viewDidAppear(_ animated: Bool) {
        if !CurrentUser.didLogin{
            let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.userName.text = Auth.auth().currentUser?.displayName
//        if let photoURL = Auth.auth().currentUser?.photoURL{
//            let url = URL(string: (Auth.auth().currentUser?.photoURL!.absoluteString)!)
//            self.profileImage.kf.setImage(with: url)
//        }
//        else{
//            self.profileImage.image = UIImage(named: "Logo")
//        }
        self.tableView.reloadData()
    }
    
    func getData(){
        SwiftSpinner.show("Connecting \nto User Profile...")
        self.ref.child("Users").observe(DataEventType.value, with: { (snapshot) in
            if let new_users = snapshot.value as? [[String : Any]] {
                self.users = [:]
                for user in new_users {
                    self.users[user["ID"] as! String] = User(user)
                }
                if CurrentUser.didLogin{
                    self.currentUser = self.users[Auth.auth().currentUser!.uid]
                    self.tableView.reloadData()
                }
                SwiftSpinner.hide()
            }
        })
    }
}
