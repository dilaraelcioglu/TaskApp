//
//  FilterView.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 9.05.2024.
//

import UIKit

class FilterView: UIView {
    
    private lazy var searchCount: UILabel = {
        let temp = UILabel()
        temp.text = "4255 sonuç"
        return temp
    }()
    
    private lazy var arrangeButton: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = .orange
        return temp
    }()
    
    private lazy var filterButton: UIButton = {
        let temp = UIButton()
        temp.backgroundColor = .orange
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
        backgroundColor = .white
        snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        self.addSubview(searchCount)
        searchCount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.centerY.equalTo(searchCount)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(arrangeButton)
        arrangeButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(100)
            make.centerY.equalTo(searchCount)
            make.trailing.equalTo(filterButton.snp.leading).offset(-20)
        }

    }
}
