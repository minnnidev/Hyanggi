//
//  SearchCollectionView.swift
//  Hyanggi
//
//  Created by 김민 on 4/4/24.
//

import UIKit
import SnapKit
import Then

final class SearchCollectionViewCell: UICollectionViewCell {

    static let identifier = "SearchCollectionView"

    private let titleLabel = UILabel()
    private let sentenceLabel = UILabel()
    private let contentLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        contentView.backgroundColor = .white
        
        titleLabel.do {
            $0.text = "딥디크 오로즈"
        }

        sentenceLabel.do {
            $0.text = "꽃맛이 날 것 같은 솜사탕 냄새"
        }

        contentLabel.do {
            $0.text = "akdjsfljdfkajdls;kfadfadjfkajwleijldkjalifjdlajfkesdakdjsflddajkfshakjsdhflkajhsdlkfjhalsdkjfrads"
            $0.numberOfLines = 0
        }

        [titleLabel, sentenceLabel, contentLabel].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }

    private func setConstraints() {
        [titleLabel, sentenceLabel, contentLabel].forEach {
            contentView.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }

        sentenceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.centerX.equalToSuperview()
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(sentenceLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
}
