//
//  DetailPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailPerfumeViewModel: ViewModelType {
    let storage: PerfumeStorageType
    var perfume: Perfume
    private lazy var wishButtonStateRelay = BehaviorRelay<Bool>(value: perfume.isLiked)

    private let disposeBag = DisposeBag()

    init(storage: PerfumeStorageType, perfume: Perfume) {
        self.storage = storage
        self.perfume = perfume
    }

    struct Input {
        let wishButtonTap: ControlEvent<Void>
    }

    struct Output {
        let detailPerfume: Driver<Perfume>
        let wishButtonState: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        let detailPerfume = Observable.just(perfume)
            .share(replay: 1)
            .asDriver(onErrorJustReturn: perfume)

        input.wishButtonTap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(wishButtonStateRelay)
            .map { !$0 }
            .withUnretained(self)
            .subscribe(onNext: { vm, isLiked in
                _ = vm.storage.updateLikePerfume(vm.perfume.id)
                vm.wishButtonStateRelay.accept(isLiked)
            })
            .disposed(by: disposeBag)

        let wishButtonState = wishButtonStateRelay
            .asDriver(onErrorJustReturn: false)

        return Output(detailPerfume: detailPerfume,
                      wishButtonState: wishButtonState)
    }

    func deletePerfume() {
        storage.deletePerfume(perfume.id)
    }
}
