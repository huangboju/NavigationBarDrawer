//
//  BarsView.swift
//  Wavr
//
//  Created by Luciano Almeida on 10/20/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import UIKit

@IBDesignable
open class BarsView: UIView {

    fileprivate static let animationIdentifier: String = "id"
    fileprivate static let animationIdentifierLeftBar: String = "leftBar"
    fileprivate static let animationIdentifierMiddleBar: String = "middleBar"
    fileprivate static let animationIdentifierRightBar: String = "rightBar"

    
    
    
    fileprivate var leftBar: CALayer = CALayer()
    fileprivate var middleBar: CALayer = CALayer()
    fileprivate var rightBar: CALayer = CALayer()
    
    fileprivate var leftBarAnimation: CAAnimationGroup!
    fileprivate var rightBarAnimation: CAAnimationGroup!
    fileprivate var middleBarAnimation: CAAnimationGroup!
    
    fileprivate(set) var isAnimating: Bool = false

    @IBInspectable var animationTime: TimeInterval = 0.1
    
    override open var frame: CGRect{
        didSet{
            resizeBars()
        }
    }
    
    @IBInspectable open var barColors: UIColor = UIColor.white {
        didSet{
            setBarColors(color: barColors)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize(){
        isHidden = true
        backgroundColor = UIColor.clear
        layer.addSublayer(leftBar)
        layer.addSublayer(middleBar)
        layer.addSublayer(rightBar)
        resizeBars()
        setBarColors(color: UIColor.white)
    }
    
    private  func setBarColors(color: UIColor){
        leftBar.backgroundColor = color.cgColor
        middleBar.backgroundColor = color.cgColor
        rightBar.backgroundColor = color.cgColor
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        resizeBars()
    }
    private func resizeBars(){
        leftBar.frame = CGRect(x: self.frame.size.width * 0.1, y: 0.0, width: self.frame.size.width * 0.2, height: self.frame.size.height)
        middleBar.frame = CGRect(x: self.frame.size.width * 0.4, y: 0.0, width: self.frame.size.width * 0.2, height: self.frame.size.height)
        rightBar.frame = CGRect(x: self.frame.size.width * 0.7, y: 0.0, width: self.frame.size.width * 0.2, height: self.frame.size.height)
    }
    
    open func startAnimate(){
        isHidden = false
        if !isAnimating {
            isAnimating = true
            animate()
        }
        //UIView.animate(withDuration: time, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {

        
    }
    fileprivate func animate(){
        DispatchQueue.main.async {
            self.animateLeftBar()
            self.animateMiddleBar()
            self.animateRightBar()
        }
    }
    
    fileprivate func animateLeftBar(){
        let random = CGFloat(arc4random() % UInt32(self.frame.size.height))
        let leftFrame = CGRect(x: self.frame.size.width * 0.1, y: self.frame.size.height - random, width: self.frame.size.width * 0.2, height: random)
        self.leftBarAnimation = self.animation(for: self.leftBar, frame: leftFrame)
        self.leftBarAnimation.setValue(BarsView.animationIdentifierLeftBar, forKey: BarsView.animationIdentifier)
        self.leftBar.add(self.leftBarAnimation, forKey: nil)
        self.leftBar.frame.origin = leftFrame.origin
        self.leftBar.frame.size = leftFrame.size
    }
    
    fileprivate func animateMiddleBar(){
        let random = CGFloat(arc4random() % UInt32(self.frame.size.height))
        let middleFrame = CGRect(x: self.frame.size.width * 0.4, y: self.frame.size.height - random, width: self.frame.size.width * 0.2, height: random)

        self.middleBarAnimation = self.animation(for: self.middleBar, frame: middleFrame)
        self.middleBarAnimation.setValue(BarsView.animationIdentifierMiddleBar, forKey: BarsView.animationIdentifier)

        self.middleBar.add(self.middleBarAnimation, forKey: nil)
        self.middleBar.frame.origin = middleFrame.origin
        self.middleBar.frame.size = middleFrame.size
        
    }
    
    fileprivate func animateRightBar(){
        let random = CGFloat(arc4random() % UInt32(self.frame.size.height))
        let rightFrame = CGRect(x: self.frame.size.width * 0.7, y: self.frame.size.height - random, width: self.frame.size.width * 0.2, height: random)
        self.rightBarAnimation = self.animation(for: self.rightBar, frame: rightFrame)
        self.rightBarAnimation.setValue(BarsView.animationIdentifierRightBar, forKey: BarsView.animationIdentifier)

        self.rightBar.add(self.rightBarAnimation, forKey: nil)
        self.rightBar.frame.origin = rightFrame.origin
        self.rightBar.frame.size = rightFrame.size

    }
    
    fileprivate func animation(for layer: CALayer, frame: CGRect) -> CAAnimationGroup {
        let animation = CABasicAnimation(keyPath: "frame.origin")
        animation.fromValue = NSValue(cgPoint: layer.frame.origin)
        animation.toValue = NSValue(cgPoint: frame.origin)
        animation.isRemovedOnCompletion = true
        
        let sizeAnimation = CABasicAnimation(keyPath: "frame.size")
        sizeAnimation.fromValue = NSValue(cgSize: layer.frame.size)
        sizeAnimation.toValue = NSValue(cgSize: frame.size)
        sizeAnimation.isRemovedOnCompletion = true

        
        let group = CAAnimationGroup()
        group.delegate = self
        group.duration = self.animationTime
        group.repeatCount = 1
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        group.animations = [sizeAnimation, animation]
        group.isRemovedOnCompletion = true
        return group
    }

    open func stopAnimate(){
        self.isAnimating = false
        self.isHidden = true
        self.removeAnimations()
    }
    
    fileprivate func removeAnimations(){
        rightBar.removeAllAnimations()
        leftBar.removeAllAnimations()
        middleBar.removeAllAnimations()
    }
    
    deinit {
        self.removeAnimations()
    }
}

extension BarsView : CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag && isAnimating{
            if let identifier = anim.value(forKey: BarsView.animationIdentifier) as? String{
                if identifier == BarsView.animationIdentifierLeftBar {
                    self.animateLeftBar()
                }else if identifier == BarsView.animationIdentifierMiddleBar  {
                    self.animateMiddleBar()
                }else if identifier == BarsView.animationIdentifierRightBar {
                    self.animateRightBar()
                }
            }
        }else{
            self.stopAnimate()
        }
    }
}
