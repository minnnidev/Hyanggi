//
//  ComposePerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ComposePerfumeViewModel: BaseViewModel {
    private var perfume: Perfume?

    let dateRelay = BehaviorRelay<String>(value: "")
    let brandNameRelay = BehaviorRelay<String>(value: "")
    let perfumeNameRelay = BehaviorRelay<String>(value: "")
    let contentRelay = BehaviorRelay<String>(value: "")
    let sentenceRelay = BehaviorRelay<String>(value: "")

    let completeAction = PublishRelay<Void>()

    var initialPerfume: Driver<Perfume?> {
        return Observable.just(perfume)
            .asDriver(onErrorJustReturn: nil)
    }

    var formValid: Observable<Bool> {
        return Observable.combineLatest(brandNameRelay,
                                        perfumeNameRelay,
                                        sentenceRelay)
        .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }
    }

    private let disposeBag = DisposeBag()

    init(title: String,
         storage: PerfumeStorageType,
         perfume: Perfume? = nil) {
        self.perfume = perfume

        super.init(title: title, storage: storage)

        completeAction
            .withUnretained(self)
            .subscribe(onNext: { vm, _ in
                vm.handleCompleteAction()
            })
            .disposed(by: disposeBag)
    }

    func handleCompleteAction() {
        if perfume != nil {
            updatePerfume()
        } else {
            createPerfume()
        }
    }

    func createPerfume() {
        _ = storage
            .createPerfume(Perfume(id: UUID(),
                                   date: dateRelay.value,
                                   brandName: brandNameRelay.value,
                                   perfumeName: perfumeNameRelay.value,
                                   content: contentRelay.value,
                                   sentence: sentenceRelay.value,
                                   isLiked: false))
    }

    func updatePerfume() {
        guard let perfume = perfume else { return }
        _ = storage.updatePerfume(perfume.id, Perfume(id: perfume.id,
                                                  date: dateRelay.value,
                                                  brandName: brandNameRelay.value,
                                                  perfumeName: perfumeNameRelay.value,
                                                  content: contentRelay.value,
                                                  sentence: sentenceRelay.value,
                                                  isLiked: perfume.isLiked))
    }
}
