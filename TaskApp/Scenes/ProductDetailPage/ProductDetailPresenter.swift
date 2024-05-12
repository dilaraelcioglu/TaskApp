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
    
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorProtocol?
    var router: ProductDetailRouterProtocol?
    
    private var productDetail: ProductDetailModel?
    
    init(productId: Int) {
        self.productId = productId
    }
    
    func viewDidLoad() {
        interactor?.loadProductDetail(productId: productId)
    }
    
    func cellForRow(at index: IndexPath) -> [Product]? {
        
        switch index.section {

        default: return nil
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        return 1
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
