//
//  ViewModelBindableType.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModel

    var viewModel: ViewModel! { get set }
    func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
    
    mutating func bind(viewModel: Self.ViewModel) {
        self.viewModel = viewModel
        loadViewIfNeeded()

        bindViewModel()
    }
}
