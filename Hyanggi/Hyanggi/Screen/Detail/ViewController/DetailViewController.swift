//
//  DetailViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

final class DetailViewController: BaseViewController, ViewModelBindableType {

    var viewModel: DetailPerfumeViewModel!

    private let layoutView = DetailView()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bindViewModel() {
        
    }
}
