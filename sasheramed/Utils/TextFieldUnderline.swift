//
//  TextFieldUnderline.swift
//  sasheramed
//
//  Created by Aleksandr on 3/28/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

class TextFieldUnderline: UITextField{
    
    
    var mUnderlineColor: UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        addUnderline()
    }
    
    func addUnderline(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0, y: self.frame.height - 1, width: self.frame.size.width, height: 1.0)
        bottomLine.backgroundColor = mUnderlineColor.cgColor
        borderStyle = UITextField.BorderStyle.none
        layer.addSublayer(bottomLine)
    }

}

extension TextFieldUnderline {
    
    @IBInspectable var underlineColor: UIColor{
        get{
            return mUnderlineColor
        }
        
        set {
            mUnderlineColor = newValue
        }
    }
    
}
