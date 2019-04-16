//
//  BasketVC.swift
//  sasheramed
//
//  Created by Aleksandr on 4/3/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class BasketVC: BaseVC, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var containerBeastSellers: ProductMiniVC? = nil
 
    
    override func viewDidLoad() {
        //tableviewHeight.constant = CGFloat(160 * beastSellers.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//beastSellers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as? BasketCell else {
            fatalError("The dequeued cell is not an instance of ContactCell.")
        }
        //cell.bind(beastSellers[indexPath.row])
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "beastSellers"){
            containerBeastSellers = segue.destination as? ProductMiniVC
            
            //containerBeastSellers?.setData(beastSellers)
            print("beastSellers")
        }
    }
}
