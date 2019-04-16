//
//  UserInteractor.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import RxSwift

class UserInteractor {
    private let mRepository: UserRepository
    
    init(repository: UserRepository) {
        mRepository = repository
    }
    
    func getUser() -> Single<User> {
        return mRepository.getUser()
    }
}
