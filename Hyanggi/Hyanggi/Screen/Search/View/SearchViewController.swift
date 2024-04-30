//
//  SearchViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import RxSwift
import SnapKit
import Then

final class SearchViewController: BaseViewController {

    private let layoutView = SearchView()
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        bindings()
    }

    override func setNavigationBar() {
        super.setNavigationBar()

        navigationItem.title = "검색"
    }

    private func setCollectionView() {
        layoutView.searchCollectionView.delegate = self

        layoutView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }

    private func bindings() {
        viewModel.searchResult
            .bind(to: layoutView.searchCollectionView.rx.items(cellIdentifier: SearchCollectionViewCell.identifier, cellType: SearchCollectionViewCell.self)) { index, item, cell in
                cell.binding(item)
            }
            .disposed(by: disposeBag)

        layoutView.searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.searchPerfumes(query)
            })
            .disposed(by: disposeBag)
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
