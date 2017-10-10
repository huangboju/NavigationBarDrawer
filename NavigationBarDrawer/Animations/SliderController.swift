//
//  SliderController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/7/14.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

class SliderController: UIViewController {
    
    private lazy var layer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 15, y: 100, width: self.view.frame.width - 30, height: 200)
//        layer.backgroundColor = UIColor.blue.cgColor

        let changeColor = CABasicAnimation(keyPath: "backgroundColor")
        changeColor.fromValue = UIColor.orange.cgColor
        changeColor.toValue   = UIColor.blue.cgColor
        changeColor.duration  = 1.0 // For convenience
        changeColor.fillMode = kCAFillModeForwards
        changeColor.isRemovedOnCompletion = false
        layer.add(changeColor, forKey: "Change color")
        layer.speed = 0.0
        return layer
    }()

    private lazy var flashingLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 15, y: 340, width: self.view.frame.width - 30, height: 200)
        layer.backgroundColor = UIColor.orange.cgColor
        
        let changeColor = CABasicAnimation(keyPath: "opacity")
        changeColor.fromValue = 0.5
        changeColor.toValue   = 1
        changeColor.duration  = 0.45 // For convenience
        changeColor.repeatCount = HUGE
        changeColor.autoreverses = true
        layer.add(changeColor, forKey: "Change color")
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        initUI()
    }

    func initUI() {

        view.layer.addSublayer(flashingLayer)


        view.layer.addSublayer(layer)

        let slider = UISlider(frame: CGRect(x: 15, y: 500, width: view.frame.width - 30, height: 44))
        slider.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        view.addSubview(slider)
    }

    func valueChange(sender: UISlider) {
        layer.timeOffset = CFTimeInterval(sender.value)
    }
}
