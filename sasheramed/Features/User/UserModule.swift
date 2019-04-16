//
//  UserModule.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Swinject
import SwinjectStoryboard

let userhModule = Container(parent: appModule){ current in
    current.register(UserRepository.self){ r in UserRepository(r.resolve(Networking.self)!)}
    current.register(UserInteractor.self){ r in UserInteractor(repository: r.resolve(UserRepository.self)!)}
    
    current.register(PersonalAreaVM.self){r in
        PersonalAreaVM(r.resolve(UserInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    
    // ViewControler
    
    current.storyboardInitCompleted(PersonalAreaVC.self){ r, c in
        c.vm = r.resolve(PersonalAreaVM.self)
    }
    
}
