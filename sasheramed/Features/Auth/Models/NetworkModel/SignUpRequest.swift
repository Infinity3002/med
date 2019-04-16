//
//  SignUpRequest.swift
//  sasheramed
//
//  Created by Aleksandr on 4/14/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation

class SignUpRequest {
    
    var params = [String: AnyObject].init()
    
    init(login: String, pass: String, email: String) {
        params.updateValue(login as NSString, forKey: "login")
        params.updateValue(pass as NSString, forKey: "password")
        params.updateValue(email as NSString, forKey: "email")
    }
}
