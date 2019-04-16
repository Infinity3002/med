//
//  ShopInteractor.swift
//  sasheramed
//
//  Created by Aleksandr on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import RxSwift
class ShopInteractor {
    
    let mRepository: ShopRepository
    
    init(_ repository: ShopRepository) {
        mRepository = repository
    }
    
    func getSellers() -> Single<[Product]>{
        return mRepository.getSellers()
    }
    
    func getHits() -> Single<[Product]>{
        return mRepository.getHits()
    }
    
    func getNews() -> Single<[Product]>{
        return mRepository.getNews()
    }
    
    func getRelatedProduct(_ id: String) -> Single<[ProductRelated]>{
        return mRepository.getRelatedProduct(id)
    }
    
    func search(text: String)-> Single<[ProductSearch]>{
        return mRepository.search(text:text)
    }
}
