//
//  SignUpVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/28/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC {
    
    override func viewDidLoad() {
    }
    
    @IBAction func onClickReg(_ sender: Any) {
        
       
        
       self.present(PersonalAreaVC.instantiateFromAppStoryboard(appStoryboard: .User), animated: true)
    }
}
