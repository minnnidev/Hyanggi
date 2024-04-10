//
//  HomeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 4/11/24.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    let repository: PerfumeRepositoryType
    var allPerfumes: BehaviorRelay = BehaviorRelay<[Perfume]>(value: [])

    init(repository: PerfumeRepositoryType = PerfumeRepository()) {
        self.repository = repository

        allPerfumes.accept(self.repository.getPerfumes())
    }
}
