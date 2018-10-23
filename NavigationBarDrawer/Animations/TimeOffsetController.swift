//
//  TimeOffsetController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 10/01/2018.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class TimeOffsetController: UIViewController {

    let containerView = UIView()
    let doorLayer = CALayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(containerView)
        
        //add the door
        doorLayer.frame = CGRect(x: 0, y: 64, width: 128, height: 256)
        doorLayer.position = CGPoint(x: 150 - 64, y: 250)
        doorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        doorLayer.backgroundColor = UIColor.red.cgColor
        containerView.layer.addSublayer(doorLayer)
        //apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        containerView.layer.sublayerTransform = perspective
        //add pan gesture recognizer to handle swipes
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        view.addGestureRecognizer(pan)
        //pause all layer animations
        doorLayer.speed = 0.0
        //apply swinging animation (which won't play because layer is paused)
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.toValue = -CGFloat.pi / 2
        animation.duration = 1.0
        doorLayer.add(animation, forKey: nil)
    }
    
    @objc
    func panAction(_ pan: UIPanGestureRecognizer) {
        //get horizontal component of pan gesture
        
        var x = pan.translation(in: view).x
        //convert from points to animation duration //using a reasonable scale factor
        x /= 200.0
        //update timeOffset and clamp result
        var timeOffset = doorLayer.timeOffset
        timeOffset = min(0.999, max(0.0, timeOffset - Double(x)))
        doorLayer.timeOffset = timeOffset;
        //reset pan gesture
        pan.setTranslation(.zero, in: view)
    }
}
