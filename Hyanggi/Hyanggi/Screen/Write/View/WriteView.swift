//
//  WriteView.swift
//  Hyanggi
//
//  Created by 김민 on 4/3/24.
//

import UIKit
import SnapKit
import Then

class WriteView: BaseView {
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()

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
    }
}
