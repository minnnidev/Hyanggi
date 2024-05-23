//
//  SearchPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchPerfumeViewModel: BaseViewModel {
    let searchTextRelay = BehaviorRelay(value: "")

    var perfumes: Observable<[Perfume]> {
        return storage.perfumeList()
    }

    var filteredPerfumes: Observable<[Perfume]> {
        return searchTextRelay
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMapLatest { vm, query in
                vm.perfumes.map { perfumes in
                    perfumes.filter {
                        $0.brandName.contains(query) || 
                        $0.perfumeName.contains(query) ||
                        $0.sentence.contains(query) ||
                        $0.content.contains(query) ||
                        $0.date.contains(query)
                    }
                }
            }
    }
}
