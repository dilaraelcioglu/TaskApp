//
//  Endpoint.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 9.05.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "http://private-d3ae2-n11case.apiary-mock.com/listing/"
    
    func fetchListings(page: Int, completion: @escaping (Result<ListModel, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(page)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ListModel.self, from: data)
                var products = result.products
                if let sponsoredProducts = result.sponsoredProducts {
                    // Add sponsored products to the list
                    products?.insert(contentsOf: sponsoredProducts, at: 0)
                }
                completion(.success(result))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchProduct(productId: Int, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)product?productId=\(productId)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let product = try decoder.decode(ProductDetailModel.self, from: data)
                completion(.success(product))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
