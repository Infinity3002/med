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
    var beastSellers = [
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Асперин", price: 1000, description: "test test test test test test test test test test test ", weight: 50, count: 15),
        Product.init(name: "Test Test Test Test Test Test Test Test Test Test", price: 500, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test", price: 9000, description: "test test test test test test test test test test test ", weight: 100, count: 1),
        Product.init(name: "Test", price: 100, description: "test test test test test test test test test test test ", weight: 100, count: 5),
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 8),
        Product.init(name: "Test", price: 5000, description: "test test test test test test test test test test test ", weight: 100, count: 24),
        Product.init(name: "Test", price: 40, description: "test test test test test test test test test test test ", weight: 100, count: 14)
    ]
    
    override func viewDidLoad() {
        tableviewHeight.constant = CGFloat(160 * beastSellers.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beastSellers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as? BasketCell else {
            fatalError("The dequeued cell is not an instance of ContactCell.")
        }
        cell.bind(beastSellers[indexPath.row])
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "beastSellers"){
            containerBeastSellers = segue.destination as? ProductMiniVC
            
            containerBeastSellers?.setData(beastSellers)
            print("beastSellers")
        }
    }
}
