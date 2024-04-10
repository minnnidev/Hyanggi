//
//  TodoRepositoryType.swift
//  Hyanggi
//
//  Created by 김민 on 4/11/24.
//

import Foundation
import RealmSwift

protocol PerfumeRepositoryType {
    func addPerfume(_ item: Perfume)
    func getPerfumes() -> Results<Perfume>
    func updatePerfume(_ item: Perfume)
    func deletePerfume(_ item: Perfume)
}