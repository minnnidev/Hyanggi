//
//  SearchPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift

final class SearchPerfumeViewModel: BaseViewModel {
    var perfumes: Observable<[Perfume]> {
        return storage.perfumeList()
    }
}
