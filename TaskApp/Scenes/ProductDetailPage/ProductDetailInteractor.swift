//
//  ProductDetailInteractor.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    func loadProductDetail(productId: Int)
}

final class ProductDetailInteractor: ProductDetailInteractorProtocol {

    func loadProductDetail(productId: Int) {
        NetworkManager.shared.getDetailProduct(productId: productId) { result in
            switch result {
            case .success(let success):
                print("")
       //         self.presenter?.didFetchMovieDetailSuccess(movie: success)
            case .failure(let failure):
                print("")
      //          self.presenter?.didFetchMovieDetailFailure(errorMessage: failure.localizedDescription)
            }
        }
    }
}
