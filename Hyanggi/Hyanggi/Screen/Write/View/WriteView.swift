//
//  WriteView.swift
//  Hyanggi
//
//  Created by 김민 on 4/3/24.
//

import UIKit
import SnapKit
import Then

final class WriteView: BaseView {
    let completeButton = UIBarButtonItem()
    let dismissButton = UIBarButtonItem()
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()
    private let dateTextField = WriteTextField(fieldName: "시향 날짜", fieldType: .date)
    private let brandTextField = WriteTextField(fieldName: "브랜드")
    private let nameTextField = WriteTextField(fieldName: "향수 이름")
    private let contentLabel = UILabel()
    private let contentTextView = UITextView()
    private let sentenceTextField = WriteTextField(fieldName: "이 향수를 한 마디로 표현한다면")

    override func setViews() {
        completeButton.do {
            $0.title = "완료"
        }

        dismissButton.do {
            $0.image = UIImage(systemName: "xmark")
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

        [dateTextField, brandTextField, nameTextField, contentLabel, contentTextView, sentenceTextField].forEach {
            contentView.addSubview($0)
        }

        dateTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
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
