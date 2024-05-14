//
//  SponsoredCollCellPresenter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 13.05.2024.
//

import Foundation

protocol SponsoredCollCellPresenterInterface {
    var view: SponsoredCollCellInterface? { get set }
    func layoutSubviews()
    func cellForRow(at indexPath: IndexPath) -> Product?
    func numberOfItems(in section: Int) -> Int?
    func selectedProduct(with productId: Int)
    func reloadCollectionView()
}

protocol SponsoredCollCellDelegate {
    func didSelectProduct(with productId: Int)
}

final class  SponsoredCollCellPresenter:  SponsoredCollCellPresenterInterface {

    weak var view: SponsoredCollCellInterface?
    var delegate: SponsoredCollCellDelegate
    var products: [Product]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view?.reloadCollectionView()
            }
        }
    }
    
    init(view: SponsoredCollCellInterface? = nil,
         products: [Product],
         delegate: SponsoredCollCellDelegate) {
        self.view = view
        self.products = products
        self.delegate = delegate
        if let view = view {
            view.configureUI() // Bu satırı ekleyerek layoutSubviews'ı çağırıyoruz.
        }
        !products.isEmpty ? reloadCollectionView() : nil
    }

    
    func layoutSubviews() {
        view?.configureUI()
    }
    
    func reloadCollectionView() {
        view?.reloadCollectionView()
    }
    
    func cellForRow(at indexPath: IndexPath) -> Product? {
        products?[indexPath.row]
    }
    
    func selectedProduct(with productId: Int) {
        delegate.didSelectProduct(with: productId)
    }
    
    func numberOfItems(in section: Int) -> Int? {
      //  products.count
        4
    }
}
