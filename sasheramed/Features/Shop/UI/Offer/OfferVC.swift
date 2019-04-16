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
    @IBOutlet weak var pbLoadingNews: UIActivityIndicatorView!
    @IBOutlet weak var tfSearch: UITextField!
    
    var vm: OfferVM?
    
    var thisWidth:CGFloat = 0
    private let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        if let viewModel = vm {
            _ = viewModel.sellProducts.asObservable().subscribe({ event in  if ((event.element) != nil) {
                self.containerSellProducts?.setData(viewModel.sellProducts.value)
                }})
            
            _ = viewModel.beastSellers.asObservable().subscribe({ event in  if ((event.element) != nil) {
                self.containerBeastSellers?.setData(viewModel.beastSellers.value)
                }})
            
            _ = viewModel.newItems.asObservable().subscribe({ event in  if ((event.element) != nil) {
                if(viewModel.newItems.value.count > 0){
                    self.pbLoadingNews.stopAnimating()
                }
                self.control.numberOfPages = viewModel.newItems.value.count
                self.collectionView.reloadData()
                }})
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm!.newItems.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath) as? OfferCell else {
            fatalError("The dequeued cell is not an instance of PeopleViewCell.")
        }
        cell.bind(vm!.newItems.value[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          if(vm?.newItems.value.count ?? 0 > 0){
            let offSet = scrollView.contentOffset.x
            let width = collectionView.frame.width - (collectionView.frame.width / 6)
            let horizontalCenter = width / 2
            let p = Int(offSet + horizontalCenter) / Int(width)
            if(p < vm!.newItems.value.count - 1) {
                control.set(progress: p, animated: true)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(vm?.newItems.value.count ?? 0 > 0){
            let offSet = scrollView.contentOffset.x
            let width = collectionView.frame.width - (collectionView.frame.width / 6)
            let horizontalCenter = width / 2
            let pos = Int(offSet + horizontalCenter) / Int(width)
            let indexPath = IndexPath(row: pos, section: 0)
             if(indexPath.row < vm!.newItems.value.count - 1) {
                collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            }
        }
    }
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         if(vm?.newItems.value.count ?? 0 > 0){
            let offSet = scrollView.contentOffset.x
            let width = collectionView.frame.width - (collectionView.frame.width / 6)
            let horizontalCenter = width / 2
            let pos = Int(offSet + horizontalCenter) / Int(width)
            let indexPath = IndexPath(row: pos, section: 0)
             if(indexPath.row < vm!.newItems.value.count - 1) {
                collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath)
        print(cell.frame)
        return CGSize(width:  collectionView.frame.width - (collectionView.frame.width / 6), height: collectionView.frame.height)
    }
    
    var containerSellProducts: ProductMiniVC? = nil
    var containerBeastSellers: ProductMiniVC? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "beastSellers2"){
            containerSellProducts = segue.destination as? ProductMiniVC
            //containerSellProducts?.setData(sellProducts)
            print("sellProduct")
        }
        
        if(segue.identifier == "beastSellers"){
            containerBeastSellers = segue.destination as? ProductMiniVC
            
            //containerBeastSellers?.setData(beastSellers)
            print("beastSellers")
        }
    }
}
