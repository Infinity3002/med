//
//  SearchVC.swift
//  sasheramed
//
//  Created by Aleksandr on 4/3/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    var vm: SearchVM?
    
    override func viewDidLoad() {
        tableViewHeight.constant = CGFloat(150 * 10)
        
        if let viewModel = vm {
            _ = viewModel.searchItem.asObservable().subscribe({ event in  if ((event.element) != nil) {
                self.tableViewHeight.constant = CGFloat(150 * viewModel.searchItem.value.count )
                self.tableView.reloadData()
                }})
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.searchItem.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            fatalError("The dequeued cell is not an instance of ContactCell.")
        }
        cell.bind(vm!.searchItem.value[indexPath.row])
        return cell
    }
    @IBAction func editChange(_ sender: Any) {
        print(sender)
        vm?.search((sender as! UITextField).text)
    }
    
 
    
}
