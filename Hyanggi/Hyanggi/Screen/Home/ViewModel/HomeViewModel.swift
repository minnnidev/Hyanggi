//
//  HomeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    let storage: PerfumeStorageType

    init(storage: PerfumeStorageType) {
        self.storage = storage
    }

    var disposeBag = DisposeBag()

    struct Input {
        let wishButtonSelected: Observable<Bool>
        let perfumeSelected: ControlEvent<Perfume>
        let plusButtonTapped: ControlEvent<Void>
    }

    struct Output {
        let perfumes: Observable<[Perfume]>
        let pushToDetail: Observable<Perfume>
        let presentCompose: Observable<Void>
        let isEmpty: Observable<Bool>
    }

    func transform(input: Input) -> Output {
        let perfumes = input.wishButtonSelected
            .flatMapLatest { isSelected -> Observable<[Perfume]> in
                if isSelected {
                    return self.storage.wishedPerfumeList()
                } else {
                    return self.storage.perfumeList()
                }
            }
            .share(replay: 1)

        let pushToDetail = input.perfumeSelected.asObservable()

        let presentCompose = input.plusButtonTapped.asObservable()

        let isEmpty = perfumes
            .map { !$0.isEmpty }

        return Output(perfumes: perfumes,
                      pushToDetail: pushToDetail,
                      presentCompose: presentCompose,
                      isEmpty: isEmpty)
    }
}
