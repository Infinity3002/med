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
    
    func signIn(_ form: SignInForm) -> Single<TokenResponce> {
        return mValidate.validate(form).flatMap{map -> Single<TokenResponce> in
            return self.mRepository.signIn(SignInRequest(login: map.login.value!, pass: map.pass.value!))}
    }
    
    func signUp(_ form: SignUpForm) -> Single<TokenResponce>{
        return  mValidate.validate(form).flatMap{ map -> Single<EmptyResponce> in
            return self.mRepository.signUp(SignUpRequest(login: map.login.value!, pass: map.pass.value!, email: map.email.value!))
            }.flatMap{ map -> Single<TokenResponce> in
                return self.mRepository.signIn(SignInRequest(login:form.login.value!, pass: form.pass.value!))}
    }
    
}


