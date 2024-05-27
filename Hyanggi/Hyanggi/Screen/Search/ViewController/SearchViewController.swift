//
//  SearchViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then
import RxSwift

final class SearchViewController: BaseViewController, ViewModelBindableType {

    var viewModel: SearchPerfumeViewModel!

    private let layoutView = SearchView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        hideKeyboard()
    }

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        viewModel.filteredPerfumes
            .bind(to: layoutView.searchCollectionView.rx.items(cellIdentifier: SearchCollectionViewCell.identifier, cellType: SearchCollectionViewCell.self)) { row, elem, cell in
                cell.databind(elem)
            }
            .disposed(by: disposeBag)

        layoutView.searchBar.searchTextField
            .rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchTextRelay)
            .disposed(by: disposeBag)

        viewModel.filteredPerfumes
            .map { !$0.isEmpty}
            .bind(to: layoutView.emptyView.rx.isHidden)
            .disposed(by: disposeBag)

        layoutView.searchCollectionView.rx
            .modelSelected(Perfume.self)
            .withUnretained(self)
            .subscribe(onNext: { vc, perfume in
                vc.pushDetailViewController(perfume)
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
}

extension SearchViewController {

    private func setCollectionView() {
        layoutView.searchCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        layoutView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }

    private func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.cancelsTouchesInView = false
        layoutView.addGestureRecognizer(tapGesture)

        tapGesture.rx.event
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }

    private func pushDetailViewController(_ perfume: Perfume) {
        let detailViewModel = DetailPerfumeViewModel(perfume: perfume,
                                                     title: "",
                                                     storage: viewModel.storage)
        var detailViewController = DetailViewController()
        detailViewController.bind(viewModel: detailViewModel)
        detailViewController.hidesBottomBarWhenPushed = true

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
