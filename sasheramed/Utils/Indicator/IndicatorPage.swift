//
//  File.swift
//  sasheramed
//
//  Created by Aleksandr on 4/2/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

import UIKit

private enum IPMoveDirection {
    case left
    case right
    func toLeft() -> Bool {
        switch self {
        case .left:
            return true
        case .right:
            return false
        }
    }
}

// MARK: - IndicatorPageConfig
// Style configuration (With default configuration)
public struct IndicatorPageConfig {
    public var smallBubbleSize: CGFloat     // Ball size
    public var mainBubbleSize: CGFloat    // Big ball size
    public var bubbleXOffsetSpace: CGFloat     // Ball spacing
    public var bubbleYOffsetSpace: CGFloat     // Vertical spacing
    public var animationDuration: CFTimeInterval     // Animation duration
    public var smallBubbleMoveRadius: CGFloat { return smallBubbleSize + bubbleXOffsetSpace}    // Ball radius
    public var backgroundColor: UIColor     // Strip background color
    public var smallBubbleColor: UIColor    // Ball color
    public var bigBubbleColor: UIColor      // Big ball color
    public init(smallBubbleSize: CGFloat = 16,
                mainBubbleSize: CGFloat = 16,
                bubbleXOffsetSpace: CGFloat = 12,
                bubbleYOffsetSpace: CGFloat = 8,
                animationDuration: CFTimeInterval = 0.2,
                backgroundColor: UIColor = UIColor(red: 0.357, green: 0.196, blue: 0.337, alpha: 1.000),
                smallBubbleColor: UIColor = UIColor(red: 0.961, green: 0.561, blue: 0.518, alpha: 1.000),
                bigBubbleColor: UIColor = UIColor(red: 0.788, green: 0.216, blue: 0.337, alpha: 1.000)) {
        self.smallBubbleSize = smallBubbleSize
        self.mainBubbleSize = mainBubbleSize
        self.bubbleXOffsetSpace = bubbleXOffsetSpace
        self.bubbleYOffsetSpace = bubbleYOffsetSpace
        self.animationDuration = animationDuration
        self.backgroundColor = backgroundColor
        self.smallBubbleColor = smallBubbleColor
        self.bigBubbleColor = bigBubbleColor
    }
}

// MARK: PageControl
open class IndicatorPage: UIControl {
    
    // Number of pages
    open var numberOfpage: Int  = 5 {
        didSet {
            if oldValue != numberOfpage {
                resetRubberIndicator()
            }
        }
    }
    open var currentIndex  = 0 {
        didSet {
            guard oldValue != currentIndex else { return }
            setCurrentIndex(currentIndex, updateLayer: true)
        }
    }
    // Event closure
    open var valueChange: ((Int) -> Void)?
    // Style configuration
    open var styleConfig: IndicatorPageConfig {
        didSet {
            resetRubberIndicator()
        }
    }
    
    // gesture
    private var indexTap: UITapGestureRecognizer?
    // All layers
    private var smallBubbles    = [IPBubbleCell]()
    private var backgroundLayer = CAShapeLayer()
    private var mainBubble      = CAShapeLayer()
    private var backLineLayer   = CAShapeLayer()
    
    // Big ball scale
    private let bubbleScale: CGFloat  = 1/3.0
    
    // Storage calculation
    private var xPointbegin: CGFloat = 0
    private var xPointEnd: CGFloat = 0
    private var yPointbegin: CGFloat = 0
    private var yPointEnd: CGFloat = 0
    
