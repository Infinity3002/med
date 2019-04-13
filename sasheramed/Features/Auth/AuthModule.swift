//
//  AuthModule.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Swinject
import SwinjectStoryboard

let authModule = Container(parent: appModule){ current in
    current.register(AuthValidate.self){ _ in AuthValidate()}
    current.register(AuthRepository.self){ r in AuthRepository(r.resolve(Networking.self)!)}
    current.register(AuthInteractor.self){ r in AuthInteractor(validate: r.resolve(AuthValidate.self)!, repository: r.resolve(AuthRepository.self)!)}
    
    current.register(SignInVM.self){r in
        SignInVM(r.resolve(AuthInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    
    
    current.register(SignUpVM.self){r in
        SignUpVM(r.resolve(AuthInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    // ViewControler
    
    current.storyboardInitCompleted(SignInVC.self){ r, c in
        c.vm = r.resolve(SignInVM.self)
    }
    
    current.storyboardInitCompleted(SignUpVC.self){ r, c in
        c.vm = r.resolve(SignUpVM.self)
    }
    
    current.storyboardInitCompleted(AuthSelectionVC.self){ r, c in
    
    }
}


