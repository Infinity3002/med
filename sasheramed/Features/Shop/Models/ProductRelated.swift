//
//  ProductRelated.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

public struct ProductRelated: Codable{
    
    let id: String
    let name: String
    let description: String?
    let image: String?
    var count: Int?
    
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case name = "NAME"
        case description = "PREVIEW_TEXT"
        case image = "PREVIEW_PICTURE_URl"
        case count
    }
    
}
