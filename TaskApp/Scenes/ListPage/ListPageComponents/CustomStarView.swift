//
//  CustomStarView.swift
//  TrialApp
//
//  Created by Dilara Elçioğlu on 6.05.2024.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

final class CustomStarView: UIView {
    var rates: Int = 0 {
        didSet {
            updateStars()
            ratingScore.text = "\(rates)"
        }
    }

    var addRateScore: Bool = false {
        didSet {
            if addRateScore { addRatingScore() }
        }
    }

    private let starImages = (1...5).map { _ in UIImageView() }
    private let ratingScore = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        updateStars()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(rates: Int, addRateScore: Bool = false) {
        super.init(frame: .zero)
        self.rates = rates
        self.addRateScore = addRateScore
        configureUI()
        updateStars()
        if addRateScore { addRatingScore() }
    }

    private func configureUI() {
        snp.makeConstraints { make in
            make.height.equalTo(9)
            make.width.equalTo(58)
        }

        for (index, star) in starImages.enumerated() {
            addSubview(star)
            star.tintColor = .yellow
            star.image = UIImage(systemName: "star")
            star.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(index * 11)
                make.centerY.equalToSuperview()
                make.height.width.equalTo(10)
            }
        }
    }

    private func updateStars() {
        for (index, star) in starImages.enumerated() {
            star.image = (index < rates) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
    }

    private func addRatingScore() {
        addSubview(ratingScore)
        ratingScore.font = UIFont.systemFont(ofSize: 10)
        ratingScore.textColor = .yellow
        ratingScore.snp.makeConstraints { make in
            make.leading.equalTo(starImages.last!.snp.trailing).offset(3)
            make.centerY.equalToSuperview()
        }
    }
}
