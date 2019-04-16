//
//  ProdictMiniCell.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class ProductMiniCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func setProduct(_ product: Product){
        self.name.text = product.name
        self.price.text = (product.price?.price ?? "0") + " p."
        if(product.image != nil) {
            self.image.downloaded(from: Requests.SERVER + product.image!)
        }
    }
}
