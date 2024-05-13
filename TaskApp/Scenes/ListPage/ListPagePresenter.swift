//
//  ListPagePresenter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ListPresenterProtocol {
    var view: ListViewController? { get set }
    var interactor: ListInteractorProtocol? { get set }
    var router: ListRouterProtocol? { get set }
    func viewDidLoad()
    func cellForRow(at index: IndexPath) -> [Product]?
    func numberOfSections() -> Int
    func numberItems(in section: Int) -> Int
    func didSelectProduct(productId: Int)
}

protocol ListInteractorOutputProtocol: AnyObject {
    func didFetchProductsSuccess(product: ListModel?)
    func didFetchProductsFailure(errorMessage: String)
}

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewController?
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?
    
    var allProducts: ListModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view?.mainCollectionView.reloadData()
            }
        }
    }
    
    func viewDidLoad() {
        view?.setupUI()
        view?.reloadCollectionView()
        interactor?.loadAllProducts()

    }
    
    func cellForRow(at index: IndexPath) -> [Product]? {
        switch index.section {
        case 0: return allProducts?.sponsoredProducts
        case 1: return allProducts?.products
        default:
            return nil
        }
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberItems(in section: Int) -> Int {
        if section == 0 {
            return 1 //bir tane yatay colleectionView oluştur
        } else {
            return allProducts?.products?.count ?? 4// gelen data kadar cell göster
        }
    }
    
    func didSelectProduct(productId: Int) {
        router?.routeToDetail(productId: productId)
    }
    
}

extension ListPresenter: ListInteractorOutputProtocol {
    func didFetchProductsSuccess(product: ListModel?) {
        allProducts = product
        print(allProducts)
    }
    
    func didFetchProductsFailure(errorMessage: String) {
        view?.showAlert("Show Products Error: \(errorMessage)", completion: {})
    }
}
