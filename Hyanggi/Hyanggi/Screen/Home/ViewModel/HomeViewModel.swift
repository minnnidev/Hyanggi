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

    private let disposeBag = DisposeBag()

    struct Input {
        let wishButtonSelected: Observable<Bool>
        let perfumeSelected: ControlEvent<Perfume>
        let plusButtonTapped: ControlEvent<Void>
    }

    struct Output {
        let perfumes: Driver<[Perfume]>
        let pushToDetail: Observable<Perfume>
        let presentCompose: Observable<Void>
        let isEmpty: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        let perfumes = input.wishButtonSelected
            .flatMapLatest { isSelected -> Observable<[Perfume]> in
                if isSelected {
                    return RealmService.shared.wishedPerfumeList()
                } else {
                    return RealmService.shared.perfumeList()
                }
            }
            .share(replay: 1)
            .asDriver(onErrorJustReturn: [])

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
