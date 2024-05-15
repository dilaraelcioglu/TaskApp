//
//  ProductDetailPresenter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ProductDetailPresenterProtocol {
    func viewDidLoad()
    func cellForRow(at index: IndexPath) -> [Product]?
    func numberOfRows(in section: Int) -> Int
    func numberOfSection() -> Int
}

protocol ProductDetailInteractorOutputProcol: AnyObject {
    func didFetchProductDetailSuccess(product: ProductDetailModel?)
    func didFetchProductDetailFailure(errorMessage: String)
}

final class ProductDetailPresenter {
    
    var productId: Int
    
    weak var view: ProductDetailViewController?
    var interactor: ProductDetailInteractorProtocol?
    var router: ProductDetailRouterProtocol?
    
    private var productDetail: ProductDetailModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.view?.collectionView.reloadData()
            }
        }
    }
    
    init(productId: Int) {
        self.productId = productId
    }
    
    func viewDidLoad() {
        view?.setupUI()
        interactor?.loadProductDetail(productId: productId)
    }
    
    func cellForRow(at index: IndexPath) -> ProductDetailModel? {
        return productDetail
    }
    
    func numberOfRows(in section: Int) -> Int {
        return productDetail?.images?.count ?? 1
    }
    
    func numberOfSection() -> Int {
        return 1
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProcol {
    func didFetchProductDetailSuccess(product: ProductDetailModel?) {
        productDetail = product
    }
    
    func didFetchProductDetailFailure(errorMessage: String) {
        view?.showAlert("Detail \(errorMessage)", completion: {})

    }

}
