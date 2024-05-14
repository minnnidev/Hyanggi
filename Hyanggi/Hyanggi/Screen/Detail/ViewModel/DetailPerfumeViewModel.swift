//
//  DetailPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class DetailPerfumeViewModel: BaseViewModel {
    let perfume: Perfume
    lazy var detailPerfume = BehaviorSubject<Perfume>(value: perfume)

    init(perfume: Perfume, title: String, storage: PerfumeStorageType) {
        self.perfume = perfume

        super.init(title: title, storage: storage)
    }
}
