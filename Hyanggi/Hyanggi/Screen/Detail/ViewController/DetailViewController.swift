//
//  DetailViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import RxSwift
import RxCocoa


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
        let input = DetailPerfumeViewModel.Input(
            wishButtonTap: layoutView.wishButton.rx.tap
        )

        let output = viewModel.transform(input: input)

        output.detailPerfume
            .drive(with: self, onNext: { vc, perfume in
                vc.layoutView.brandNameLabel.text = perfume.brandName
                vc.layoutView.perfumeNameLabel.text = perfume.perfumeName
                vc.layoutView.sentenceLabel.text = "\"\(perfume.sentence)\""
                vc.layoutView.contentTextView.text = perfume.content
                vc.layoutView.dateLabel.text = perfume.date
            })
            .disposed(by: disposeBag)

        output.detailPerfume
            .map { $0.isLiked }
            .drive(layoutView.wishButton.rx.isSelected)
            .disposed(by: disposeBag)

        output.wishButtonState
            .drive(layoutView.wishButton.rx.isSelected)
            .disposed(by: disposeBag)

        layoutView.ellipsisButton.rx.tap
            .flatMap { [unowned self] in
                self.showAlert()
            }
            .withUnretained(self)
            .subscribe(onNext: { vc, alert in
                switch alert {
                case .modify:
                    vc.presentComposeViewController()
                case .delete:
                    vc.viewModel.deletePerfume()
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
        let composeViewModel = ComposeViewModel(perfume: viewModel.perfumeRelay.value,
                                                storage: viewModel.storage)

        composeViewModel.updatedPerfume
            .bind(to: viewModel.updatedPerfume)
            .disposed(by: disposeBag)

        var composeViewController = ComposeViewController()
        composeViewController.bind(viewModel: composeViewModel)

        let navVC = UINavigationController(rootViewController: composeViewController)

        self.present(navVC, animated: true)
    }
}
