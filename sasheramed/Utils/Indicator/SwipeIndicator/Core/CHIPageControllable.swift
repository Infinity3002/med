//
//  CHIPageControllable.swift
//  sasheramed
//
//  Created by Aleksandr on 4/2/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

protocol CHIPageControllable: class {
    var numberOfPages: Int { get set }
    var currentPage: Int { get }
    var progress: Double { get set }
    var hidesForSinglePage: Bool { get set }
    var borderWidth: CGFloat { get set }
    
    func set(progress: Int, animated: Bool)
}
