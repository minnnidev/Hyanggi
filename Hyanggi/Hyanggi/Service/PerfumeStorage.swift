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
        Perfume(date: "2024.05.14",
                brandName: "딥디크",
                perfumeName: "플레르 드 뽀",
                content: "안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽안뇽",
                sentence: "솜사탕"),
        Perfume(date: "2024.05.13",
                brandName: "딥디크",
                perfumeName: "오 로즈",
                content: "아 냄시 조아",
                sentence: "솜사탕"),
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
}
