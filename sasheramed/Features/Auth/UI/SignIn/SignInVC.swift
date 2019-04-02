//
//  SignInVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/26/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class SignInVC: BaseVC {
    
    override func viewDidLoad() {
    }
    
    @IBAction func onClickEnter(_ sender: Any) {
         self.present(MainVC.instantiateFromAppStoryboard(appStoryboard: .Shop), animated: true)
    }
}
