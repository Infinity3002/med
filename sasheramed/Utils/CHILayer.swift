//
//  CHILayer.swift
//  sasheramed
//
//  Created by Aleksandr on 4/2/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import QuartzCore

class CHILayer: CAShapeLayer {
    
    
    override init() {
        super.init()
        self.actions = [
            "bounds": NSNull(),
            "frame": NSNull(),
            "position": NSNull()
        ]
    }
    
    override public init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
