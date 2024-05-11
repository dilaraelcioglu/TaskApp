//
//  ListPageEntity.swift
//  TaskApp
//
//  Created by Dilara Elçioğlu on 10.05.2024.
//

import Foundation

struct ListModel: Codable {
    let page, nextPage, publishedAt: String
    let sponsoredProducts, products: [Product]

    enum CodingKeys: String, CodingKey {
        case page, nextPage
        case publishedAt = "published_at"
        case sponsoredProducts, products
    }
}

struct Product: Codable {
    let id: Int
    let title, image: String
    let price: Double
    let instantDiscountPrice, rate: Double?
    let sellerName: String?
}
