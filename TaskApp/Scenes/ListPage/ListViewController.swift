//
//  ListViewController.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 9.05.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ListViewController: UIViewController, SponsoredCollCellDelegate {
    func didSelectProduct(with productId: Int) {
        //
    }
    
    var presenter: ListPresenterProtocol?

    private lazy var searchBarView: UIView = {
        let temp = UIView()
        temp.backgroundColor = .purple
        return temp
    }()

    private lazy var filterView: FilterView = {
        let temp = FilterView()
        return temp
    }()
    
    lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        temp.delegate = self
        temp.dataSource = self
        temp.register(SponsoredCollCell.self, forCellWithReuseIdentifier: String(describing: SponsoredCollCell.self))
        temp.register(AllProductsCell.self, forCellWithReuseIdentifier: String(describing: AllProductsCell.self))
        temp.backgroundColor = .lightGray
        temp.showsVerticalScrollIndicator = false
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    func setupUI() {
       // hideKeyboardWhenTappedAround() eklenecek
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
        
        view.addSubview(filterView)
        filterView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(searchBarView.snp.bottom)
        }
        
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.width.bottom.equalToSuperview()
        }
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: mainCollectionView.frame.width, height: 200)
        } else {
            return CGSize(width: mainCollectionView.frame.width/2 - 1, height: 340)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberItems(in: section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing: SponsoredCollCell.self), for: indexPath) as! SponsoredCollCell //bir tane yatay colleectionView oluştur
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing: AllProductsCell.self), for: indexPath) as! AllProductsCell
            cell.productName.text = presenter?.cellForRow(at: indexPath)?[indexPath.row].title
            cell.sellerName.text = presenter?.cellForRow(at: indexPath)?[indexPath.row].sellerName
            cell.currentPrice.text = String(format: "%.2f", presenter?.cellForRow(at: indexPath)?[indexPath.row].instantDiscountPrice ?? 0) + "TL"
            cell.exPrice.text = String(format: "%.2f", presenter?.cellForRow(at: indexPath)?[indexPath.row].price ?? 0) + "TL"
            cell.starView.rates = Int(presenter?.cellForRow(at: indexPath)?[indexPath.row].rate?.rounded() ?? 0)
            
            if let imageUrl = presenter?.cellForRow(at: indexPath)?[indexPath.row].image {
                if let imageUrl = URL(string: imageUrl) {
                        cell.productImage.kf.setImage(with: imageUrl)
                }
             }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectProduct(productId: 12333)
    }
}
