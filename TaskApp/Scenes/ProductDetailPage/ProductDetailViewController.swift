//
//  ProductDetailViewController.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import UIKit
import SnapKit

final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }


    func setupUI() {
        //
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
          //  self?.recommendationCollectionView.reloadData()
        }
    }
}
