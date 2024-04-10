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

    private let testPapersCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: UICollectionViewLayout()).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        $0.collectionViewLayout = flowLayout
        $0.backgroundColor = .backgroundColor
        $0.showsHorizontalScrollIndicator = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }

    // MARK: - Settings

    override func setNavigationBar() {
        super.setNavigationBar()

        navigationController?.navigationBar.topItem?.title = "향기"

        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(tappedPlusButton))
        let wishButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                         style: .plain,
                                         target: self,
                                         action: nil)

        navigationItem.rightBarButtonItems = [plusButton, wishButton]
    }
    
    private func setCollectionView() {
        testPapersCollectionView.dataSource = self
        testPapersCollectionView.delegate = self

        testPapersCollectionView.register(TestPaperCell.self, forCellWithReuseIdentifier: TestPaperCell.identifier)
    }

    override func setConstraints() {
        [testPapersCollectionView].forEach {
            view.addSubview($0)
        }

        testPapersCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
            $0.leading.trailing.equalToSuperview()
        }
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
        return CGSize(width: 100, height: testPapersCollectionView.bounds.height)
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
