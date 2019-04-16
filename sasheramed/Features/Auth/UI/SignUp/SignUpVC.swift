//
//  SignUpVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/28/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class SignUpVC: BaseVC {
    
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfReplyPass: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    var vm: SignUpVM?
    
    override func viewDidLoad() {
        
        if let viewModel = vm {
            binds()
            _ = viewModel.isAuth.asObservable().subscribe({ event in  if (event.element!) {
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.25,
                                  options: .transitionCrossDissolve, animations: {
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let s =  SwinjectStoryboard.create(name: "User", bundle: nil, container: userhModule)
                                    appDelegate.window!.rootViewController = s.instantiateViewController(withIdentifier: "PersonalAreaVC")
                                    appDelegate.window!.makeKeyAndVisible()
                })
            
            }})
        }
    }
    
    func binds(){
        tfLogin.bind(with: vm!.form.login)
        tfPass.bind(with: vm!.form.pass)
        tfReplyPass.bind(with: vm!.form.replyPass)
        tfEmail.bind(with: vm!.form.email)
    }
    
    @IBAction func onClickReg(_ sender: Any) {
        vm?.signUp()
    }
}
