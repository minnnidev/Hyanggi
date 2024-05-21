//
//  HomeView.swift
//  Hyanggi
//
//  Created by 김민 on 4/10/24.
//

import UIKit

class HomeView: BaseView {

    let plusButton = UIBarButtonItem()
    var wishButton = UIBarButtonItem()
    let testPapersCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout())

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
    }

    override func setConstraints() {
        [testPapersCollectionView].forEach {
            addSubview($0)
        }

        testPapersCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-80)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