    public init(frame: CGRect, count: Int, config: IndicatorPageConfig = IndicatorPageConfig()) {
        numberOfpage = count
        styleConfig = config
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        styleConfig = IndicatorPageConfig()
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        
        // Some strange position calculations
        let y = (bounds.height - (styleConfig.smallBubbleSize + 2 * styleConfig.bubbleYOffsetSpace))/2
        let w = CGFloat(numberOfpage - 2) * styleConfig.smallBubbleSize + styleConfig.mainBubbleSize + CGFloat(numberOfpage) * styleConfig.bubbleXOffsetSpace
        let h = styleConfig.smallBubbleSize + styleConfig.bubbleYOffsetSpace * 2
        let x = (bounds.width - w)/2
        #if DEBUG
        if w > bounds.width || h > bounds.height {
            print("⚠️⚠️⚠️ TKRubberPageControl size out of bounds ⚠️⚠️⚠️")
        }
        #endif
        
        xPointbegin  = x
        xPointEnd    = x + w
        yPointbegin  = y
        yPointEnd    = y + h
        
        let lineFrame = CGRect(x: x, y: y, width: w, height: h)
        let backBubblgFrame = CGRect(x: x, y: y - (styleConfig.mainBubbleSize - h)/2, width: styleConfig.mainBubbleSize, height: styleConfig.mainBubbleSize)
        var bigBubbleFrame = backBubblgFrame.insetBy(dx: styleConfig.bubbleYOffsetSpace, dy: styleConfig.bubbleYOffsetSpace)
        
        // Horizontal line of background
        backLineLayer.path      = UIBezierPath(roundedRect: lineFrame, cornerRadius: h/2).cgPath
        backLineLayer.fillColor = styleConfig.backgroundColor.cgColor
        backLineLayer.frame = bounds
        layer.addSublayer(backLineLayer)
        
        // Circle of big balls background
        backgroundLayer.path      = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: backBubblgFrame.size)).cgPath
        backgroundLayer.frame = backBubblgFrame
        backgroundLayer.fillColor = styleConfig.backgroundColor.cgColor
        backgroundLayer.zPosition = -1
        
        layer.addSublayer(backgroundLayer)
        
        // big ball
        let origin           = bigBubbleFrame.origin
        mainBubble.path      = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: bigBubbleFrame.size)).cgPath
        mainBubble.fillColor = styleConfig.bigBubbleColor.cgColor
        bigBubbleFrame.origin    = origin
        mainBubble.frame     = bigBubbleFrame
        mainBubble.zPosition = 100
        layer.addSublayer(mainBubble)
        
        // Generating a small ball
        let bubbleOffset = styleConfig.smallBubbleSize + styleConfig.bubbleXOffsetSpace
        var bubbleFrame  = CGRect(x: x + styleConfig.bubbleXOffsetSpace + bubbleOffset, y: y + styleConfig.bubbleYOffsetSpace, width: styleConfig.smallBubbleSize, height: styleConfig.smallBubbleSize)
        for _ in 0..<(numberOfpage-1) {
            let smallBubble       = IPBubbleCell(style: styleConfig)
            smallBubble.frame     = bubbleFrame
            layer.addSublayer(smallBubble)
            smallBubbles.append(smallBubble)
            bubbleFrame.origin.x  += bubbleOffset
            smallBubble.zPosition = 1
        }
        
        // Increase click gesture
        if indexTap == nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(IndicatorPage.handleTapGestureRecognizer(_: )))
            addGestureRecognizer(tap)
            indexTap = tap
        }
    }
    
    // Reset control
    open func resetRubberIndicator() {
        smallBubbles.forEach { $0.removeFromSuperlayer() }
        smallBubbles.removeAll()
        setUpView()
        setCurrentIndex(0, updateLayer: false)
    }
    
    // Gesture event
    @objc private func handleTapGestureRecognizer(_ ges: UITapGestureRecognizer) {
        let point = ges.location(in: self)
        if point.y > yPointbegin && point.y < yPointEnd && point.x > xPointbegin && point.x < xPointEnd {
            let index = Int(point.x - xPointbegin) / Int(styleConfig.smallBubbleMoveRadius)
            setCurrentIndex(index, updateLayer: true)
        }
    }
    
    // Change index
    func setCurrentIndex(_ newIndex: Int, updateLayer: Bool) {
        let index = max(0, min(newIndex, numberOfpage - 1))
        guard index != currentIndex else { return }
        
        if updateLayer {
            // Big ball movement direction
            let direction = (currentIndex > index) ? IPMoveDirection.right : IPMoveDirection.left
            
            // Range of balls that need to exercise
            let range     = (currentIndex < index) ? (currentIndex+1)...index : index...(currentIndex-1)
            
            // Ball animation
            for index in range {
                let smallBubbleIndex = (direction.toLeft()) ? (index - 1) : (index)
                let smallBubble      = smallBubbles[smallBubbleIndex]
                smallBubble.positionChange(direction,
                                           radius: styleConfig.smallBubbleMoveRadius / 2,
                                           duration: styleConfig.animationDuration,
                                           beginTime: CACurrentMediaTime())
            }
            
            // Big ball zoom animation
            let bubbleTransformAnim      = CAKeyframeAnimation(keyPath: "transform")
            bubbleTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                                            NSValue(caTransform3D: CATransform3DMakeScale(bubbleScale, bubbleScale, 1)),
                                            NSValue(caTransform3D: CATransform3DIdentity)]
            bubbleTransformAnim.keyTimes = [0, 0.5, 1]
            bubbleTransformAnim.duration = styleConfig.animationDuration
            
            // Big ball moving animation, the position of the big ball with implicit animation will really change
            CATransaction.begin()
            CATransaction.setAnimationDuration(styleConfig.animationDuration)
            let x = xPointbegin + styleConfig.smallBubbleMoveRadius * CGFloat(index) + styleConfig.mainBubbleSize/2
            mainBubble.position.x = x
            backgroundLayer.position.x = x
            CATransaction.commit()
            mainBubble.add(bubbleTransformAnim, forKey: "Scale")
        }
        
        // change`currentIndex`
        currentIndex = index
        
        sendActions(for: UIControl.Event.valueChanged)
        
        valueChange?(currentIndex)
        
    }
    
}

