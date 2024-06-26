//
//  WriteView.swift
//  Hyanggi
//
//  Created by 김민 on 4/3/24.
//

import UIKit
import SnapKit
import Then

final class ComposeView: BaseView {
    let photoView = UIImageView()
    let addPhotoButton = UIButton()
    let completeButton = UIBarButtonItem()
    let dismissButton = UIBarButtonItem()
    let scrollView = UIScrollView(frame: .zero)
    let contentView = UIView()
    let dateTextField = InputTextField(fieldName: "시향 날짜",
                                               fieldType: .date,
                                               isRequired: false)
    let brandTextField = InputTextField(fieldName: "브랜드")
    let nameTextField = InputTextField(fieldName: "향수 이름")
    let contentLabel = UILabel()
    let contentTextView = UITextView()
    let sentenceTextField = InputTextField(fieldName: "이 향수를 한 마디로 표현한다면")
    let deletePhotoButton = UIButton()

    override func setViews() {
        photoView.do {
            $0.backgroundColor = UIColor.hyanggiGray
            $0.contentMode = .scaleAspectFit
        }

        addPhotoButton.do {
            $0.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
            $0.tintColor = .white
        }

        completeButton.do {
            $0.title = "완료"
            $0.tintColor = .black
        }

        dismissButton.do {
            $0.image = UIImage(systemName: "xmark")
            $0.tintColor = .black
        }

        contentLabel.do {
            $0.text = "향에 대한 기록"
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
        }

        contentTextView.do {
            $0.font = .systemFont(ofSize: 15)
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.hyanggiGray.cgColor
        }

        deletePhotoButton.do {
            $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            $0.tintColor = .black
            $0.isHidden = true
        }
    }

    override func setConstraints() {
        addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        [addPhotoButton, deletePhotoButton].forEach {
            photoView.addSubview($0)
        }

        [photoView, dateTextField, brandTextField, nameTextField, contentLabel, contentTextView, sentenceTextField].forEach {
            contentView.addSubview($0)
        }

        photoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(120)
        }

        addPhotoButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        deletePhotoButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().offset(10)
            $0.width.height.equalTo(30)
        }

        dateTextField.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }

        brandTextField.snp.makeConstraints {
            $0.top.equalTo(dateTextField.snp.bottom).offset(20)
            $0.leading.equalTo(dateTextField)
            $0.centerX.equalToSuperview()
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(brandTextField.snp.bottom).offset(20)
            $0.leading.equalTo(dateTextField)
            $0.centerX.equalToSuperview()
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.equalTo(dateTextField)
            $0.centerX.equalToSuperview()
        }

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
            $0.leading.equalTo(dateTextField)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
        }

        sentenceTextField.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(20)
            $0.leading.equalTo(dateTextField)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
