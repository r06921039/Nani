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
        vc.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "home-page-50"), selectedImage: #imageLiteral(resourceName: "home-page-filled-50"))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.view.backgroundColor = .white
        self.setViewControllers([
            homeViewController], animated: true)
    }
}
