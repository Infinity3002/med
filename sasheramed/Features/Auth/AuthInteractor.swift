//
//  AuthInteractor.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import RxSwift

class AuthInteractor {
    
    private let mValidate: AuthValidate
    private let mRepository: AuthRepository
    
    init(validate: AuthValidate, repository: AuthRepository) {
        mValidate = validate
        mRepository = repository
    }
    
    func signIn(_ form: SignInForm) -> Single<EmptyResponce> {
        return mValidate.validate(form).flatMap{map -> Single<EmptyResponce> in
            return self.mRepository.signIn(SignInRequest(login: map.login.value!, pass: map.pass.value!))}
    }
    
}
