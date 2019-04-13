//
//  AppModule.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Swinject
import SwinjectStoryboard


let appModule = Container(){ parent in
    parent.register(Networking.self){ _ in Network()}
    parent.register(Cacher.self){ _ in Cacher() }
}
