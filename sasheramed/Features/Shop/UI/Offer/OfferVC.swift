//
//  OfferVC.swift
//  sasheramed
//
//  Created by Aleksandr on 4/1/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class OfferVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var control: CHIPageControlAleppo!
    
    var thisWidth:CGFloat = 0
    private let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        control.numberOfPages = 10
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath) as? OfferCell else {
            fatalError("The dequeued cell is not an instance of PeopleViewCell.")
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSet = scrollView.contentOffset.x
        let width = collectionView.frame.width - (collectionView.frame.width / 6)
        let horizontalCenter = width / 2
        
        control.set(progress: Int(offSet + horizontalCenter) / Int(width), animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSet = scrollView.contentOffset.x
        let width = collectionView.frame.width - (collectionView.frame.width / 6)
        let horizontalCenter = width / 2
        let pos = Int(offSet + horizontalCenter) / Int(width)
        let indexPath = IndexPath(row: pos, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = collectionView.frame.width - (collectionView.frame.width / 6)
        let horizontalCenter = width / 2
        let pos = Int(offSet + horizontalCenter) / Int(width)
        let indexPath = IndexPath(row: pos, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath)
        print(cell.frame)
        return CGSize(width:  collectionView.frame.width - (collectionView.frame.width / 6), height: collectionView.frame.height)
    }
    
    
    var sellProducts = [
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Асперин", price: 1000, description: "test test test test test test test test test test test ", weight: 50, count: 15),
        Product.init(name: "Test Test Test Test Test Test Test Test Test Test", price: 500, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test", price: 9000, description: "test test test test test test test test test test test ", weight: 100, count: 1),
        Product.init(name: "Test", price: 100, description: "test test test test test test test test test test test ", weight: 100, count: 5),
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 8),
        Product.init(name: "Test", price: 5000, description: "test test test test test test test test test test test ", weight: 100, count: 24),
        Product.init(name: "Test", price: 40, description: "test test test test test test test test test test test ", weight: 100, count: 14)
    ]
    
    var beastSellers = [
        Product.init(name: "Асперин", price: 1000, description: "test test test test test test test test test test test ", weight: 50, count: 15),
        Product.init(name: "Ибупрофен", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test Test", price: 500, description: "test test test test test test test test test test test ", weight: 100, count: 3),
        Product.init(name: "Test", price: 9000, description: "test test test test test test test test test test test ", weight: 100, count: 1),
        Product.init(name: "Валокардин", price: 100, description: "test test test test test test test test test test test ", weight: 100, count: 5),
        Product.init(name: "Test", price: 400, description: "test test test test test test test test test test test ", weight: 100, count: 8),
        Product.init(name: "Ношпа", price: 5000, description: "test test test test test test test test test test test ", weight: 100, count: 24),
        Product.init(name: "Слабительное", price: 40, description: "test test test test test test test test test test test ", weight: 100, count: 14)
    ]
    
    var containerSellProducts: ProductMiniVC? = nil
    var containerBeastSellers: ProductMiniVC? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "beastSellers2"){
            containerSellProducts = segue.destination as? ProductMiniVC
            containerSellProducts?.setData(sellProducts)
            print("sellProduct")
        }
        
        if(segue.identifier == "beastSellers"){
            containerBeastSellers = segue.destination as? ProductMiniVC
            
            containerBeastSellers?.setData(beastSellers)
            print("beastSellers")
        }
    }
}
