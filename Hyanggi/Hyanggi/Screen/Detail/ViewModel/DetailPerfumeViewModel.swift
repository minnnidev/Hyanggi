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
    let perfumeRelay: BehaviorRelay<Perfume>
    let wishButtonStateRelay: BehaviorRelay<Bool>

    let updatedPerfume = PublishRelay<Perfume>()
    private let disposeBag = DisposeBag()

    init(storage: PerfumeStorageType, perfume: Perfume) {
        self.storage = storage
        self.perfumeRelay = BehaviorRelay(value: perfume)
        self.wishButtonStateRelay = BehaviorRelay(value: perfumeRelay.value.isLiked)

        updatedPerfume
            .withUnretained(self)
            .subscribe(onNext: { vm, updatedPerfume in
                vm.perfumeRelay.accept(updatedPerfume)
            })
            .disposed(by: disposeBag)
    }

    struct Input {
        let wishButtonTap: ControlEvent<Void>
    }

    struct Output {
        let detailPerfume: Driver<Perfume>
        let wishButtonState: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        let detailPerfume = perfumeRelay
            .asDriver(onErrorJustReturn: perfumeRelay.value)

        input.wishButtonTap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(wishButtonStateRelay)
            .map { !$0 }
            .withUnretained(self)
            .subscribe(onNext: { vm, isLiked in
                _ = vm.storage.updateLikePerfume(vm.perfumeRelay.value.id)
                vm.wishButtonStateRelay.accept(isLiked)
            })
            .disposed(by: disposeBag)

        let wishButtonState = wishButtonStateRelay
            .asDriver(onErrorJustReturn: false)

        return Output(detailPerfume: detailPerfume,
                      wishButtonState: wishButtonState)
    }

    func deletePerfume() {
        storage.deletePerfume(perfumeRelay.value.id)
    }
}
