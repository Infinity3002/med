//
//  TokenResponce.swift
//  sasheramed
//
//  Created by Aleksandr on 4/14/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//
struct TokenResponce: Codable{
    
    enum ErrorKeys: String, CodingKey{
        case token = "token"
        case expire = "expire"
    }
    
    let token: String?
    let expire: String?
}
