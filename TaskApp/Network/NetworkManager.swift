//
//  NetworkManager.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func getAllProducts(pageIndex: Int, completion: @escaping (Result<ListModel, Error>) -> ())
    func getDetailProduct(productId: Int, completion: @escaping (Result<ProductDetailModel, Error>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getAllProducts(pageIndex: Int, completion: @escaping (Result<ListModel, Error>) -> ()) {
        request(.getAllProductList(pageIndex: pageIndex), completion: completion)
    }
    
    func getDetailProduct(productId: Int, completion: @escaping (Result<ProductDetailModel, Error>) -> ()) {
        request(.getProductDetail(productID: productId), completion: completion)
    }
    

}

extension NetworkManager {
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Response data", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch let error {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
}
