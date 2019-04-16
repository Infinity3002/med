//
//  AuthRepository.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Alamofire
import Locksmith
import RxSwift

class AuthRepository{
    
    private let mNetwork: Networking
    
    init(_ network: Networking) {
        mNetwork = network
    }
    
    func signIn(_ request: SignInRequest) -> Single<TokenResponce>{
        return mNetwork.requestJSON(Requests.GET_TOKEN, method: HTTPMethod.post, parameters: request.params, T: TokenResponce.self).map { data in
            do {
                try Locksmith.deleteDataForUserAccount(userAccount: "sasheramed")
            } catch {
                print(error)
            }
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: "sasheramed")
            if(dictionary?["token"] == nil){
                try Locksmith.saveData(data: ["token": data.token!], forUserAccount: "sasheramed")
            } else {
                try Locksmith.updateData(data: ["token": data.token!], forUserAccount: "sasheramed")
            }
            
            let dictionaryLogin = Locksmith.loadDataForUserAccount(userAccount: "sasheramed.login")
            if(dictionaryLogin?["login"] == nil){
                try Locksmith.saveData(data: ["login": request.params["login"] as! String], forUserAccount: "sasheramed.login")
            } else {
                try Locksmith.updateData(data: ["login": request.params["login"] as! String], forUserAccount: "sasheramed.login")
            }
            self.mNetwork.updateHeader(a: data.token!)
            return data
        }
    }
    
    func signUp(_ request: SignUpRequest) -> Single<EmptyResponce>{
         return mNetwork.requestJSON(Requests.SIGNUP, method: HTTPMethod.post, parameters: request.params, T: EmptyResponce.self)
    }
}
