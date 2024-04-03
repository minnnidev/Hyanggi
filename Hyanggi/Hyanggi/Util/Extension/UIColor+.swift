//
//  UIColor+.swift
//  Hyanggi
//
//  Created by 김민 on 3/31/24.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, 
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
}

extension UIColor {
    static let backgroundColor = UIColor(red: 249,
                                         green: 249,
                                         blue: 249)
    static let hyanggiGray = UIColor(red: 206,
                                     green: 206,
                                     blue: 206)
}
