//
//  SignUpVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/28/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class SignUpVC: BaseVC {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPatronymic: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    var vm: SignUpVM?
    
    override func viewDidLoad() {
    }
    
    @IBAction func onClickReg(_ sender: Any) {
        self.present(PersonalAreaVC.instantiateFromAppStoryboard(appStoryboard: .User), animated: true)
    }
}
