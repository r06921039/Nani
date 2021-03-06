//
//  TabBarViewController.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//

import UIKit

class TabBarController: UITabBarController {
    
    lazy var homeNavController: UINavigationController = {
        let nav = UINavigationController(rootViewController: self.homeViewController)
        return nav
    }()
    
    lazy var homeViewController: HomeViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = HomeViewController(collectionViewLayout: layout)
//        vc.collectionView_s
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "fried-egg-1"), selectedImage: #imageLiteral(resourceName: "fried-egg-1"))
        return vc
    }()
    
    lazy var messagesController: MessagesController = {
        
        let vc = MessagesController()
//        vc.collectionView_s
        vc.delegate = homeViewController
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "filter_hala"), selectedImage: #imageLiteral(resourceName: "filter_hala"))
        return vc
    }()
    
    lazy var addViewController: UIViewController = {
        let vc = AddViewController()
        vc.delegate = homeViewController
        vc.tBController = self
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "button-plus"), selectedImage: #imageLiteral(resourceName: "button-plus"))
        return vc
    }()
    
    lazy var profileViewController: UIViewController = {
//        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        let vc = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
//        let vc = AddReviewController(nibName: "AddReviewController", bundle: nil)
//        let vc = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        let vc = NewProfileViewController(nibName: "NewProfileViewController", bundle: nil)
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icons8-user-50"), selectedImage: #imageLiteral(resourceName: "icons8-user-50"))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = hexStringToUIColor(hex: "#F0B357")
        self.tabBar.tintColor = .white
        self.view.backgroundColor = .white
        self.setViewControllers([
            homeViewController,
            addViewController,
            UINavigationController(rootViewController: messagesController),
            profileViewController], animated: true)
    }
}
