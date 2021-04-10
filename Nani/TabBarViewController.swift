//
//  TabBarViewController.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//

import UIKit

class TabBarController: UITabBarController {
    
//    lazy var homeNavController: UINavigationController = {
//        let nav = UINavigationController(rootViewController: self.homeViewController)
//        return nav
//    }()
    
    lazy var homeViewController: HomeViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = HomeViewController(collectionViewLayout: layout)
//        vc.collectionView_s
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "filter_rating"), selectedImage: #imageLiteral(resourceName: "filter_rating"))
        return vc
    }()
    
    lazy var addViewController: UIViewController = {
        let vc = AddViewController()
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "button-plus"), selectedImage: #imageLiteral(resourceName: "button-plus"))
        return vc
    }()
    
    lazy var profileViewController: UIViewController = {
        let vc = UIViewController()
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
            profileViewController], animated: true)
    }
}
