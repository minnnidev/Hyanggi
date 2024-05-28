//
//  ComposeVIewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import RxSwift
import RxKeyboard

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
        hideKeyboard()
        updateLayoutWithKeyboardHeight()
    }

    func bindViewModel() {
        layoutView.addPhotoButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.pick()
            })
            .disposed(by: disposeBag)

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
            .bind(to: viewModel.completeAction)
            .disposed(by: disposeBag)

        viewModel.completeAction
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.initialPerfume
            .compactMap { $0 }
            .drive(with: self, onNext: { vc, perfume in
                vc.layoutView.dateTextField.textField.text = perfume.date
                vc.layoutView.brandTextField.textField.text = perfume.brandName
                vc.layoutView.nameTextField.textField.text = perfume.perfumeName
                vc.layoutView.contentTextView.text = perfume.content
                vc.layoutView.sentenceTextField.textField.text = perfume.sentence
            })
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

extension ComposeViewController {

    private func setNavigationBar() {
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

    private func pick() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        picker.delegate = self

        present(picker, animated: true)
    }
}

extension ComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage? = nil

        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }

        layoutView.photoView.image = newImage
        layoutView.addPhotoButton.isHidden = true
        
        picker.dismiss(animated: true, completion: nil)
    }
}
