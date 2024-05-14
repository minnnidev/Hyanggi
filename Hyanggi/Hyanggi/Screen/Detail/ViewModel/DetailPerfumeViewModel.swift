//
//  DetailPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation

class DetailPerfumeViewModel: BaseViewModel {
    let perfume: Perfume

    init(perfume: Perfume, title: String, storage: PerfumeStorageType) {
        self.perfume = perfume
        super.init(title: title, storage: storage)
    }
}