// MARK: - Small Bubble
private class IPBubbleCell: CAShapeLayer, CAAnimationDelegate {
    
    var bubbleLayer = CAShapeLayer()
    let bubbleScale: CGFloat  = 0.5
    var lastDirection: IPMoveDirection!
    var styleConfig: IndicatorPageConfig
    var cachePosition = CGPoint.zero
    
    override init(layer: Any) {
        styleConfig = IndicatorPageConfig()
        super.init(layer: layer)
        setupLayer()
    }
    
    internal init(style: IndicatorPageConfig) {
        styleConfig = style
        super.init()
        setupLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        styleConfig = IndicatorPageConfig()
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    private func setupLayer() {
        frame = CGRect(x: 0, y: 0, width: styleConfig.smallBubbleSize, height: styleConfig.smallBubbleSize)
        
        bubbleLayer.path        = UIBezierPath(ovalIn: bounds).cgPath
        bubbleLayer.fillColor   = styleConfig.smallBubbleColor.cgColor
        bubbleLayer.strokeColor = styleConfig.backgroundColor.cgColor
        bubbleLayer.lineWidth   = styleConfig.bubbleXOffsetSpace / 8
        
        addSublayer(bubbleLayer)
    }
    
    // beginTime Originally reserved for small ball rotation, but it is useless if it is not effective.
    func positionChange(_ direction: IPMoveDirection, radius: CGFloat, duration: CFTimeInterval, beginTime: CFTimeInterval) {
        
        let toLeft = direction.toLeft()
        let movePath = UIBezierPath()
        var center = CGPoint.zero
        let startAngle = toLeft ? 0 : CGFloat.pi
        let endAngle   = toLeft ? CGFloat.pi : 0
        center.x += radius * (toLeft ? -1 : 1)
        lastDirection = direction
        
        movePath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: toLeft)
        
        // The small ball moves along the arc as a whole, but when the circular motion animation and the animation are superimposed together, there is no centripetal effect, so the deformation animation is placed in the sub-layer.
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = duration
        positionAnimation.beginTime = beginTime
        positionAnimation.isAdditive = true
        positionAnimation.calculationMode = CAAnimationCalculationMode.paced
        positionAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
        positionAnimation.path = movePath.cgPath
        positionAnimation.fillMode = CAMediaTimingFillMode.forwards
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.delegate = self
        cachePosition = position
        
        // Small ball deformation animation, the ball deformation is actually only on the Y axis Scale
        let bubbleTransformAnim      = CAKeyframeAnimation(keyPath: "transform")
        bubbleTransformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                                        NSValue(caTransform3D: CATransform3DMakeScale(1, bubbleScale, 1)),
                                        NSValue(caTransform3D: CATransform3DIdentity)]
        bubbleTransformAnim.keyTimes = [0, 0.5, 1]
        bubbleTransformAnim.duration = duration
        bubbleTransformAnim.beginTime = beginTime
        
        bubbleLayer.add(bubbleTransformAnim, forKey: "Scale")
        add(positionAnimation, forKey: "Position")
        
        //        // Finally, let the little ball ghosts shake
        let bubbleShakeAnim = CAKeyframeAnimation(keyPath: "position")
        bubbleShakeAnim.beginTime = beginTime + duration + 0.05
        bubbleShakeAnim.duration = 0.02
        bubbleShakeAnim.values = [NSValue(cgPoint: CGPoint(x: 0, y: 0)),
                                  NSValue(cgPoint: CGPoint(x: 0, y: 3)),
                                  NSValue(cgPoint: CGPoint(x: 0, y: -3)),
                                  NSValue(cgPoint: CGPoint(x: 0, y: 0)) ]
        bubbleShakeAnim.repeatCount = 6
        bubbleShakeAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        bubbleLayer.add(bubbleShakeAnim, forKey: "Shake")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animate = anim as? CAKeyframeAnimation {
            if animate.keyPath == "position"{
                removeAnimation(forKey: "Position")
                CATransaction.begin()
                // Change the actual position of the ball
                CATransaction.setAnimationDuration(0)
                CATransaction.setDisableActions(true)
                var point = cachePosition
                point.x += (styleConfig.smallBubbleSize + styleConfig.bubbleXOffsetSpace) * CGFloat(lastDirection.toLeft() ? -1 : 1)
                position = point
                opacity = 1
                CATransaction.commit()
            }
        }
    }
    
}
