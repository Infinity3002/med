//
//  Requests.swift
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation



public struct Requests{
    
    public static let SERVER  = "http://sachera-med.tisrol1m.beget.tech"
    public static let SERVER_API  = SERVER + "/api/"
    public static let GET_TOKEN = SERVER_API + "user/token"
    public static let SIGNUP = SERVER_API + "user/"
    public static let PROFILE = SERVER_API + "user"
    // получение списков где токен не нужен
    public static let NEW_ITEMS = SERVER_API + "promo/new_items"
    public static let NEW_HITS = SERVER_API + "promo/hits"
    public static let SEARCH = SERVER_API + "promo/search"
    public static let SALLES = SERVER_API + "promo/sale"
    public static let SHOP_ADDRESS = SERVER_API + "promo/where_buy"
    public static let RELATED_PRODUCTS = SERVER_API + "promo/related_products"
}
