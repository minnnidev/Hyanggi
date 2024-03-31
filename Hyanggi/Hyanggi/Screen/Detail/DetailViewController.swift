//
//  DetailViewController.swift
//  Hyanggi
//
//  Created by 김민 on 3/21/24.
//

import UIKit

class DetailViewController: BaseViewController {

    private let brandName = UILabel()
    private let perfumeName = UILabel()
    private let sentence = UILabel()
    private let content = UITextView()
    private let imageView = UIImageView()
    private let wisthButton = UIButton()
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }

    // MARK: - Settings

    private func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .black

        let ellipsisButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                             style: .plain,
                                             target: self,
                                             action: nil)
        navigationItem.rightBarButtonItems = [ellipsisButton]
    }

    override func setUI() {
        brandName.do {
            $0.text = "딥디크"
            $0.font = .systemFont(ofSize: 30, weight: .bold)
        }

        perfumeName.do {
            $0.text = "오 로즈"
            $0.font = .systemFont(ofSize: 30, weight: .bold)
            $0.numberOfLines = 0
            $0.textAlignment = .left
        }

        sentence.do {
            $0.text = "\"꽃맛이 날 것 같은 솜사탕 냄새\""
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.numberOfLines = 0
            $0.textAlignment = .left
        }

        content.do { 
            $0.text = "향수에 대한 이야기...~ 향수에 대한 이야기...~ 향수에 대한 이야기...~ 향수에 대한 이야기...~"
            $0.font = .systemFont(ofSize: 17)
            $0.backgroundColor = .backgroundColor
        }

        imageView.do {
            $0.backgroundColor = .systemGray4
        }

        wisthButton.do {
            $0.setTitle("위시리스트에 담기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.backgroundColor = .black
            $0.layer.cornerRadius = CGFloat(10)
        }
    }

    override func setLayout() {
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        [brandName, perfumeName, sentence, content, imageView, wisthButton].forEach {
            contentView.addSubview($0)
        }

        brandName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        perfumeName.snp.makeConstraints {
            $0.top.equalTo(brandName.snp.bottom).offset(10)
            $0.leading.equalTo(brandName)
        }

        sentence.snp.makeConstraints {
            $0.top.equalTo(perfumeName.snp.bottom).offset(30)
            $0.leading.equalTo(brandName)
        }

        content.snp.makeConstraints {
            $0.top.equalTo(sentence.snp.bottom).offset(30)
            $0.leading.equalTo(brandName)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom).offset(30)
            $0.leading.equalTo(brandName)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }

        wisthButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.equalTo(brandName)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview()
        }
    }
}
