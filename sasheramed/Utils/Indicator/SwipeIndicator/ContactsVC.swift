//
//  ContactsVC.swift
//  sasheramed
//
//  Created by Aleksandr on 4/3/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class ContactsVC: BaseVC, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let list = [
        "Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес  Адрес Адрес Адрес Адрес",
        "Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес Адрес",
        "Адрес Адрес Адрес Адрес Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес Адрес",
        "Адрес"]
    
    override func viewDidLoad() {
        scrollView.bounces = false
        tableView.bounces = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactCell else {
            fatalError("The dequeued cell is not an instance of ContactCell.")
        }
        cell.lAddress.text = list[indexPath.row]
        return cell
    }
   
}
