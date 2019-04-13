//
//  NSObjectObservable.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation

extension NSObject {
    public func observe<T>(for observable: Observable<T>, with: @escaping (T) -> ()) {
        observable.bind { observable, value  in
            DispatchQueue.main.async {
                with(value)
            }
        }
    }
}
