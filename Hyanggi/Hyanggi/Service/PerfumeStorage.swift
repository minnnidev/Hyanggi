//
//  PerfumeStorage.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class PerfumeStorage: PerfumeStorageType {
    private var perfumes = [
        Perfume(id: UUID(),
                date: "2024.05.14",
                brandName: "딥디크",
                perfumeName: "플레르 드 뽀",
                content: "안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽",
                sentence: "솜사탕",
                isLiked: false),
        Perfume(id: UUID(),
                date: "2024.05.13",
                brandName: "딥디크",
                perfumeName: "오 로즈",
                content: "아 냄새 좋아. 돈 생기면 꼭 사야지 ㅠㅠ",
                sentence: "그냥 한마디로 솜사탕 냄새다",
                isLiked: true),
    ]

    private lazy var store = BehaviorSubject<[Perfume]>(value: perfumes)

    func createPerfume(_ perfume: Perfume) -> Observable<Perfume> {
        perfumes.insert(perfume, at: 0)
        store.onNext(perfumes)

        return Observable.just(perfume)
    }
    
    func perfumeList() -> Observable<[Perfume]> {
        return store
    }

    func wishedPerfumeList() -> Observable<[Perfume]> {
        return store
            .map { perfumes in
                perfumes.filter { $0.isLiked }
            }
    }
}
