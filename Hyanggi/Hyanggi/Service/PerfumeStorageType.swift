//
//  PerfumeStorageType.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift

protocol PerfumeStorageType {
    func createPerfume(_ perfume: Perfume) -> Observable<Perfume>
    func perfumeList() -> Observable<[Perfume]>
    func wishedPerfumeList() -> Observable<[Perfume]>
    func deletePerfume(_ id: UUID)
    func updatePerfume(_ id: UUID, _ perfume: Perfume) -> Observable<Perfume>
    func updateLikePerfume(_ id: UUID, _ perfume: Perfume)
}
