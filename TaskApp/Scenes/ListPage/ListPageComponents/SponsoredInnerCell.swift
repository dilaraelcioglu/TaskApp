//
//  SponsoredInnerCell.swift
//  TrialApp
//
//  Created by Dilara Elçioğlu on 6.05.2024.
//

import UIKit
import SnapKit

class SponsoredInnerCell: UICollectionViewCell {
    
    lazy var productImage: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .yellow
        return temp
    }()
    
    lazy var productName: UILabel = {
        let temp = UILabel()
        temp.text = "iPhone 11 pro MAx Silikon Deri görünümlü Auto-Focus "
        temp.lineBreakMode = .byWordWrapping
        temp.font = UIFont.systemFont(ofSize: 14)
        temp.numberOfLines = 2
        return temp
    }()
    
    lazy var sellerName: UILabel = {
        let temp = UILabel()
        temp.text = "elfia"
        temp.textColor = .gray
        temp.font = UIFont.systemFont(ofSize: 12)
        return temp
    }()
    
    lazy var saleIconView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(systemName: "delete.forward.fill")
        temp.tintColor = .red
        return temp
    }()
    
    lazy var saleIconText: UILabel = {
        let temp = UILabel()
        temp.text = "%50"
        temp.backgroundColor = .red
        temp.font = UIFont.systemFont(ofSize: 12)
        temp.textColor = .white
        return temp
    }()
    
    lazy var exPrice: UILabel = {
        let temp = UILabel()
        let exPriceText = "39.99 TL"
        let attributedString = NSMutableAttributedString(string: exPriceText)
        let range = NSRange(location: 0, length: exPriceText.count)
        attributedString.addAttributes([
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.black
        ], range: range)
        temp.attributedText = attributedString
        temp.font = UIFont.systemFont(ofSize: 12)
        temp.textColor = .black // Normal text rengi
        return temp
    }()

    
    lazy var currentPrice: UILabel = {
        let temp = UILabel()
        temp.text = "22.00 TL"
        temp.font = UIFont.boldSystemFont(ofSize: 16)
        return temp
    }()
    
    private lazy var cartSaleView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .white
        return temp
    }()
    
    private lazy var boltIcon: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage(systemName: "bolt.fill")
        temp.tintColor = .systemBlue
        return temp
    }()
    
    private lazy var cartSaleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "Sepette Ek İndirim"
        temp.font = UIFont.systemFont(ofSize: 10)
        return temp
    }()
    
    private lazy var freeCargo: UILabel = {
        let temp = UILabel()
        temp.text = "Ücretsiz Kargo"
        temp.font = UIFont.systemFont(ofSize: 10)
        return temp
    }()
    
    lazy var starView: CustomStarView = {
        let temp = CustomStarView(rates: 1)
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        contentView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(productImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(sellerName)
        sellerName.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(2)
            make.leading.equalTo(productName)
            make.trailing.equalTo(productName)
        }
    
        contentView.addSubview(saleIconView)
        saleIconView.snp.makeConstraints { make in
            make.top.equalTo(sellerName.snp.bottom).offset(2)
            make.leading.equalTo(productName)
            make.height.equalTo(32)
            make.width.equalTo(43)
        }
        
        saleIconView.addSubview(saleIconText)
        saleIconText.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-2.2)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(exPrice)
        exPrice.snp.makeConstraints { make in
            make.leading.equalTo(saleIconView.snp.trailing).offset(-2)
            make.top.equalTo(saleIconView)
        }
        
        contentView.addSubview(currentPrice)
        currentPrice.snp.makeConstraints { make in
            make.leading.equalTo(saleIconView.snp.trailing).offset(-2)
            make.bottom.equalTo(saleIconView)
        }
        
        contentView.addSubview(cartSaleView)
        cartSaleView.snp.makeConstraints { make in
            make.top.equalTo(saleIconView.snp.bottom).offset(2)
            make.leading.equalTo(productName)
            make.height.equalTo(20)
            make.width.equalTo(120)
        }
        
        cartSaleView.addSubview(boltIcon)
        boltIcon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(2)
            make.height.equalTo(12)
            make.width.equalTo(12)
        }
        
        cartSaleView.addSubview(cartSaleLabel)
        cartSaleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(boltIcon.snp.trailing).offset(2)
            make.trailing.equalToSuperview().offset(-2)
        }
        
        contentView.addSubview(freeCargo)
        freeCargo.snp.makeConstraints { make in
            make.top.equalTo(cartSaleView.snp.bottom).offset(2)
            make.leading.equalTo(productName)
        }
        
        contentView.addSubview(starView)
        starView.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(2)
            make.centerX.equalTo(productImage)
        }
        
    }
    
}
