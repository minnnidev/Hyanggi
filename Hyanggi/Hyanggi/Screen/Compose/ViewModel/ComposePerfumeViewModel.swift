//
//  ComposePerfumeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxRelay

final class ComposePerfumeViewModel: BaseViewModel {
    let dateRelay = BehaviorRelay<String>(value: "")
    let brandNameRelay = BehaviorRelay<String>(value: "")
    let perfumeNameRelay = BehaviorRelay<String>(value: "")
    let contentRelay = BehaviorRelay<String>(value: "")
    let sentenceRelay = BehaviorRelay<String>(value: "")

    var formValid: Observable<Bool> {
        return Observable.combineLatest(brandNameRelay,
                                        perfumeNameRelay,
                                        sentenceRelay)
        .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }
    }

    func createPerfume() {
        _ = storage
            .createPerfume(Perfume(date: dateRelay.value,
                                          brandName: brandNameRelay.value,
                                          perfumeName: perfumeNameRelay.value,
                                          content: contentRelay.value,
                                          sentence: sentenceRelay.value,
                                          isLiked: false))
    }
}
