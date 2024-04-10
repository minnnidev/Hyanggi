//
//  Perfume.swift
//  Hyanggi
//
//  Created by 김민 on 4/11/24.
//

import Foundation
import RealmSwift

class Perfume: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: String
    @Persisted var brandName: String
    @Persisted var perfumeName: String
    @Persisted var content: String
    @Persisted var sentence: String
    @Persisted var image: Data?
    @Persisted var isLiked: Bool

    convenience init(date: String,
                     brandName: String,
                     perfumeName: String,
                     content: String,
                     sentence: String,
                     image: Data?, 
                     isLiked: Bool) {
        self.init()
        self.date = date
        self.brandName = brandName
        self.perfumeName = perfumeName
        self.content = content
        self.sentence = sentence
        self.image = image
        self.isLiked = isLiked
    }
}
