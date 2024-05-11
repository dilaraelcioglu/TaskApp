//
//  ProductDetailPresenter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ProductDetailPresenterProtocol {
    func viewDidLoad()
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
}
