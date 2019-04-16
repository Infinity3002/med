//
//  SearchVM.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//


import RxSwift

class SearchVM {
    private let mInteractor: ShopInteractor
    private let mCacher: Cacher
     var searchItem = Variable<[Product]>([])
    
    init(_ authInteractor: ShopInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
        search("")
    }
    
    func search(_ text: String?){
        if(text != nil){
            _ = mInteractor.search(text: text!)
                .observeOn(MainScheduler.instance)
                .subscribe(
                    onSuccess:{ value in
                        var product: [Product] = []
                        value.forEach { item in
                            product.append(Product(id: item.id, name: item.name, price: nil, description: item.description, image: nil, count: 0 ))
                        }
                        self.searchItem.value = product
                },
                    onError: { error in
                        self.mCacher.process(error)
                }
                )
        }
    }
}
