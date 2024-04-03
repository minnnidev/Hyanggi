//
//  WriteViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then

class WriteViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Settings

    override func setNavigationBar() {
        super.setNavigationBar()

        navigationController?.navigationBar.topItem?.title = "향기 추가"

        let completeButton = UIBarButtonItem(title: "완료",
                                             style: .plain,
                                             target: self,
                                             action: #selector(tappedCompleteButton))

        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tappedDismissButton))

        navigationItem.rightBarButtonItems = [completeButton]
        navigationItem.leftBarButtonItems = [dismissButton]
    }

    // MARK: - Actions

    @objc private func tappedDismissButton() {
        dismissVC()
    }

    @objc private func tappedCompleteButton() {
        // Create Logic
        dismissVC()
    }

    // MARK: - Methods

    private func dismissVC() {
        dismiss(animated: true)
    }
}
