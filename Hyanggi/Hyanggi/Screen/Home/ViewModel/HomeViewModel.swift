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
    }

    struct Output {
        let perfumes: Observable<[Perfume]>
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

        return Output(perfumes: perfumes)
    }
}
