//
//  ListPageInteractor.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ListInteractorProtocol {
    var presenter: ListInteractorOutputProtocol? { get set }
    
    func loadAllProducts()

}

final class ListInteractor: ListInteractorProtocol {

    weak var presenter: ListInteractorOutputProtocol?

    func loadAllProducts() {
        var currentPage = 1
        
        func fetchNextPage() {
            NetworkManager.shared.fetchListings(page: currentPage) { result in
                switch result {
                case .success(let products):
                    DispatchQueue.main.async {
                        // UI güncelleme işlemleri burada yapılabilir
                    }
                    
                    if let nextPageString = products.nextPage, let nextPage = Int(nextPageString) {
                        currentPage = nextPage
                        fetchNextPage()
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        fetchNextPage()
    }
    
}
