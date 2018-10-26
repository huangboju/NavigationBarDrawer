//
//  BulbLayer.swift
//  NavigationBarDrawer
//
//  Created by xiAo_Ju on 2018/10/25.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class BulbLayer: CALayer {
    @objc var brightness: CGFloat = 0
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        brightness = (layer as? BulbLayer)?.brightness ?? 0
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "brightness" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "brightness" {
            if ANIMATION_TYPE_KEYFRAME {
                // Create a basic interpolation for "briteness" animation
                let theAnimation = CAKeyframeAnimation(keyPath: event)
                // Hint: the previous value of the property is stored in the presentationLayer
                // Since for implicit animations, the model property is already set to the new value.
                theAnimation.calculationMode = .discrete
                theAnimation.values = [
                    0.0, 255.0,
                    0.0, 255.0,
                    0.0, 255.0,
                    0.0, 255.0,
                    0.0, 255.0,
                    0.0, 255.0,
                    0.0, 255.0,
                    0.0, 255.0,
                ]
                return theAnimation
            } else {
                // Create a basic interpolation for "briteness" animation
                let theAnimation = CABasicAnimation(keyPath: event)
                // Hint: the previous value of the property is stored in the presentationLayer
                // Since for implicit animations, the model property is already set to the new value.
                theAnimation.fromValue = presentation()?.value(forKey: event)
                return theAnimation
            }
        }
        return super.action(forKey: event)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
