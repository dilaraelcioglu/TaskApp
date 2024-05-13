//
//  SponsoredProductsCell.swift
//  TrialApp
//
//  Created by Dilara Elçioğlu on 6.05.2024.
//

import UIKit
import SnapKit

protocol SponsoredCollCellInterface: AnyObject {
    func configureUI()
    func reloadCollectionView()
}

class SponsoredCollCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "Bu ürünleri gördünüz mü?"
        temp.font = UIFont.boldSystemFont(ofSize: 18)
        return temp
    }()

    
    private lazy var sponsoredCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .orange
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.register(SponsoredInnerCell.self, forCellWithReuseIdentifier: String(describing: SponsoredInnerCell.self))
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let temp = UIPageControl()
        temp.isUserInteractionEnabled = false
        temp.layer.cornerRadius = 14
        temp.clipsToBounds = true
        temp.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        temp.backgroundColor = UIColor(red: 0.275, green: 0.275, blue: 0.275, alpha: 0.3)
        temp.pageIndicatorTintColor = .gray
        temp.currentPageIndicatorTintColor = .yellow
        temp.backgroundColor = .clear
        temp.numberOfPages = 5
        return temp
    }()
    
    var presenter: SponsoredCollCellPresenterInterface?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        self.addSubview(sponsoredCollectionView)
        sponsoredCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(sponsoredCollectionView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    
    func reloadCollectionView() {
        sponsoredCollectionView.reloadData()
    }
    
    func configurePageControlData() {
        /*
        if viewModel?.featuredProductDetail?.attachments?.count ?? 0 <= 1 {
            pageControl.isHidden = true
        } else {
            pageControl.numberOfPages = viewModel?.featuredProductDetail?.attachments?.count ?? 3
        }
         */
    }
    
}

extension SponsoredCollCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SponsoredInnerCell.self), for: indexPath) as! SponsoredInnerCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sponsoredCollectionView.bounds.size.width, height: sponsoredCollectionView.bounds.size.height)
    }
    
}


