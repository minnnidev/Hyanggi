//
//  DetailPerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

class DetailPerfumeViewModel: BaseViewModel {
    let perfume: Perfume
    lazy var detailPerfume = BehaviorSubject<Perfume>(value: perfume)
    let alertAction = PublishRelay<AlertType>()

    init(perfume: Perfume, title: String, storage: PerfumeStorageType) {
        self.perfume = perfume

        super.init(title: title, storage: storage)
    }


    func handleAlertAction(_ alertType: AlertType) {
        switch alertType {
        case .modify:
            print("수정")
        case .delete:
            print("삭제")
        }
    }
}
