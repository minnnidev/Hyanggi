//
//  DetailViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import RxSwift

enum AlertType {
    case modify, delete
}

final class DetailViewController: BaseViewController, ViewModelBindableType {

    var viewModel: DetailPerfumeViewModel!

    private let layoutView = DetailView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }

    func bindViewModel() {
        viewModel.detailPerfume
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { vc, perfume in
                vc.layoutView.brandNameLabel.text = perfume.brandName
                vc.layoutView.perfumeNameLabel.text = perfume.perfumeName
                vc.layoutView.sentenceLabel.text = "\"\(perfume.sentence)\""
                vc.layoutView.contentTextView.text = perfume.content
                vc.layoutView.dateLabel.text = perfume.date
            })
            .disposed(by: disposeBag)

        layoutView.ellipsisButton.rx.tap
            .withUnretained(self)
            .flatMap { vc, _ in
                vc.showAlert()
            }
            .bind(to: viewModel.alertAction)
            .disposed(by: disposeBag)

        viewModel.detailPerfume
            .map { $0.isLiked }
            .bind(to: layoutView.wishButton.rx.isSelected)
            .disposed(by: disposeBag)

        layoutView.wishButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { vc, _ in
                vc.viewModel.toggleLike()
            })
            .disposed(by: disposeBag)

        viewModel.alertAction
            .withUnretained(self)
            .subscribe(onNext: { vc, alert in
                switch alert {
                case .modify:
                    vc.presentComposeViewController()
                case .delete:
                    vc.viewModel.deleteAction.accept(())
                    vc.navigationController?.popViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {

    private func setNavigationBar() {
        navigationItem.rightBarButtonItems = [layoutView.ellipsisButton, layoutView.wishButton]
    }

    private func showAlert() -> Observable<AlertType> {
        return Observable.create { [weak self] ob in
            let alertVC = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
            let modifyAction = UIAlertAction(title: "수정하기",
                                             style: .default) { _ in
                ob.onNext(.modify)
                ob.onCompleted()
            }
            let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { _ in
                ob.onNext(.delete)
                ob.onCompleted()
            }

            let cancelAction = UIAlertAction(title: "취소", style: .cancel)

            [cancelAction, modifyAction, deleteAction].forEach {
                alertVC.addAction($0)
            }

            self?.present(alertVC, animated: true)

            return Disposables.create()
        }
    }

    private func presentComposeViewController() {
//        let composeViewModel = ComposePerfumeViewModel(title: "향수 수정",
//                                                       storage: self.viewModel.storage,
//                                                       perfume: self.viewModel.perfume)
//        composeViewModel.updatedPerfume
//            .bind(to: viewModel.detailPerfume)
//            .disposed(by: disposeBag)
//        
//        var composeViewController = ComposeViewController()
//        composeViewController.bind(viewModel: composeViewModel)

        let composeViewModel = ComposeViewModel(storage: viewModel.storage)
        var composeViewController = ComposeViewController()
        composeViewController.bind(viewModel: composeViewModel)

        let navVC = UINavigationController(rootViewController: composeViewController)

        self.present(navVC, animated: true)
    }
}
