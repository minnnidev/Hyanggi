//
//  ViewModelType.swift
//  Hyanggi
//
//  Created by 김민 on 5/28/24.
//

import Foundation
import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
