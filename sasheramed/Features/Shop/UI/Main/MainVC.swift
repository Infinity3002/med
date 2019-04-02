//
//  MainVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class MainVC: BaseVC {
    
    var sellProducts = [
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Асперин", price: 1000, description: "test test test test test test test test test test test ", weight: 50, count: 15),
        Product.init(name: "Test Test Test Test Test Test Test Test Test Test", price: 500, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test", price: 9000, description: "test test test test test test test test test test test ", weight: 100, count: 1),
        Product.init(name: "Test", price: 100, description: "test test test test test test test test test test test ", weight: 100, count: 5),
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 8),
        Product.init(name: "Test", price: 5000, description: "test test test test test test test test test test test ", weight: 100, count: 24),
        Product.init(name: "Test", price: 40, description: "test test test test test test test test test test test ", weight: 100, count: 14)
    ]
    
    var beastSellers = [
        Product.init(name: "Асперин", price: 1000, description: "test test test test test test test test test test test ", weight: 50, count: 15),
        Product.init(name: "Ибупрофен", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test Test", price: 500, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test", price: 9000, description: "test test test test test test test test test test test ", weight: 100, count: 1),
        Product.init(name: "Валокардин", price: 100, description: "test test test test test test test test test test test ", weight: 100, count: 5),
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 8),
        Product.init(name: "Ношпа", price: 5000, description: "test test test test test test test test test test test ", weight: 100, count: 24),
        Product.init(name: "Слабительное", price: 40, description: "test test test test test test test test test test test ", weight: 100, count: 14)
    ]
    
    var containerSellProducts: ProductMiniVC? = nil
    var containerBeastSellers: ProductMiniVC? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sellProduct"){
            containerSellProducts = segue.destination as? ProductMiniVC
            containerSellProducts?.setData(sellProducts)
            print("sellProduct")
        }
        
        if(segue.identifier == "beastSellers"){
            containerBeastSellers = segue.destination as? ProductMiniVC
            
            containerBeastSellers?.setData(beastSellers)
            print("beastSellers")
        }
    }
}
