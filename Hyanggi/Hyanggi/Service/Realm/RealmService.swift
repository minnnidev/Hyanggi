//
//  RealmService.swift
//  Hyanggi
//
//  Created by 김민 on 6/3/24.
//

import Foundation
import RealmSwift
import RxSwift

final class RealmService: PerfumeStorageType {

    static let shared = RealmService()

    private var realm: Realm

    private lazy var store: BehaviorSubject<[Perfume]> = {
        let perfumes = realm.objects(PerfumeModel.self)
            .map { $0.convertToPerfume() }
         return BehaviorSubject(value: Array(perfumes))
     }()

    init() {
        do {
            realm = try Realm()
        } catch let error {
            fatalError("Realm 초기화 실패: \(error.localizedDescription)")
        }
    }

    func createPerfume(_ perfume: Perfume) -> Observable<Perfume> {
        let realmPerfume = perfume.converToRealmModel()

        do {
            try realm.write {
                realm.add(realmPerfume)
            }

            store.onNext(Array(realm.objects(PerfumeModel.self)
                .map { $0.convertToPerfume() }))

        } catch {
            return Observable.error(RealmError.createFailed)
        }

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
        do {
            guard let perfume = realm.object(ofType: PerfumeModel.self, forPrimaryKey: id) else {
                return Observable.error(RealmError.perfumeNotFound)
            }

            let deletedPerfume = perfume.convertToPerfume()

            try realm.write {
                realm.delete(perfume)
            }

            store.onNext(Array(realm.objects(PerfumeModel.self).map { $0.convertToPerfume() }))

            return Observable.just(deletedPerfume)
        } catch {
            return Observable.error(RealmError.deleteFailed)
        }
    }


    func updatePerfume(_ id: UUID, _ perfume: Perfume) -> Observable<Perfume> {
        do {
            guard let existedPerfume = realm.object(ofType: PerfumeModel.self, forPrimaryKey: id) else {
                return Observable.error(RealmError.perfumeNotFound)
            }

            try realm.write {
                existedPerfume.photoId = perfume.photoId
                existedPerfume.date = perfume.date
                existedPerfume.brandName = perfume.brandName
                existedPerfume.perfumeName = perfume.perfumeName
                existedPerfume.content = perfume.content
                existedPerfume.sentence = perfume.sentence
                existedPerfume.isLiked = perfume.isLiked
            }
            store.onNext(Array(realm.objects(PerfumeModel.self).map { $0.convertToPerfume() }))

            return Observable.just(existedPerfume.convertToPerfume())
        } catch {
            return Observable.error(RealmError.updateFailed)
        }
    }

    func updateLikePerfume(_ id: UUID) {
        do {
            if let existedPerfume = realm.object(ofType: PerfumeModel.self, forPrimaryKey: id) {
                try realm.write {
                    existedPerfume.isLiked.toggle()
                }
                store.onNext(Array(realm.objects(PerfumeModel.self).map { $0.convertToPerfume() }))
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
