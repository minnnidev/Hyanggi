//
//  DetailView.swift
//  Hyanggi
//
//  Created by 김민 on 4/3/24.
//

import UIKit

final class DetailView: BaseView {

    let ellipsisButton = UIBarButtonItem()
    let wishButton = UIBarButtonItem()
    private let brandNameLabel = UILabel()
    private let perfumeNameLabel = UILabel()
    private let sentenceLabel = UILabel()
    private let contentTextView = UITextView()
    private let imageView = UIImageView()
    private let dateLabel = UILabel()
    private let scrollView = UIScrollView(frame: .zero)
    private let contentView = UIView()

    override func setViews() {
        ellipsisButton.do {
            $0.image = UIImage(systemName: "ellipsis")
        }

        wishButton.do {
            $0.image = UIImage(systemName: "heart")
        }

        brandNameLabel.do {
            $0.text = "딥디크"
            $0.font = .systemFont(ofSize: 30, weight: .bold)
        }

        perfumeNameLabel.do {
            $0.text = "오 로즈"
            $0.font = .systemFont(ofSize: 30, weight: .bold)
            $0.numberOfLines = 0
            $0.textAlignment = .left
        }

        sentenceLabel.do {
            $0.text = "\"꽃맛이 날 것 같은 솜사탕 냄새\""
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
            $0.numberOfLines = 0
            $0.textAlignment = .left
        }

        contentTextView.do {
            $0.text = "향수에 대한 이야기...~ 향수에 대한 이야기...~ 향수에 대한 이야기...~ 향수에 대한 이야기...~"
            $0.font = .systemFont(ofSize: 17)
            $0.backgroundColor = .backgroundColor
            $0.isScrollEnabled = false
            $0.sizeToFit()
        }

        imageView.do {
            $0.backgroundColor = .systemGray4
        }

        dateLabel.do {
            $0.text = "2024.04.01"
            $0.font = .systemFont(ofSize: 15)
        }
    }

    override func setConstraints() {
        addSubview(scrollView)

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        [brandNameLabel, perfumeNameLabel, sentenceLabel, contentTextView, imageView, dateLabel].forEach {
            contentView.addSubview($0)
        }

        brandNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        perfumeNameLabel.snp.makeConstraints {
            $0.top.equalTo(brandNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(brandNameLabel)
        }

        sentenceLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeNameLabel.snp.bottom).offset(30)
            $0.leading.equalTo(brandNameLabel)
        }

        contentTextView.snp.makeConstraints {
            $0.top.equalTo(sentenceLabel.snp.bottom).offset(30)
            $0.leading.equalTo(brandNameLabel)
            $0.centerX.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(30)
            $0.leading.equalTo(brandNameLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalTo(brandNameLabel)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}
