//
//  BaseViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        setNavigationBar()
        setView()
        setLayout()
    }

    func setBackgroundColor() {
        view.backgroundColor = UIColor.backgroundColor
    }

    func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
    }

    func setView() { }
    func setLayout() { }
}
