//
//  RBBAnimation.swift
//  NavigationBarDrawer
//
//  Created by xiAo_Ju on 2018/12/28.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class RBBAnimation: CAKeyframeAnimation {
    
    typealias RBBEasingFunction = (CGFloat) -> CGFloat
    
    var fromValue: CGFloat = 0
    var toValue: CGFloat = 0
    var easing: RBBEasingFunction = { return $0 }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as? RBBAnimation
        copy?.fromValue = fromValue
        copy?.toValue = toValue
        copy?.easing = easing
        return copy!
    }

    var animationBlock: (_ t: CGFloat, _ duration: CGFloat) -> CGFloat {
        let lerp = RBBInterpolate(f: fromValue, t: toValue)
        return { elapsed, duration in lerp(self.easing(elapsed / duration)) }
    }

    func RBBInterpolate(f: CGFloat, t: CGFloat) -> (CGFloat) -> CGFloat  {
        let delta = t - f
        return { f + $0 * delta }
    }

    override var values: [Any]? {
        set {}
        get {
            let duration = self.duration
            
            let result = (0 ..< Int(duration * 60)).map { animationBlock(CGFloat($0) / 60.0, CGFloat(duration)) }
            print(result)
            return result
        }
    }
}
