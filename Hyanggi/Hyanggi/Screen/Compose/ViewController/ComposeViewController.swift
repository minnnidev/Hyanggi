//
//  ComposeVIewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import RxSwift
import RxKeyboard

final class ComposeViewController: BaseViewController, ViewModelBindableType {

    var viewModel: ComposeViewModel!

    private let layoutView = ComposeView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        hideKeyboard()
        updateLayoutWithKeyboardHeight()
    }

    func bindViewModel() {
        let input = ComposeViewModel.Input(
            dateText: layoutView.dateTextField.textField.rx.text.orEmpty.asObservable(),
            brandNameText: layoutView.brandTextField.textField.rx.text.orEmpty.asObservable(),
            perfumeNameText: layoutView.nameTextField.textField.rx.text.orEmpty.asObservable(),
            contentText: layoutView.contentTextView.rx.text.orEmpty.asObservable(),
            sentenceText: layoutView.sentenceTextField.textField.rx.text.orEmpty.asObservable(),
            dismissButtonTap: layoutView.dismissButton.rx.tap,
            completeButtonTap: layoutView.completeButton.rx.tap
        )

        let output = viewModel.transform(input: input)

        output.initialPerfume
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { vc, perfume in
                vc.layoutView.dateTextField.textField.text = perfume.date
                vc.layoutView.brandTextField.textField.text = perfume.brandName
                vc.layoutView.nameTextField.textField.text = perfume.perfumeName
                vc.layoutView.contentTextView.text = perfume.content
                vc.layoutView.sentenceTextField.textField.text = perfume.sentence
            })
            .disposed(by: disposeBag)

        output.dismissToPrevious
            .withUnretained(self)
            .bind { vc, _ in
                vc.dismiss(animated: true)
            }
            .disposed(by: disposeBag)

        output.isFormValid
            .bind(to: layoutView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

extension ComposeViewController {

    private func setNavigationBar() {
        navigationItem.title = "입력"
        navigationItem.leftBarButtonItem = layoutView.dismissButton
        navigationItem.rightBarButtonItem = layoutView.completeButton
    }

    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer()
        layoutView.scrollView.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }

    private func updateLayoutWithKeyboardHeight() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [unowned self] keyboardHeight in
                var contentInset = self.layoutView.scrollView.contentInset
                contentInset.bottom = keyboardHeight

                self.layoutView.scrollView.contentInset = contentInset
            })
            .disposed(by: disposeBag)
    }
}
