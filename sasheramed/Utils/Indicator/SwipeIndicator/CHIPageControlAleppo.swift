//
//  CHIPageControlAleppo.swift
//  sasheramed
//
//  Created by Aleksandr on 4/2/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

open class CHIPageControlAleppo: CHIBasePageControl {
    
    fileprivate var diameter: CGFloat {
        return radius * 2
    }
    
    fileprivate var inactive = [CHILayer]()
    
    fileprivate var active: CHILayer = CHILayer()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func updateNumberOfPages(_ count: Int) {
        inactive.forEach { $0.removeFromSuperlayer() }
        inactive = [CHILayer]()
        inactive = (0..<count).map {_ in
            let layer = CHILayer()
            self.layer.addSublayer(layer)
            return layer
        }
        self.layer.addSublayer(active)
        
        setNeedsLayout()
        self.invalidateIntrinsicContentSize()
    }
    
    override func update(for progress: Double) {
        guard progress >= 0 && progress <= Double(numberOfPages - 1),
            let firstFrame = self.inactive.first?.frame,
            numberOfPages > 1 else { return }
        
        let normalized = progress * Double(diameter + padding)
        let distance = abs(round(progress) - progress)
        let mult = 1 + distance * 2
        
        var frame = active.frame
        
        frame.origin.x = CGFloat(normalized) + firstFrame.origin.x
        frame.size.width = frame.height * CGFloat(mult)
        frame.size.height = self.diameter
        
        active.frame = frame
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let floatCount = CGFloat(inactive.count)
        var x = (self.bounds.size.width - self.diameter*floatCount - self.padding*(floatCount-1))*0.5
        if(x < 0 && Int(progress) < inactive.count / 2){
            x = self.padding
        } else if(Int(progress)  == inactive.count / 2){
            let distance = abs(round(progress) - progress)
            let mult = 1 + distance * 2
            x = x * CGFloat(mult)
        }
        let y = (self.bounds.size.height - self.diameter)*0.5
        var frame = CGRect(x: x, y: y, width: self.diameter, height: self.diameter)
        
        active.cornerRadius = self.radius
        active.backgroundColor = (self.currentPageTintColor ?? self.tintColor)?.cgColor
        active.frame = frame
        
        inactive.enumerated().forEach() { index, layer in
            layer.backgroundColor = self.tintColor(position: index).withAlphaComponent(self.inactiveTransparency).cgColor
            if self.borderWidth > 0 {
                layer.borderWidth = self.borderWidth
                layer.borderColor = self.tintColor(position: index).cgColor
            }
            layer.cornerRadius = self.radius
            layer.frame = frame
            frame.origin.x += self.diameter + self.padding
        }
        update(for: progress)
    }
    
    override open var intrinsicContentSize: CGSize {
        return sizeThatFits(CGSize(width: self.bounds.size.width, height: 20))
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        return size
    }
}
