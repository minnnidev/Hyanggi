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
        setViews()
        setConstraints()
    }

    func setBackgroundColor() {
        view.backgroundColor = UIColor.backgroundColor
    }

    func setViews() { }
    func setConstraints() { }
}
