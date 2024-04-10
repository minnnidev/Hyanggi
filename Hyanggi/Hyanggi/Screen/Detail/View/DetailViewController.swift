//
//  DetailViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

class DetailViewController: BaseViewController {

    private let layoutView = DetailView()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Settings

    override func setNavigationBar() {
        navigationItem.rightBarButtonItems = [layoutView.ellipsisButton, layoutView.wishButton]
    }
}
