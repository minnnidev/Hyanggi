//
//  ComposePerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ComposeViewModel: ViewModelType {
    private var perfume: Perfume?
    let storage: PerfumeStorageType

    private let disposeBag = DisposeBag()

    init(perfume: Perfume? = nil,
         storage: PerfumeStorageType) {
        self.perfume = perfume
        self.storage = storage
    }

    struct Input {
        let dateText: Observable<String>
        let brandNameText: Observable<String>
        let perfumeNameText: Observable<String>
        let contentText: Observable<String>
        let sentenceText: Observable<String>
        let dismissButtonTap: ControlEvent<Void>
        let completeButtonTap: ControlEvent<Void>
    }

    struct Output {
        let isFormValid: Observable<Bool>
        let dismissToPrevious: Observable<Void>
    }

    func transform(input: Input) -> Output {
        let isFormValid = Observable
            .combineLatest(input.brandNameText,
                           input.perfumeNameText,
                           input.sentenceText)
            .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }

        let dismissToPrevious = Observable
            .merge(input.dismissButtonTap.asObservable(), input.completeButtonTap.asObservable())

        input.completeButtonTap
            .withLatestFrom(Observable.combineLatest(input.dateText,
                                                     input.brandNameText,
                                                     input.perfumeNameText,
                                                     input.contentText,
                                                     input.sentenceText))

            .map { date, brand, perfume, content, sentence in
                Perfume(id: UUID(),
                        date: date,
                        brandName: brand,
                        perfumeName: perfume,
                        content: content,
                        sentence: sentence,
                        isLiked: false)
            }
            .withUnretained(self)
            .subscribe(onNext: { vm, perfume in
                vm.createPerfume(perfume)
            })
            .disposed(by: disposeBag)

        return Output(
            isFormValid: isFormValid,
            dismissToPrevious: dismissToPrevious
        )
    }

    func createPerfume(_ perfume: Perfume) {
        _ = storage
            .createPerfume(Perfume(id: UUID(),
                                   date: perfume.date,
                                   brandName: perfume.brandName,
                                   perfumeName: perfume.perfumeName,
                                   content: perfume.content,
                                   sentence: perfume.sentence,
                                   isLiked: false))
    }
}
