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

        setTabBar()
        setTabBarAttributes()
    }

    func setTabBarAttributes() {
        tabBar.backgroundColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }

    func setTabBar() {
        let homeViewModel = HomeViewModel()
        var homeViewController = HomeViewController()
        homeViewController.bind(viewModel: homeViewModel)

        let searchViewModel = SearchPerfumeViewModel()
        var searchViewController = SearchViewController()
        searchViewController.bind(viewModel: searchViewModel)


        let homeVC = UINavigationController(rootViewController: homeViewController)
        let searchVC = UINavigationController(rootViewController: searchViewController)

        homeVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house"))
        searchVC.tabBarItem = UITabBarItem(title: nil,
                                           image: UIImage(systemName: "magnifyingglass"),
                                           selectedImage: UIImage(systemName: "magnifyingglass"))

        viewControllers = [homeVC, searchVC]
    }
}
