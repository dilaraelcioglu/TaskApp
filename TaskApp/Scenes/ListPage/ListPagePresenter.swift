//
//  ListPagePresenter.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol ListPresenterProtocol {
    var view: ListViewProtocol? { get set }
    
    func viewDidLoad()
    func cellForRow(at index: IndexPath) -> [Product]?
    func numberOfSections() -> Int
    func numberItems(in section: Int) -> Int
}

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var interactor: ListInteractorProtocol?
 //   var router: ListRouterProtocol?
    
    var allProducts: ListModel?

    
    func viewDidLoad() {
        view?.setupUI()
        view?.reloadCollectionView()
    }
    
    func cellForRow(at index: IndexPath) -> [Product]? {
        switch index.section {
        case 0: return allProducts?.sponsoredProducts
        case 1: return allProducts?.products
        default:
            return nil
        }
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberItems(in section: Int) -> Int {
        if section == 0 {
            return 1 //bir tane yatay colleectionView oluştur
        } else {
            return allProducts?.products.count ?? 1// gelen data kadar cell göster
        }
    }
    
}
