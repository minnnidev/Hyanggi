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

    private init() {
        self.realm = try! Realm()
    }

    func addPerfume(_ item: Perfume) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {

        }
    }
    
    func getPerfumes() -> Results<Perfume> {
        return realm.objects(Perfume.self)
    }
    
    func updatePerfume(_ item: Perfume) {

    }
    
    func deletePerfume(_ item: Perfume) {

    }
}
