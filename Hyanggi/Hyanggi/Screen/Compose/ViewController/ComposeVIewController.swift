//
//  ComposeVIewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class ComposeVIewController: BaseViewController, ViewModelBindableType {

    var viewModel: ComposePerfumeViewModel!

    private let layoutView = ComposeView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }

    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = layoutView.dismissButton
        navigationItem.rightBarButtonItem = layoutView.completeButton
    }

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        layoutView.dismissButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
