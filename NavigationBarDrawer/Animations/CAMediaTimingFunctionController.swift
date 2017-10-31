//
//  CAMediaTimingFunctionController.swift
//  NavigationBarDrawer
//
//  Created by 伯驹 黄 on 2017/4/27.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class CAMediaTimingFunctionController: UIViewController {
    
    private lazy var segmentView: UISegmentedControl = {
        let segmentView = UISegmentedControl(items: ["Linear", "EaseIn", "EaseOut", "EaseInEaseOut", "Default"])
        segmentView.frame.origin = CGPoint(x: 0, y: 64)
        segmentView.frame.size.width = self.view.frame.width
        segmentView.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        segmentView.selectedSegmentIndex = 0
        return segmentView
    }()


    private lazy var colorLayer: CALayer = {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer.position = CGPoint(x: self.view.bounds.width/2.0, y: self.view.bounds.height/2.0)
        colorLayer.backgroundColor = UIColor.red.cgColor
        return colorLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        view.layer.addSublayer(colorLayer)
        
        view.addSubview(segmentView)
        
        drawTimeFution()
    }
    
    var selectedName = kCAMediaTimingFunctionLinear

    let names = [
        kCAMediaTimingFunctionLinear,
        kCAMediaTimingFunctionEaseIn,
        kCAMediaTimingFunctionEaseOut,
        kCAMediaTimingFunctionEaseInEaseOut,
        kCAMediaTimingFunctionDefault
    ]

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //configure the transaction
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)

        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: selectedName))
        //set the position
        colorLayer.position = touches.first?.location(in: view) ?? .zero
        //commit transaction
        CATransaction.commit()
    }
    
    func drawTimeFution() {
        //create timing function
        
        let function = CAMediaTimingFunction(name: selectedName)
        //get control points
        var controlPoint1: Float = 0
        var controlPoint2: Float = 0
        
        function.getControlPoint(at: 1, values: &controlPoint1)
        function.getControlPoint(at: 2, values: &controlPoint2)
        //create curve
        let path = UIBezierPath()
    
        path.move(to: .zero)
        path.addCurve(to: CGPoint(x: 1, y: 1), controlPoint1: CGPoint(x: CGFloat(controlPoint1), y: 0), controlPoint2: CGPoint(x: CGFloat(controlPoint2), y: 0))
        
        //scale the path up to a reasonable size for display
        path.apply(CGAffineTransform(scaleX: 200, y: 200))
        //create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.path = path.cgPath
        view.layer.addSublayer(shapeLayer)
        //flip geometry so that 0,0 is in the bottom-left
    }

    @objc func valueChange() {
        selectedName = names[segmentView.selectedSegmentIndex]
        drawTimeFution()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
