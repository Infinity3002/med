//
//  ErrorResponce.swift
//  sasheramed
//
//  Created by Aleksandr on 4/14/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

struct ErrorResponce: Decodable{
    
    enum ErrorKeys: String, CodingKey{
        case error = "error"
    }
    
    let error: String?
}
