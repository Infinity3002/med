//
//  SignUpVM.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import RxSwift

import NotificationBannerSwift

public final class SignUpVM {
    
    private let mInteractor: AuthInteractor
    private let mCacher: Cacher
    
    public var isAuth: Variable<Bool> = Variable<Bool>(false)
    
    let form = SignUpForm()
    
    init(_ authInteractor: AuthInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
    }
    
    func signUp(){
        _ = mInteractor.signUp(form)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    self.isAuth.value = true
            },
                onError: { error in
                    self.mCacher.process(error)
            }
        )
    }
    
}
