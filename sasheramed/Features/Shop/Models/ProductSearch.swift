//
//  ProductSearch.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//
class ProductSearch : Codable {
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case name = "TITLE"
        case description = "BODY_FORMATED"
    }
    
    let id: String
    let name: String
    let description: String?
}
