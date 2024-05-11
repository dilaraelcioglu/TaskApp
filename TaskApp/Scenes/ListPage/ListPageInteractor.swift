//
//  ListPageInteractor.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ListInteractorProtocol {
//    var presenter: MovieListInteractorOutputProtocol? { get set }
    func getAllPoructs()
}

final class ListInteractor: ListInteractorProtocol {
    
    private var pageNumber: Int = 0
    private var maxPage: Int = 0
    //   weak var presenter: MovieListInteractorOutputProtocol?

    func getAllPoructs() {
        NetworkManager.shared.getAllProducts(pageIndex: pageNumber) { [weak self] result in
            switch result {
            case .success(let success):
                print("")
              //  self?.presenter?.didFetchTrendingMoviesSuccess(movie: success)
            case .failure(let failure):
                print("")
              //  self?.presenter?.didFetchTrendingMoviesFailure(errorMessage: failure.localizedDescription)
            }
        }
    }
    
}
