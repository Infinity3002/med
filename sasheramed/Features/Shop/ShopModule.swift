//
//  ShopModule.swift
//  sasheramed
//
//  Created by Aleksandr on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Swinject
import SwinjectStoryboard

let shopModule =  Container(parent: appModule){ current in
    current.register(ShopRepository.self){ r in ShopRepository(r.resolve(Networking.self)!)}
    current.register(ShopInteractor.self){ r in ShopInteractor(r.resolve(ShopRepository.self)!)}
    
    current.register(MainVM.self){r in
        MainVM(r.resolve(ShopInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    
    current.register(OfferVM.self){r in
        OfferVM(r.resolve(ShopInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    current.register(SearchVM.self){r in
        SearchVM(r.resolve(ShopInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    current.register(DetailProductVM.self){r in
        DetailProductVM(r.resolve(ShopInteractor.self)!, r.resolve(Cacher.self)!)}.inObjectScope(.container)
    
    // ViewControler
    
    current.storyboardInitCompleted(MainVC.self){ r, c in
        c.vm = r.resolve(MainVM.self)
    }
    current.storyboardInitCompleted(OfferVC.self){ r, c in
        c.vm = r.resolve(OfferVM.self)
    }
    current.storyboardInitCompleted(SearchVC.self){ r, c in
        c.vm = r.resolve(SearchVM.self)
    }
    current.storyboardInitCompleted(DetailProductVC.self){ r, c in
        c.vm = r.resolve(DetailProductVM.self)
    }
    current.storyboardInitCompleted(ProductMiniVC.self){ r, c in}
}
