//
//  SignInRequest.swift
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation

class SignInRequest {
    
    var params = [String: AnyObject].init()
    
    init(login: String, pass: String) {
        
        params.updateValue(login as NSString, forKey: "login")
        params.updateValue(pass as NSString, forKey: "password")
    }
}
