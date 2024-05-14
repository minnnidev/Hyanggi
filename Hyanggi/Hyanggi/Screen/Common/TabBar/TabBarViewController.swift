//
//  TabBarViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarAttributes()
        setTabBar()
    }

    func setTabBarAttributes() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }

    func setTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())

        homeVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house"))
        searchVC.tabBarItem = UITabBarItem(title: nil,
                                           image: UIImage(systemName: "magnifyingglass"),
                                           selectedImage: UIImage(systemName: "magnifyingglass"))

        viewControllers = [homeVC, searchVC]
    }
}
