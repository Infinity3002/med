//
//  SignUpForm.swift
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

public struct SignUpForm{
    let login: Observable<String> = Observable()
    let pass: Observable<String> = Observable()
    let replyPass: Observable<String> = Observable()
    let email: Observable<String> = Observable()
}
