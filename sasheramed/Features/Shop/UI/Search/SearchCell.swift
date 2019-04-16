//
//  SearchCell.swift
//  sasheramed
//
//  Created by Aleksandr on 4/3/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell{
    
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var lPrice: UILabel!
    @IBOutlet weak var lCount: UILabel!
    @IBOutlet weak var ivPreview: UIImageView!
    
    func bind(_ item: Product){
        lName.text = item.name
        lPrice.text = (item.price?.price ?? "0") + "p."
        lCount.text = "Кол-во: " + String(item.count ?? 0)
    }
    
    @IBAction func onClickDetail(_ sender: Any) {
    }
}
