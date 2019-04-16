//
//  DetailProductVC.swift
//  sasheramed
//
//  Created by Aleksandr on 3/29/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class DetailProductVC: UIViewController {
   
    @IBOutlet weak var mPreview: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mPrice: UILabel!
    @IBOutlet weak var lDescription: UILabel!
    @IBOutlet weak var lWeight: UILabel!
    
    private var mItem: Product?
    
    var containerRelatedProducts: ProductMiniVC? = nil
    
    var vm: DetailProductVM?
    
    override func viewDidLoad() {
        if let item = mItem {
            vm?.getRelatedProduct(item.id)
            mTitle.text = item.name
            mPrice.text = (item.price?.price ?? "0") + " p."
            lDescription.setAttributedHtmlText(item.description ?? "")
            lWeight.text = (item.price?.weight ?? "0") + " г."
            if(item.image != nil){
                mPreview.downloaded(from: Requests.SERVER + item.image!)
            }
        }
        if let viewModel = vm {
            _ = viewModel.relatedProduct.asObservable().subscribe({ event in  if ((event.element) != nil) {
                    self.containerRelatedProducts?.setData(viewModel.relatedProduct.value)
                }})
        }
    }
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showRelatedProduct"){
            containerRelatedProducts = segue.destination as? ProductMiniVC
        }
    }
    
    func setItem(item: Product){
        self.mItem = item
    }
    
}
