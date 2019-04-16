//
//  DetailProductVM.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//
import RxSwift

class DetailProductVM {
    private let mInteractor: ShopInteractor
    private let mCacher: Cacher

    var relatedProduct = Variable<[Product]>([])
    
    init(_ authInteractor: ShopInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
    }
    func getRelatedProduct(_ id: String){
        _ = mInteractor.getRelatedProduct(id)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    var product: [Product] = []
                    value.forEach { item in
                        product.append(Product(id: item.id, name: item.name, price: nil, description: item.description, image: item.image, count: item.count ))
                    }
                    self.relatedProduct.value = product
            },
                onError: { error in
                    self.mCacher.process(error)
            }
        )
    }
}
