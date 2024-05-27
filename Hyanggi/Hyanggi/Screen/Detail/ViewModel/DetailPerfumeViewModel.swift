//
//  DetailPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class DetailPerfumeViewModel: BaseViewModel {
    var perfume: Perfume
    lazy var detailPerfume = BehaviorSubject<Perfume>(value: perfume)
    let alertAction = PublishRelay<AlertType>()
    let deleteAction = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    init(perfume: Perfume, title: String, storage: PerfumeStorageType) {
        self.perfume = perfume

        super.init(title: title, storage: storage)

        deleteAction
            .withUnretained(self)
            .subscribe(onNext: { vm, _ in
                vm.storage.deletePerfume(perfume.id)
            })
            .disposed(by: disposeBag)
    }

    func toggleLike() {
        perfume.isLiked.toggle()
        detailPerfume.onNext(perfume)
        storage.updateLikePerfume(perfume.id, perfume)
    }
}
