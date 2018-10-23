//
//  DrawingViewController.swift
//  NavigationBarDrawer
//
//  Created by 伯驹 黄 on 2017/4/28.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(DrawingView(frame: view.frame))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class DrawingView: UIView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    var shapeLayer: CAShapeLayer? {
        return layer as? CAShapeLayer
    }

    private lazy var path: UIBezierPath = {
        let path = UIBezierPath()
        return path
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        shapeLayer?.strokeColor = UIColor.red.cgColor
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer?.lineCap = CAShapeLayerLineCap.round
        shapeLayer?.lineWidth = 5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the starting point
        let point = touches.first?.location(in: self) ?? .zero

        //move the path drawing cursor to the starting point
        path.move(to: point)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the current point
        
        let point = touches.first?.location(in: self) ?? .zero
        
        //add a new line segment to our path
        path.addLine(to: point)

        //update the layer with a copy of the path
        shapeLayer?.path = path.cgPath
    }
}
