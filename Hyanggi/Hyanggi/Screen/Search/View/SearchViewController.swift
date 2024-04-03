//
//  SearchViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then

final class SearchViewController: BaseViewController {

    private let searchCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout()).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical

        $0.collectionViewLayout = flowLayout
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
    }

    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }

    override func setNavigationBar() {
        super.setNavigationBar()

        navigationItem.title = "검색"
    }

    override func setViews() {
        searchBar.do {
            $0.searchBarStyle = .minimal
        }
    }

    override func setConstraints() {
        [searchBar, searchCollectionView].forEach {
            view.addSubview($0)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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

    func setCollectionView() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self

        searchCollectionView.register(SearchCollectionView.self, forCellWithReuseIdentifier: SearchCollectionView.identifier)
    }
}

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionView.identifier, for: indexPath) as? SearchCollectionView else { return UICollectionViewCell() }
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
