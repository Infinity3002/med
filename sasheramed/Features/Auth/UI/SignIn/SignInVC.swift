//
//  SignInVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/26/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class SignInVC: BaseVC {
    
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    var vm: SignInVM?
    
    override func viewDidLoad() {
        
        if let viewModel = vm {
            binds()
            _ = viewModel.isAuth.asObservable().subscribe({ event in  if (event.element!) {
                    self.present(MainVC.instantiateFromAppStoryboard(appStoryboard: .Shop), animated: true)
                }})
        }
    }
    
    func binds(){
        tfLogin.bind(with: vm!.form.login)
        tfPass.bind(with: vm!.form.pass)
    }
    
    @IBAction func onClickEnter(_ sender: Any) {
         vm?.signIn()
    }
}
