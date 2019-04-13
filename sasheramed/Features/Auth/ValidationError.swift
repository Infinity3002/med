//
//  ValidationError.swift
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation

class ValidationError: Error{
    let description: String
    
    init(_ description: String) {
        self.description = description
    }
    
    
}
