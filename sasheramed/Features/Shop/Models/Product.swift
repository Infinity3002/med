//
//  Product.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

public struct Product: Codable{
  
    let id: String
    let name: String
    let price: Price?
    let description: String?
    let image: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case name = "NAME"
        case description = "PREVIEW_TEXT"
        case price = "PRICE"
        case image = "PREVIEW_PICTURE_URl"
        case count
    }
    
    struct Price: Codable {
        
        let price: String
        let weight: String
        
        enum CodingKeys: String, CodingKey{
            case price = "PRICE"
            case weight = "PRODUCT_WEIGHT"
        }
    }
}
