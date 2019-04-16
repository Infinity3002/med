//
//  OfferCell.swift
//  sasheramed
//
//  Created by Aleksandr on 4/1/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class OfferCell: UICollectionViewCell{
    
    @IBOutlet weak var iPreview: UIImageView!
    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var tfCount: UILabel!
    
    
    func bind(_ item:Product){
        if(item.image != nil){
            self.iPreview.downloaded(from: Requests.SERVER + item.image!)
        }
        self.tfName.text = item.name
        self.tfCount.text = "Кол-во: 0"
    }
}
