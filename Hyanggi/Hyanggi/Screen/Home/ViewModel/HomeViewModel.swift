//
//  HomeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: BaseViewModel {

    var perfumes: Observable<[Perfume]> {
        return storage.perfumeList()
    }

    var wishedPerfumes: Observable<[Perfume]> {
        return storage.wishedPerfumeList()
    }

    var isWishButtonSelected = BehaviorRelay<Bool>(value: false)

    lazy var perfumesObservable = isWishButtonSelected
        .withUnretained(self)
        .flatMapLatest { vm, isSelected -> Observable<[Perfume]> in
            if isSelected {
                return vm.wishedPerfumes
            } else {
                return vm.perfumes
            }
        }
}
