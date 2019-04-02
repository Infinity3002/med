//
//  ProductMiniVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class ProductMiniVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [Product] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productMini", for: indexPath) as? ProductMiniCell else {
            fatalError("The dequeued cell is not an instance of PeopleViewCell.")
        }
        cell.setProduct(data[indexPath.row])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
       
        let location = sender.location(in: collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            self.performSegue(withIdentifier: "showMiniDetail", sender: data[index.row])
        }
    }
    
    public func setData(_ data: [Product]){
        self.data = data
        reloadInputViews()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMiniDetail" {
            if segue.destination.isKind(of: DetailProductVC.self){
                let detail = segue.destination as! DetailProductVC
                if(sender is Product){
                    let item = sender as! Product
                    detail.setItem(item: item)
                }
            }
        }
    }
}
