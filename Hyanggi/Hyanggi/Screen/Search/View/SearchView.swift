//
//  SearchView.swift
//  Hyanggi
//
//  Created by 김민 on 4/10/24.
//

import UIKit

class SearchView: BaseView {

    let searchBar = UISearchBar()
    let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    override func setViews() {
        searchBar.do {
            $0.searchBarStyle = .minimal
        }

        searchCollectionView.do {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical

            $0.collectionViewLayout = flowLayout
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }

    override func setConstraints() {
        [searchBar, searchCollectionView].forEach {
            addSubview($0)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
