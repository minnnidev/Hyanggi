//
//  HomeViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then

class HomeViewController: BaseViewController {

    private let testPapersCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout()).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        $0.collectionViewLayout = flowLayout
        $0.showsHorizontalScrollIndicator = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        setCollectionView()
    }

    // MARK: - Settings

    private func setNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "향기"

        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        let wishButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        navigationItem.rightBarButtonItems = [plusButton, wishButton]

        navigationController?.navigationBar.tintColor = .black
    }

    private func setCollectionView() {
        testPapersCollectionView.dataSource = self
        testPapersCollectionView.delegate = self

        testPapersCollectionView.register(TestPaperCell.self, forCellWithReuseIdentifier: "TestPaperCell")
    }

    override func setLayout() {
        [testPapersCollectionView].forEach {
            view.addSubview($0)
        }

        testPapersCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestPaperCell", for: indexPath) as? TestPaperCell else { return UICollectionViewCell() }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: testPapersCollectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
