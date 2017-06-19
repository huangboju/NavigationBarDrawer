//
//  UIViewAnimationOptionController.swift
//  NavigationBarDrawer
//
//  Created by 伯驹 黄 on 2017/4/27.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class UIViewAnimationOptionController: UIViewController {
    private lazy var segmentView: UISegmentedControl = {
        let segmentView = UISegmentedControl(items: ["curveEaseInOut", "curveEaseIn", "curveEaseOut", "curveLinear"])
        segmentView.frame.origin = CGPoint(x: 0, y: 64)
        segmentView.frame.size.width = self.view.frame.width
        segmentView.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        segmentView.selectedSegmentIndex = 0
        return segmentView
    }()


    private lazy var colorLayer: UIView = {
        let colorLayer = UIView()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer.center = CGPoint(x: self.view.bounds.width/2.0, y: self.view.bounds.height/2.0)
        colorLayer.backgroundColor = UIColor.red
        return colorLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(colorLayer)
        
        view.addSubview(segmentView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //perform the animation
        UIView.animate(withDuration: 1, delay: 0, options: selectedName, animations: { 
            self.colorLayer.center = touches.first?.location(in: self.view) ?? .zero
        }, completion: nil)
    }

    var selectedName = UIViewAnimationOptions.curveEaseInOut
    
    let names: [UIViewAnimationOptions] = [
        .curveEaseInOut,
        .curveEaseIn,
        .curveEaseOut,
        .curveLinear
    ]
    
    func valueChange() {
        selectedName = names[segmentView.selectedSegmentIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
