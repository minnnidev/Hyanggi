//
//  HomeViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }

    // MARK: - Settings

    func setNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "시향지 모음"

        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        let wishButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        navigationItem.rightBarButtonItems = [plusButton, wishButton]

        navigationController?.navigationBar.tintColor = .black
    }
}

