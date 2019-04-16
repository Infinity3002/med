//
//  MainVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class MainVC: BaseVC {
    
    var vm: MainVM?
    
    var containerSellProducts: ProductMiniVC? = nil
    var containerBeastSellers: ProductMiniVC? = nil
    
    override func viewDidLoad() {
        if let viewModel = vm {
            _ = viewModel.sellProducts.asObservable().subscribe({ event in  if ((event.element) != nil) {
                    self.containerSellProducts?.setData(viewModel.sellProducts.value)
                }})
            
            _ = viewModel.beastSellers.asObservable().subscribe({ event in  if ((event.element) != nil) {
                    self.containerBeastSellers?.setData(viewModel.beastSellers.value)
                }})
        }
    }
    
    @IBAction func onClickCall(_ sender: Any) {
         self.present(ContactsVC.instantiateFromAppStoryboard(appStoryboard: .User), animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sellProduct"){
            containerSellProducts = segue.destination as? ProductMiniVC
        }
        
        if(segue.identifier == "beastSellers"){
            containerBeastSellers = segue.destination as? ProductMiniVC
        }
    }
}
