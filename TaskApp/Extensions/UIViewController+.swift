//
//  UIViewController+.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 12.05.2024.
//

import UIKit.UIViewController

extension UIViewController {
    func showAlert(_ errorMessage: String, completion: @escaping ()->()) {
        let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion()
        }
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
