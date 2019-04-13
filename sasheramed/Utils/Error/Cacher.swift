//
//  Cacher.swift
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import NotificationBannerSwift

class Cacher{
    
    func process(_ error: Error){
        
        print(error)
        switch error {
        case is ValidationError:
            validation(error as! ValidationError)
        default:
            print(error)
        }
    }
    
    
    func validation(_ error: ValidationError){
        show(title: error.description)
    }
    
    func show(title: String){
        NotificationBanner(title: title, style: .danger).show()
    }
}
