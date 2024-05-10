//
//  Endpoint.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 9.05.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    func request() -> URLRequest
}

extension EndpointProtocol {
    var header: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case getAllProductList(pageIndex: Int)
    case getProductDetail(productID: Int)
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        return "http://private-anon-c9c824fcf7-n11case.apiary-mock.com/"
    }
    
    var path: String {
        switch self {
        case .getAllProductList:
            return "/listing/"
        case .getProductDetail(let productID):
            return "/product/\(productID)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        var parameters: [String: String] = [:]
        
        switch self {
        case .getAllProductList(let pageIndex):
            parameters["page"] = "\(pageIndex)"
        default:
            break
        }
        
        return parameters
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("*_* Base Url Error")
        }
        components.path = path
        
        components.queryItems = parameters?.compactMap { key, value in
            URLQueryItem(name: key, value: value as? String)
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        if let headers = header {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
