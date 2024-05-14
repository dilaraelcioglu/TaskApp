//
//  ProductDetailCollViewCell.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 14.05.2024.
//

import UIKit

class ProductDetailCollViewCell: UICollectionViewCell {
    lazy var productImage: UIImageView = {
        let temp = UIImageView()
        temp.backgroundColor = .yellow
        return temp
    }()
    
    lazy var productName: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = .yellow
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
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(10)
        }
    }
}
