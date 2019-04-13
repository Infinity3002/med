//
//  SignInVM.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import RxSwift

public final class SignInVM {
    
    private let mInteractor: AuthInteractor
    private let mCacher: Cacher
    
    public var isAuth: Variable<Bool> = Variable<Bool>(false)
    
    let form: SignInForm = SignInForm()
    
    init(_ authInteractor: AuthInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
    }
    
    func signIn(){
        _ = mInteractor.signIn(form)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    self.isAuth.value = true
                },
                onError: { error in
                    if(error is NetworkError && error as! NetworkError == NetworkError.NotFound){
                       self.mCacher.show(title: "Неправильный логин или пароль")
                    } else {
                        self.mCacher.process(error)
                    }
                }
        )
    }
}
