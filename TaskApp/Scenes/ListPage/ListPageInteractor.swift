//
//  ListPageInteractor.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ListInteractorProtocol {
    var presenter: ListInteractorOutputProtocol? { get set }
    var sponsoredPresenter: SponsoredCollOutputProtocol? {get set}
    func loadAllProducts()
    
}

final class ListInteractor: ListInteractorProtocol {
    var sponsoredPresenter: SponsoredCollOutputProtocol?
    
    weak var presenter: ListInteractorOutputProtocol?
    
    func loadAllProducts() {
        var currentPage = 1
        
        func fetchNextPage() {
            NetworkManager.shared.fetchListings(page: currentPage) { result in
                switch result {
                case .success(let products):
                    
                    self.presenter?.didFetchProductsSuccess(product: products)
                    DispatchQueue.main.async {
                        self.sponsoredPresenter = SponsoredCollCell()
                        if let sponsoreProducts = products.sponsoredProducts {
                            self.sponsoredPresenter?.didFetchSponsoredProductsSuccess(sponsoredProducts: sponsoreProducts)
                            
                        }
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        fetchNextPage()
    }
    
}
