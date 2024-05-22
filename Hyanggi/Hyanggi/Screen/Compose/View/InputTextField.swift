//
//  WriteTextField.swift
//  Hyanggi
//
//  Created by 김민 on 4/1/24.
//

import UIKit
import SnapKit
import Then

enum WriteTextFieldType {
    case date
    case text
}

final class InputTextField: BaseView {

    private let fieldNameLabel = UILabel()
    private let requiredLabel = UILabel()
    private let datePicker = UIDatePicker()
    let textField = UITextField()

    var fieldName: String
    var fieldType: WriteTextFieldType
    var isRequired: Bool

    init(fieldName: String, 
         fieldType: WriteTextFieldType = .text,
         isRequired: Bool = true,
         frame: CGRect = .zero) {
        self.fieldName = fieldName
        self.fieldType = fieldType
        self.isRequired = isRequired

        super.init(frame: frame)

        setDatePicker()
        setPickerToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Settings

    override func setViews() {
        fieldNameLabel.do {
            $0.text = fieldName
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
        }

        requiredLabel.do {
            $0.text = "*"
            $0.font = .systemFont(ofSize: 13, weight: .semibold)
            $0.textColor = .red

            $0.isHidden = isRequired ? false : true
        }

        textField.do {
            $0.font = .systemFont(ofSize: 15)
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.hyanggiGray.cgColor
            $0.leftView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 5,
                                               height: self.frame.height))
            $0.leftViewMode = .always
        }
    }

    override func setConstraints() {
        [fieldNameLabel, requiredLabel, textField].forEach {
            addSubview($0)
        }

        fieldNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        requiredLabel.snp.makeConstraints {
            $0.centerY.equalTo(fieldNameLabel)
            $0.leading.equalTo(fieldNameLabel.snp.trailing).offset(5)
        }

        textField.snp.makeConstraints {
            $0.top.equalTo(fieldNameLabel.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        if fieldType == .date {
            textField.inputView = datePicker
        }
    }

    private func setPickerToolBar() {
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0,
                               y: 0,
                               width: UIScreen.main.bounds.width,
                               height: 44)

        let doneButton = UIBarButtonItem(title: "done",
                                         style: .done,
                                         target: self,
                                         action: #selector(tappedDoneButton))
        let space = UIBarButtonItem(systemItem: .flexibleSpace)

        toolBar.items = [space, doneButton]

        if fieldType == .date {
            textField.inputAccessoryView = toolBar
        }
    }

    // MARK: - Actions

    @objc private func tappedCancelButton() {
        textField.resignFirstResponder()
    }

    @objc private func tappedDoneButton() {
        textField.text = datePicker.date.dateToString()
        textField.resignFirstResponder()
    }
}
