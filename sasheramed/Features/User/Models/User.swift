//
//  User.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//
public struct User: Codable{
    
    let id: String
    let login: String
    let email: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "ID"
        case login = "LOGIN"
        case email = "EMAIL"
    }
    

}
