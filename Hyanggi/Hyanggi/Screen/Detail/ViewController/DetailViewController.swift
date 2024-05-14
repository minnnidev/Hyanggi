//
//  DetailViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import RxSwift

final class DetailViewController: BaseViewController, ViewModelBindableType {

    var viewModel: DetailPerfumeViewModel!

    private let layoutView = DetailView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
}
