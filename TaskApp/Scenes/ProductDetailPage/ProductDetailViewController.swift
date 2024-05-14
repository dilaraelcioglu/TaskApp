//
//  ProductDetailViewController.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenterProtocol?
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.register(ProductDetailCollViewCell.self, forCellWithReuseIdentifier: String(describing: ProductDetailCollViewCell.self))
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()
    
    private lazy var backButton: UIButton = {
        let temp = UIButton()
        temp.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        temp.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }


    func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(320)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: false)
    }
}

extension ProductDetailViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRows(in: section) ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductDetailCollViewCell.self), for: indexPath) as! ProductDetailCollViewCell
        if let imageUrl = presenter?.cellForRow(at: indexPath)?[indexPath.row].image {
            if let imageUrl = URL(string: imageUrl) {
                    cell.productImage.kf.setImage(with: imageUrl)
            }
         }
        return cell
    }
    
}
