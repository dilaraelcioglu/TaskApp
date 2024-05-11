//
//  ProductDetailRouter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import UIKit

protocol ProductDetailRouterProtocol {

}

final class ProductDetailRouter: ProductDetailRouterProtocol {
    
    weak var view: UIViewController?
    
    class func createModule(productId: Int) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let presenter = ProductDetailPresenter(productId: productId)
        let router = ProductDetailRouter()
        
   //     view.presenter = presenter
  //      interactor.presenter = presenter
        router.view = view
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
