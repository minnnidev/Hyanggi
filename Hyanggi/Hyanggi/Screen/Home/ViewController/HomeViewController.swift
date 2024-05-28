//
//  HomeViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController, ViewModelBindableType {

    var viewModel: HomeViewModel!

    private let layoutView = HomeView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setNavigationBar()
    }

    func bindViewModel() {
        let wishButtonState = layoutView.wishButton.rx.tap
            .scan(false) { lastState, _ in
                !lastState
            }
            .startWith(false)
            .share(replay: 1)

        let input = HomeViewModel.Input(wishButtonSelected: wishButtonState)
        let output = viewModel.transform(input: input)

        output.perfumes
            .bind(to: layoutView.testPapersCollectionView.rx.items(cellIdentifier: TestPaperCell.identifier, cellType: TestPaperCell.self)) { row, elem, cell in
                cell.dataBind(elem)
            }
            .disposed(by: disposeBag)

        wishButtonState
            .bind(to: layoutView.wishButton.rx.isSelected)
            .disposed(by: disposeBag)

        layoutView.plusButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.presentComposeViewController()
            }
            .disposed(by: disposeBag)
    }
}
extension HomeViewController {
    
    func setNavigationBar() {
        navigationItem.title = "향기"
        navigationItem.rightBarButtonItems = [layoutView.plusButton, layoutView.wishButton]
    }

    private func setCollectionView() {
        layoutView.testPapersCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        layoutView.testPapersCollectionView.register(TestPaperCell.self, forCellWithReuseIdentifier: TestPaperCell.identifier)
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

    private func presentComposeViewController() {
        let composeViewModel = ComposePerfumeViewModel(title: "향수 추가",
                                                       storage: viewModel.storage)
        var composeViewController = ComposeViewController()
        composeViewController.bind(viewModel: composeViewModel)

        let navVC = UINavigationController(rootViewController: composeViewController)

        present(navVC, animated: true)
    }
}

// TODO: refactor with RxDataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: layoutView.testPapersCollectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension Reactive where Base: UIBarButtonItem {

    var isSelected: Binder<Bool> {
        return Binder(self.base) { barButtonItem, isSelected in
            barButtonItem.image = UIImage(systemName: isSelected ? "heart.fill" : "heart")
        }
    }
}
