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

final class ComposeViewController: BaseViewController, ViewModelBindableType {

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

        layoutView.completeButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.viewModel.createPerfume()
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)

        layoutView.dateTextField.textField
            .rx.text.orEmpty
            .bind(to: viewModel.dateRelay)
            .disposed(by: disposeBag)

        layoutView.brandTextField.textField
            .rx.text.orEmpty
            .bind(to: viewModel.brandNameRelay)
            .disposed(by: disposeBag)

        layoutView.nameTextField.textField
            .rx.text.orEmpty
            .bind(to: viewModel.perfumeNameRelay)
            .disposed(by: disposeBag)

        layoutView.contentTextView
            .rx.text.orEmpty
            .bind(to: viewModel.contentRelay)
            .disposed(by: disposeBag)

        layoutView.sentenceTextField.textField
            .rx.text.orEmpty
            .bind(to: viewModel.sentenceRelay)
            .disposed(by: disposeBag)

        viewModel.formValid
            .bind(to: layoutView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
