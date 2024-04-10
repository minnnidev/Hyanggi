//
//  HomeViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: BaseViewController {

    private let layoutView = HomeView()

    override func loadView() {
        self.view = layoutView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }

    // MARK: - Settings

    override func setNavigationBar() {
        super.setNavigationBar()

        navigationController?.navigationBar.topItem?.title = "향기"

        layoutView.plusButton.target = self
        layoutView.plusButton.action = #selector(tappedPlusButton)
        
        navigationItem.rightBarButtonItems = [layoutView.plusButton, layoutView.wishButton]
    }
    
    private func setCollectionView() {
        layoutView.testPapersCollectionView.dataSource = self
        layoutView.testPapersCollectionView.delegate = self

        layoutView.testPapersCollectionView.register(TestPaperCell.self, forCellWithReuseIdentifier: TestPaperCell.identifier)
    }

    // MARK: - Actions

    @objc private func tappedPlusButton() {
        presentWriteVC()
    }

    // MARK: - Methods

    private func presentWriteVC() {
        let writeVC = WriteViewController()
        let naviVC = UINavigationController(rootViewController: writeVC)
        present(naviVC, animated: true)
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
        return CGSize(width: 100, height: layoutView.testPapersCollectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
