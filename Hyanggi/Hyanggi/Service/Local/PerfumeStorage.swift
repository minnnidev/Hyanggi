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

    private var perfumes = [Perfume]()
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

    func deletePerfume(_ id: UUID) -> Observable<Perfume> {
        if let idx = perfumes.firstIndex(where: { $0.id == id }) {
            let deletedPerfume = perfumes.remove(at: idx)
            store.onNext(perfumes)

            return Observable.just(deletedPerfume)
        } else {
            return Observable.error(RealmError.perfumeNotFound)
        }
    }

    func updatePerfume(_ id: UUID, _ perfume: Perfume) -> Observable<Perfume> {
        let updated = Perfume(id: id, 
                              photoId: id.uuidString,
                              date: perfume.date,
                              brandName: perfume.brandName,
                              perfumeName: perfume.perfumeName,
                              content: perfume.content,
                              sentence: perfume.sentence,
                              isLiked: perfume.isLiked)
        if let idx = perfumes.firstIndex(where: { $0.id == id }) {
            perfumes[idx] = updated
        }

        store.onNext(perfumes)

        return Observable.just(updated)
    }

    func updateLikePerfume(_ id: UUID) {
        if let idx = perfumes.firstIndex(where: { $0.id == id }) {
            perfumes[idx].isLiked.toggle()
        }
        store.onNext(perfumes)
    }
}
