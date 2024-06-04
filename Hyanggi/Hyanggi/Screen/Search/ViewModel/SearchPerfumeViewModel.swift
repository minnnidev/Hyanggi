//
//  SearchPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchPerfumeViewModel: ViewModelType {

    private var disposeBag = DisposeBag()

    struct Input {
        let searchText: Observable<String>
        let perfumeSelected: ControlEvent<Perfume>
    }

    struct Output {
        let searchedPerfumes: Driver<[Perfume]>
        let isEmpty: Driver<Bool>
        let pushToDetail: Observable<Perfume>
    }

    func transform(input: Input) -> Output {
        let searchedPerfumes = input.searchText
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMapLatest { vm, query in
                RealmService.shared.perfumeList().map { perfumes in
                    perfumes.filter {
                        $0.brandName.contains(query) ||
                        $0.perfumeName.contains(query) ||
                        $0.sentence.contains(query) ||
                        $0.content.contains(query) ||
                        $0.date.contains(query)
                    }
                }
            }
            .share(replay: 1)
            .asDriver(onErrorJustReturn: [])

        let isEmpty = searchedPerfumes
            .map { !$0.isEmpty }

        let pushToDetail = input.perfumeSelected.asObservable()

        return Output(searchedPerfumes: searchedPerfumes,
                      isEmpty: isEmpty, 
                      pushToDetail: pushToDetail)
    }
}
