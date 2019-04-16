//
//  OfferVM.swift
//  sasheramed
//
//  Created by Aleksandr on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import RxSwift

class OfferVM {
    private let mInteractor: ShopInteractor
    private let mCacher: Cacher
    
    var beastSellers = Variable<[Product]>([])
    var sellProducts = Variable<[Product]>([])
    var newItems = Variable<[Product]>([])
    
    
    init(_ authInteractor: ShopInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
        getSallers()
        getBeastSellers()
        getNews()
    }
    
    func getSallers(){
        _ = mInteractor.getSellers()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    self.sellProducts.value = value
            },
                onError: { error in
                    self.mCacher.process(error)
            }
        )
    }
    
    func getBeastSellers(){
        _ = mInteractor.getHits()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    self.beastSellers.value = value
            },
                onError: { error in
                    self.mCacher.process(error)
            }
        )
    }
    
    func getNews(){
        _ = mInteractor.getNews()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    self.newItems.value = value
            },
                onError: { error in
                    self.mCacher.process(error)
            }
        )
    }
}
