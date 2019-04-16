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
    
    func validate(_ form: SignUpForm)-> Single<SignUpForm> {
        return Single.create{ sub in
            if(form.login.value?.isEmpty ?? true){
                sub(.error(ValidationError("Поле Логин не может быть пустым")))
            }
            
            if(form.pass.value?.isEmpty ?? true){
                sub(.error(ValidationError("Поле Пароль не может быть пустым")))
            }
            
            if(form.replyPass.value?.isEmpty ?? true){
                sub(.error(ValidationError("Поле Повторите пароль не может быть пустым")))
            }
            
            if(form.replyPass.value != form.pass.value){
                sub(.error(ValidationError("Пароли не совпадают")))
            }
            
            if(form.email.value?.isEmpty ?? true){
                sub(.error(ValidationError("Поле Email не может быть пустым")))
            }
            sub(.success(form))
            return Disposables.create()
        }
    }
}
