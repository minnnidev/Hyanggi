//
//  HomeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 4/11/24.
//

import Foundation

class HomeViewModel {
    let repository: PerfumeRepositoryType
    var perfumes = [Perfume]()

    init(repository: PerfumeRepositoryType = PerfumeRepository()) {
        self.repository = repository

        perfumes = repository.getPerfumes()
    }
}
