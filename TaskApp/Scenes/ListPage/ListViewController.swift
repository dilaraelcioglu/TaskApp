//
//  ListViewController.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 9.05.2024.
//

import UIKit
import SnapKit

protocol ListViewProtocol: AnyObject {
    var presenter: ListPresenterProtocol? { get set }
    func setupUI()
    func reloadCollectionView()

}

class ListViewController: UIViewController {
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
    
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        temp.delegate = self
        temp.dataSource = self
        temp.register(SponsoredProductsCell.self, forCellWithReuseIdentifier: String(describing: SponsoredProductsCell.self))
        temp.register(AllProductsCell.self, forCellWithReuseIdentifier: String(describing: AllProductsCell.self))
        temp.backgroundColor = .orange
        temp.showsVerticalScrollIndicator = false
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NetworkManager.shared.getAllProducts(pageIndex: 1) { result in
            print(result)
        }
   //     presenter?.viewDidLoad()
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
        if section == 0 {
            return 1 //bir tane yatay colleectionView oluştur
        } else {
            return 200 // gelen data kadar cell göster
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing: SponsoredProductsCell.self), for: indexPath) as! SponsoredProductsCell //bir tane yatay colleectionView oluştur
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing: AllProductsCell.self), for: indexPath) as! AllProductsCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //  presenter?.didSelectProduct(productId: productId ?? 0)
    }
    
}

extension ListViewController: ListViewProtocol {
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }

    func setupUI() {
       // hideKeyboardWhenTappedAround() eklenecek
        view.backgroundColor = .yellow
        navigationController?.isNavigationBarHidden = true
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
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
