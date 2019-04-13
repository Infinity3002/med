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
    
    init(_ authInteractor: AuthInteractor, _ cacher: Cacher) {
        self.mInteractor = authInteractor
        self.mCacher = cacher
    }
}
