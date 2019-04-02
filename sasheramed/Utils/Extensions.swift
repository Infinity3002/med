//
//  Extensions.swift
//  sasheramed
//
//  Created by Aleksandr on 3/25/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
    convenience init(hexString : String)
    {
        if let rgbValue = UInt(hexString, radix: 16) {
            let red   =  CGFloat((rgbValue >> 16) & 0xff) / 255
            let green =  CGFloat((rgbValue >>  8) & 0xff) / 255
            let blue  =  CGFloat((rgbValue      ) & 0xff) / 255
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    
    class func bgGreen() -> UIColor {
        return UIColor.init(hexString: "#367b55")
      
    }
}

extension UITextField: UITextFieldDelegate {
    
    open override func awakeFromNib() {
        delegate = self
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    func setCardView(){
        setLeftPaddingPoints(10)
        setRightPaddingPoints(10)
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.1
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    @IBInspectable var isShowCard: Bool {
        get {
            return layer.shadowRadius > 0
        }
        
        set {
            if(newValue){
                setCardView()
            }
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        get{
            return (self.rightView as? UIImageView)?.image
        }
        
        set {
            let view = UIImageView(image: newValue!.imageWithInsets(insets: UIEdgeInsets(top: 0, left: 0,bottom:0,right: 15)))
            self.rightView = view
            self.rightViewMode = .always
        }
    }
    
}



extension UIView {
    
    /*  private struct AssociatedKeys {
     static var mPadding = CGFloat()
     }*/

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        
        set {
            layer.masksToBounds = newValue
        }
    }
    
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
