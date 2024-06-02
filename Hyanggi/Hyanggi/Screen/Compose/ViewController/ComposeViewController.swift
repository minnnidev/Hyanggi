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
    private let selectedImageSubject = PublishSubject<UIImage?>()
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
            completeButtonTap: layoutView.completeButton.rx.tap,
            selectImage: selectedImageSubject
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

        output.selectedImage
            .withUnretained(self)
            .subscribe(onNext: { vc, image in
                vc.layoutView.photoView.image = image
            })
            .disposed(by: disposeBag)

        layoutView.photoView.rx.tapGesture
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.presentImagePicker()
            })
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

    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[.originalImage] as? UIImage {
            selectedImageSubject.onNext(selectedImage)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
