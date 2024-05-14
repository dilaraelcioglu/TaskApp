//
//  ProductDetailInteractor.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    var presenter: ProductDetailInteractorOutputProcol? { get set }
    func loadProductDetail(productId: Int)
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    weak var presenter: ProductDetailInteractorOutputProcol?

    func loadProductDetail(productId: Int) {
        
        NetworkManager.shared.fetchProduct(productId: productId) { result in
            switch result {
            case .success(let success):
                print("")
                self.presenter?.didFetchProductDetailSuccess(product: success)
            case .failure(let failure):
                print("")
                self.presenter?.didFetchProductDetailFailure(errorMessage: failure.localizedDescription)
            }
        }
    }
}
