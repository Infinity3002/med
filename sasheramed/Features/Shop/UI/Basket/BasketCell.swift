//
//  BasketCell.swift
//  sasheramed
//
//  Created by Aleksandr on 4/3/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell{
    
    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var lPrice: UILabel!
    @IBOutlet weak var lCount: UILabel!
    
    func bind(_ item: Product){
        lTitle.text = item.name
        lPrice.text = String(item.price) + " p."
        lCount.text = "Кол-во: " + String(item.count)
    }
}
