//
//  PresentationLayerController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 09/01/2018.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

class PresentationLayerController: UIViewController {
    
    let colorLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorLayer.position = CGPoint(x: view.bounds.width / 2, y: view.bounds.size.height / 2)
        colorLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(colorLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point = touches.first?.location(in: view) ?? .zero
        //check if we've tapped the moving layer

        if colorLayer.presentation()?.hitTest(point) != nil {
            //randomize the layer background color
            
            let red = CGFloat(arc4random_uniform(255))
            let green = CGFloat(arc4random_uniform(255))
            let blue = CGFloat(arc4random_uniform(255))
            colorLayer.backgroundColor = UIColor(r: red, g: green, b: blue).cgColor
        } else {
            //otherwise (slowly) move the layer to new position
            CATransaction.begin()
            CATransaction.setAnimationDuration(4)
            colorLayer.position = point
            CATransaction.commit()
        }
    }
}
