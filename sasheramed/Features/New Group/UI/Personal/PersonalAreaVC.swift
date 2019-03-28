//
//  PersonalAreaVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/27/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class PersonalAreaVC: BaseVC{
    
    @IBOutlet weak var mBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var name: UITextField!
    
    
    override func viewDidLoad() {
        setConstrainBottom(mBottomSpace)
    }
    
    @IBAction func onClickMyOrder(_ sender: Any) {
        
    }

}
