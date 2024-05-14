//
//  ListPageRouter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import UIKit

protocol ListRouterProtocol {
    var view: UIViewController? { get set }
    
    func routeToDetail(productId: Int)
}

final class ListRouter: ListRouterProtocol {
    
    weak var view: UIViewController?
    
    class func createModule() -> ListViewController {
        let view = ListViewController()
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
     
    func routeToDetail(productId: Int) {
        let productDetail = ProductDetailRouter.createModule(productId: productId)
        view?.navigationController?.pushViewController(productDetail, animated: false)
    }

}
