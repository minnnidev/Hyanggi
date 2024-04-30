//
//  PerfumeRepository.swift
//  Hyanggi
//
//  Created by 김민 on 4/11/24.
//

import Foundation
import RealmSwift

class PerfumeRepository: PerfumeRepositoryType {

    let realm: Realm

    init() {
        let config = Realm.Configuration(schemaVersion: 2)
        self.realm = try! Realm(configuration: config)
    }

    func addPerfume(_ item: Perfume) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {

        }
    }
    
    func getPerfumes() -> [Perfume] {
        return Array(realm.objects(Perfume.self))
    }
    
    func updatePerfume(_ item: Perfume) {

    }
    
    func deletePerfume(_ item: Perfume) {

    }

    func searchPerfumes(_ query: String) -> [Perfume] {
        let result = realm.objects(Perfume.self).filter {
            $0.date.contains(query) ||
            $0.brandName.contains(query) ||
            $0.perfumeName.contains(query) ||
            $0.content.contains(query) ||
            $0.sentence.contains(query)
        }
        return Array(result)
    }
}
