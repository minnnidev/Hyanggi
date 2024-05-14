//
//  WriteViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then

final class WriteViewController: BaseViewController, ViewModelBindableType {

    var viewModel: ComposePerfumeViewModel!

    private let layoutView = WriteView()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func bindViewModel() {

    }
}
