//
//  TestPaperCell.swift
//  Hyanggi
//
//  Created by 김민 on 3/31/24.
//

import UIKit

final class TestPaperCell: UICollectionViewCell {

    static let identifier = "TestPaperCell"

    private let brandNameLabel = UILabel()
    private let perfumeNameLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        contentView.backgroundColor = .white

        brandNameLabel.do {
            $0.text = "딥디크"
            $0.font = .systemFont(ofSize: 15)
        }

        perfumeNameLabel.do {
            $0.text = "오 로즈"
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 17)
        }

        imageView.do {
            $0.backgroundColor = .systemGray4
        }
    }

    private func setLayout() {
        [brandNameLabel, perfumeNameLabel, imageView].forEach {
            contentView.addSubview($0)
        }

        brandNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }

        perfumeNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandNameLabel.snp.bottom).offset(3)
            $0.leading.equalTo(brandNameLabel)
            $0.centerX.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.leading.equalTo(brandNameLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
    }

    func binding(_ perfume: Perfume) {
        brandNameLabel.text = perfume.brandName
        perfumeNameLabel.text = perfume.perfumeName
    }
}
