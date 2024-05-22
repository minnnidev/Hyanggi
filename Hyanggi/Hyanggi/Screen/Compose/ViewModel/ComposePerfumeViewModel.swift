//
//  ComposePerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxRelay

final class ComposePerfumeViewModel: BaseViewModel {
    let brandNameRelay = PublishRelay<String>()
    let perfumeNameRelay = PublishRelay<String>()

    let formValid = BehaviorRelay<Bool>(value: false)

    private let disposeBag = DisposeBag()

    override init(title: String, storage: PerfumeStorageType) {
        
        Observable.combineLatest(brandNameRelay,
                                 perfumeNameRelay)
        .map { brandName, perfumeName in
            return !brandName.isEmpty && !perfumeName.isEmpty
        }
        .bind(to: formValid)
        .disposed(by: disposeBag)


        super.init(title: title, storage: storage)
    }
}
