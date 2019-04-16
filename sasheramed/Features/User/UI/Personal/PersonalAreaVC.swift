//
//  PersonalAreaVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/27/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class PersonalAreaVC: BaseVC{
    
    @IBOutlet weak var mBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var tfEmail: TextFieldUnderline!
    @IBOutlet weak var tfName: TextFieldUnderline!
    @IBOutlet weak var tfPatronimic: TextFieldUnderline!
    @IBOutlet weak var tfLastName: TextFieldUnderline!
    @IBOutlet weak var tfPhone: TextFieldUnderline!
    
    var vm: PersonalAreaVM?
    
    override func viewDidLoad() {
        setConstrainBottom(mBottomSpace)
        if vm != nil {
            binds()
        }
    }
    
    func binds(){
        tfEmail.bind(with: vm!.form.email)
    }
    
    @IBAction func onClickMyOrder(_ sender: Any) {
        
    }
    @IBAction func onClickBack(_ sender: Any) {
      UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.25, options: .transitionCrossDissolve,
        animations: {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let s =  SwinjectStoryboard.create(name: "Auth", bundle: nil, container: authModule)
            appDelegate.window!.rootViewController = s.instantiateInitialViewController()
        })
    }
    
}
