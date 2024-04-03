//
//  String+.swift
//  Hyanggi
//
//  Created by 김민 on 4/3/24.
//

import Foundation

extension Date {

    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
