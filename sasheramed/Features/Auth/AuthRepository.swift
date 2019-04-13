//
//  AuthRepository.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Alamofire

import RxSwift

class AuthRepository{
    
    
    private let mNetwork: Networking
    
    init(_ network: Networking) {
        mNetwork = network
    }
    
    func signIn(_ request: SignInRequest) -> Single<EmptyResponce>{
        return mNetwork.requestJSON(Requests.GET_TOKEN, method: HTTPMethod.post, parameters: request.params, T: EmptyResponce.self)
    }
}
