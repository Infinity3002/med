//
//  PersonalAreaVM.swift
//  sasheramed
//
//  Created by Aleksandr on 4/16/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//
import RxSwift

class PersonalAreaVM{
    
    private let mInteractor: UserInteractor
    private let mCacher: Cacher
    
    var form: UserForm = UserForm()
    
    init(_ authInteractor: UserInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
        loadProfile()
    }
    
    func loadProfile(){
        _ = mInteractor.getUser()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess:{ value in
                    self.form.email.value = value.email
            },
                onError: { error in
                    self.mCacher.process(error)
            }
        )
    }
}
