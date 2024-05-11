//
//  ProductDetailViewController.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import UIKit
import SnapKit

protocol ProductDetailViewProtocol: AnyObject {
    func setupUI()
}

final class ProductDetailViewController: UIViewController , ProductDetailViewProtocol{
    
    var presenter: ProductDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func setupUI() {
        //
    }
    
}
