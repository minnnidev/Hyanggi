//
//  BaseView.swift
//  Hyanggi
//
//  Created by 김민 on 4/3/24.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViews() { }

    func setConstraints() { }
}
