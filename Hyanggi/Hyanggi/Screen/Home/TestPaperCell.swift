//
//  TestPaperCell.swift
//  Hyanggi
//
//  Created by 김민 on 3/31/24.
//

import UIKit

class TestPaperCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
