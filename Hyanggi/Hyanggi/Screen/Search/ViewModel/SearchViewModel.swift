//
//  SearchViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 4/30/24.
//

import Foundation
import RxSwift
import RxRelay

final class SearchViewModel {
    let searchText = BehaviorRelay<String>(value: "")
    var searchResult: BehaviorRelay = BehaviorRelay<[Perfume]>(value: [])

    let repository: PerfumeRepositoryType

    init(repository: PerfumeRepositoryType = PerfumeRepository()) {
        self.repository = repository
    }

    func searchPerfumes(_ query: String) {
        searchResult
            .accept(repository.searchPerfumes(query))
    }
}
