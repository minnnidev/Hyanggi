//
//  HomeView.swift
//  Hyanggi
//
//  Created by 김민 on 4/10/24.
//

import UIKit

final class HomeView: BaseView {
    let plusButton = UIBarButtonItem()
    let wishButton = UIBarButtonItem()
    let testPapersCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout())
    let emptyView = UIStackView()
    private let emptyImageView = UIImageView()
    private let emptyLabel = UILabel()

    override func setViews() {
        plusButton.do {
            $0.image = UIImage(systemName: "plus")
            $0.tintColor = .black
        }

        wishButton.do {
            $0.image = UIImage(systemName: "heart")
            $0.tintColor = .black
        }

        testPapersCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .backgroundColor
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }

        emptyImageView.do {
            $0.image = UIImage(named: "icn_trans")
        }

        emptyLabel.do {
            $0.text = "시향지를 추가해 주세요"
            $0.font = .systemFont(ofSize: 15)
        }

        emptyView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fill
            $0.isHidden = true
        }
    }

    override func setConstraints() {
        [emptyImageView, emptyLabel].forEach {
            emptyView.addArrangedSubview($0)
        }

        [testPapersCollectionView, emptyView].forEach {
            addSubview($0)
        }

        testPapersCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-80)
            $0.leading.trailing.equalToSuperview()
        }

        emptyImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }

        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
