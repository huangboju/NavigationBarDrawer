//
//  BulbView.swift
//  NavigationBarDrawer
//
//  Created by xiAo_Ju on 2018/10/25.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class BulbView: UIView {
    var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0
    var on = false
    var currentContext: CGContext?
    var image: UIImage?
    var color = UIColor.red {
        didSet {
            let cgColor = color.cgColor
            if let colors = cgColor.components {
                red = colors[0] * 255.0
                green = colors[1] * 255.0
                blue = colors[2] * 255.0
            }
        }
    }
    
    override class var layerClass: AnyClass {
        return BulbLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        generalInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // General bulb initialization.
    private func generalInit() {
        
        // Grab the bulb image and log whether or not we succeeded to load the image.
        self.image = UIImage(named: "bulb.png")
        
        // Get our layer to do a small custom configuration.
        let layer = self.layer
        // By setting opaque to NO it defines our backing store to include an alpha channel.
        layer.isOpaque = false
        
        self.color = .red
    }
    
    func animateFrom(_ from: CGFloat, to: CGFloat) {
        // Create a basic interpolation for "briteness" animation
        if ANIMATION_TYPE_KEYFRAME {
            let theAnimation = CAKeyframeAnimation()
            theAnimation.duration = 1.0
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
            layer.add(theAnimation, forKey: "brightness")
        } else {
            let theAnimation = CABasicAnimation()
            theAnimation.duration = 1.0
            theAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            theAnimation.fromValue = from
            theAnimation.toValue = to
            layer.add(theAnimation, forKey: "brightness")
        }
    }

    func setOn(_ on: Bool, animated: Bool) {
        if !animated {
            (layer as? BulbLayer)?.brightness = (on ? 1 : 0) * 255
            return
        }
        if on {
            if self.on { return }
            self.on = true
            if ANIMATION_TRIGGER_EXPLICIT {
                animateFrom(0, to: 255)
            }
        } else {
            if !self.on { return }
            self.on = false
            if ANIMATION_TRIGGER_EXPLICIT {
                animateFrom(255, to: 0)
            }
        }
        // Set the model layer's brightness to the final value.
        
        if ANIMATION_TRIGGER_EXPLICIT {
            // For explicit animations, disable implicit animations to avoid triggering the default action.
            CATransaction.begin()
            CATransaction.setDisableActions(true)
        }
        (layer as? BulbLayer)?.brightness = (on ? 1 : 0) * 255
        if ANIMATION_TRIGGER_EXPLICIT {
            CATransaction.commit()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
//    layer方法响应链有两种:
//
//    1. [layer setNeedDisplay] -> [layer displayIfNeed] -> [layer display] -> [layerDelegate displayLayer:]
//
//    2. [layer setNeedDisplay] -> [layer displayIfNeed] -> [layer display] -> [layer drawInContext:] -> [layerDelegate drawLayer: inContext:]
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {

        // Get the current state of the bulb's "brightness"
        // Core Animation is animating this value on our behalf.
        let brightness = (layer as? BulbLayer)?.brightness ?? 0
        
        print(brightness)

        // Calculate the bulbs current color (via RGB components) based on
        // the bulb's current "brightness".
        let redDiff = 255 - red
        let greenDiff = 255 - green
        let blueDiff = 255 - blue
        let curRed = red + redDiff * (brightness / 255.0)
        let curGreen = green + greenDiff * (brightness / 255.0)
        let curBlue = blue + blueDiff * (brightness / 255.0)
        
        
        
        // Start an offscreen graphics context
        UIGraphicsBeginImageContextWithOptions(self.image!.size, true, 1.0)
        currentContext = UIGraphicsGetCurrentContext()

        let imageRect = currentContext?.boundingBoxOfClipPath ?? .zero
        
        // Fill the context with our bulbs current color.
        let color = UIColor(r: curRed, g: curGreen, b: curBlue)
        color.set()
        
        let path = UIBezierPath(rect: currentContext?.boundingBoxOfClipPath ?? .zero)
        path.fill()
        
        // Draw the bulb image into the context.
        currentContext?.draw(self.image!.cgImage!, in: imageRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        // Define the colors that will be masked out of the final image.
        let maskingColors: [CGFloat] = [248.0, 255.0, 248.0, 255.0, 248.0, 255.0]
        
        // Apply the mask and create the final image.
        let finalImage = image?.cgImage?.copy(maskingColorComponents: maskingColors)

        // Get our context's rect and draw the final bulb image into it.
        
        let contextRect = ctx.boundingBoxOfClipPath
        ctx.draw(finalImage!, in: contextRect)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setOn(!on, animated: true)
    }
}
