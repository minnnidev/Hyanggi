//
//  TestPaperCell.swift
//  Hyanggi
//
//  Created by 김민 on 3/31/24.
//

import UIKit
import RxSwift

final class TestPaperCell: UICollectionViewCell {

    static let identifier = "TestPaperCell"

    private let brandNameLabel = UILabel()
    private let perfumeNameLabel = UILabel()
    private let imageView = UIImageView()
    var disposeBag = DisposeBag()

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
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15)

        }

        perfumeNameLabel.do {
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 17)
        }

        imageView.do {
            $0.contentMode = .scaleAspectFit
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

    func dataBind(_ perfume: Perfume) {
        brandNameLabel.text = perfume.brandName
        perfumeNameLabel.text = perfume.perfumeName

        if let photoId = perfume.photoId {
            imageView.image = ImageFileManager.shared.loadImage(imageName: photoId)
        }
    }
}
