//
//  AuthValidate.swift
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//
import RxSwift

class AuthValidate {
    
    func validate(_ form: SignInForm)-> Single<SignInForm> {
        return Single.create{ sub in
            if(form.login.value?.isEmpty ?? true){
                sub(.error(ValidationError("Поле Логин не может быть пустым")))
            } 
            if(form.pass.value?.isEmpty ?? true){
                sub(.error(ValidationError("Поле Пароль не может быть пустым")))
            }
            
            sub(.success(form))
            return Disposables.create()
        }
    }
}
