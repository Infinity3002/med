//
//  Product.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

public struct Product: Decodable{
 
    var name: String
    var price: Int
    var description: String
    var weight: Int
    var count: Int
    
    init(name: String, price: Int, description: String, weight: Int, count: Int) {
        self.name = name
        self.price = price
        self.description = description
        self.weight = weight
        self.count = count
    }
}
