//
//  DetailProductVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class DetailProductVC: UIViewController {
   
    @IBOutlet weak var mPreview: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mPrice: UILabel!
    @IBOutlet weak var lDescription: UILabel!
    @IBOutlet weak var lWeight: UILabel!
    
    private var mItem: Product?
    
    var containerRelatedProducts: ProductMiniVC? = nil
    
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
    
    override func viewDidLoad() {
        if let item = mItem {
            
            mTitle.text = item.name
            mPrice.text = String(item.price) + " p."
            lDescription.text = item.description
            lWeight.text = String(item.weight) + " г."
        }
    }
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showRelatedProduct"){
            containerRelatedProducts = segue.destination as? ProductMiniVC
            containerRelatedProducts?.setData(sellProducts)
        }
    }
    
    func setItem(item: Product){
        self.mItem = item
    }
    
}
