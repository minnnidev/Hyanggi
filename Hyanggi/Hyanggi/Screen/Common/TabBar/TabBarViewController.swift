//
//  TabBarViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private let storage: PerfumeStorageType

    init(storage: PerfumeStorageType = PerfumeStorage()) {
        self.storage = storage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let homeViewModel = HomeViewModel(title: "향기", storage: storage)
        var homeViewController = HomeViewController()
        homeViewController.bind(viewModel: homeViewModel)

        let searchViewModel = SearchPerfumeViewModel(title: "검색", storage: storage)
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
