//
//  Perfume.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation

struct Perfume {
    var id: UUID
    var photoId: String?
    var date: String
    var brandName: String
    var perfumeName: String
    var content: String
    var sentence: String
    var isLiked: Bool
}

extension Perfume {
    
    func converToRealmModel() -> PerfumeModel {
        return PerfumeModel(id: self.id,
                            photoId: self.photoId,
                            date: self.date,
                            brandName: self.brandName,
                            perfumeName: self.perfumeName,
                            content: self.content,
                            sentence: self.sentence,
                            isLiked: self.isLiked)
    }
}
