//
//  BaseViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let title: Driver<String>
    let storage: PerfumeStorageType

    init(title: String, storage: PerfumeStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.storage = storage
    }
}
