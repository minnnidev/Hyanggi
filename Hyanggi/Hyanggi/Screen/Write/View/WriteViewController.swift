//
//  WriteViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then

final class WriteViewController: BaseViewController {

    private let layoutView = WriteView()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addActions()
    }

    // MARK: - Settings

    override func setNavigationBar() {
        super.setNavigationBar()

        navigationController?.navigationBar.topItem?.title = "향기 추가"

        layoutView.completeButton.target = self
        layoutView.completeButton.action = #selector(tappedCompleteButton)
        layoutView.dismissButton.target = self
        layoutView.dismissButton.action = #selector(tappedDismissButton)

        navigationItem.rightBarButtonItems = [layoutView.completeButton]
        navigationItem.leftBarButtonItems = [layoutView.dismissButton]
    }

    // MARK: - Actions

    private func addActions() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tappedView))
        layoutView.scrollView.addGestureRecognizer(recognizer)
    }

    @objc private func tappedDismissButton() {
        dismissVC()
    }

    @objc private func tappedCompleteButton() {
        // Create Logic
        dismissVC()
    }

    @objc private func tappedView() {
        self.view.endEditing(true)
    }

    // MARK: - Methods

    private func dismissVC() {
        dismiss(animated: true)
    }
}
