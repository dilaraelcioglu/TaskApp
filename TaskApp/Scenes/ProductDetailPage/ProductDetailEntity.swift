//
//  ProductDetailEntity.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

struct ProductDetailModel: Codable {
    let title, description: String?
    let images: [String]?
    let price, instantDiscountPrice: Int?
    let rate: Double?
    let sellerName: String?
}
