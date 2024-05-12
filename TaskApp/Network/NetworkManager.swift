//
//  NetworkManager.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//
/*
import Foundation

protocol NetworkManagerProtocol {
    func getAllProducts(pageIndex: Int, completion: @escaping (Result<ListModel, NetworkError>) -> ())
    func getDetailProduct(productId: Int, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {

    static let shared = NetworkManager()
    
    private init() {}
    
    func getAllProducts(pageIndex: Int, completion: @escaping (Result<ListModel, NetworkError>) -> ()) {
        request(.getAllProductList(pageIndex: pageIndex), completion: completion)
    }
    
    func getDetailProduct(productId: Int, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> ()) {
        request(.getProductDetail(productID: productId), completion: completion)
    }
    
}

extension NetworkManager {
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            
            if let error = error {
                completion(.failure(.networkError(description: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0) as! NetworkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Response data", code: 0) as! NetworkError))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch let error {
                completion(.failure(error as! NetworkError))
            }
            
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case networkError(description: String)
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case decodingError(description: String)
}
*/
