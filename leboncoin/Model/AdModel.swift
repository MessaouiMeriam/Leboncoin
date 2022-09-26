//
//  AdModel.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import Foundation

struct AdModel: Decodable {
    let id: Int
    let categoryId: Int?
    let title: String?
    let adDescription: String?
    let price: Float?
    let imageUrl: ImageModel?
    let creationDate: String?
    let isUrgent: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title, price
        case categoryId = "category_id"
        case adDescription = "description"
        case imageUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        
    }
}

struct ImageModel: Decodable {
    let small: String?
    let thumb: String?
}
