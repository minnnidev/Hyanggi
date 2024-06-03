//
//  PerfumeModel.swift
//  Hyanggi
//
//  Created by 김민 on 6/3/24.
//

import Foundation
import RealmSwift

class PerfumeModel: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var photoId: String?
    @Persisted var date: String
    @Persisted var brandName: String
    @Persisted var perfumeName: String
    @Persisted var content: String
    @Persisted var sentence: String
    @Persisted var isLiked: Bool

    convenience init(id: UUID,
         photoId: String?,
         date: String,
         brandName: String,
         perfumeName: String,
         content: String,
         sentence: String,
         isLiked: Bool) {
        self.init()

        self.id = id
        self.photoId = photoId
        self.date = date
        self.brandName = brandName
        self.perfumeName = perfumeName
        self.content = content
        self.sentence = sentence
        self.isLiked = isLiked
    }
}

extension PerfumeModel {
    func convertToPerfume() -> Perfume {
        return Perfume(id: id,
                       photoId: photoId,
                       date: date,
                       brandName: brandName,
                       perfumeName: perfumeName,
                       content: content,
                       sentence: sentence,
                       isLiked: isLiked)
    }
}
