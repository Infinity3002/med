//
//  ShopRepository.swift
//  sasheramed
//
//  Created by Aleksandr on 4/15/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Alamofire
import Locksmith
import RxSwift

class ShopRepository {
    
    private let mNetwork: Networking
    
    init(_ network: Networking) {
        mNetwork = network
    }
    
    func getSellers() -> Single<[Product]>{
        return mNetwork.requestJSON(Requests.SALLES, method: HTTPMethod.get, parameters: nil, T: [String: Product].self)
            .map { result in
                return Array(result.values)
                
        }
    }
    
    func getHits() -> Single<[Product]>{
        return mNetwork.requestJSON(Requests.NEW_HITS, method: HTTPMethod.get, parameters: nil, T: [String: Product].self)
            .map { result in
                return Array(result.values)
                
        }
    }
    
    func getNews() -> Single<[Product]>{
        return mNetwork.requestJSON(Requests.NEW_ITEMS, method: HTTPMethod.get, parameters: nil, T: [String: Product].self)
            .map { result in
                return Array(result.values)
        }
    }
    
    func getRelatedProduct(_ id: String) -> Single<[ProductRelated]>{
        return mNetwork.requestJSON(Requests.RELATED_PRODUCTS, method: HTTPMethod.get, parameters: ["id": id as NSString], T: [ProductRelated].self)
    }
    
    func search(text: String)-> Single<[ProductSearch]>{
        return mNetwork.requestJSON(Requests.SEARCH, method: HTTPMethod.get, parameters: ["q": text as NSString], T: [ProductSearch].self)
    }
}
