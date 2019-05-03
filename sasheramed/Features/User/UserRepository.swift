//
//  UserRepository.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//


import Alamofire
import Locksmith
import RxSwift

class UserRepository {
    
    private let mNetwork: Networking
    
    init(_ network: Networking) {
        mNetwork = network
    }
    
    func getUser() -> Single<User> {
         let dictionaryLogin = Locksmith.loadDataForUserAccount(userAccount: "sasheramed.login")
        return mNetwork.requestJSON(Requests.PROFILE, method: .get, parameters: ["login": dictionaryLogin?["login"] as! NSString], T: User.self)
    }
    
}
