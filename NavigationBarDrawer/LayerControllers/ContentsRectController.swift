//
//  ContentsRectController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 06/01/2018.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class ContentsRectController: UIViewController {
    
    let coneView = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
    let shipView = UIView(frame: CGRect(x: 0, y: 210, width: 100, height: 100))
    let iglooView = UIView(frame: CGRect(x: 0, y: 320, width: 100, height: 100))
    let anchorView = UIView(frame: CGRect(x: 0, y: 430, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let image = UIImage(named: "contentRect")

        addSpriteImage(image, withContentRect: CGRect(x: 0, y: 0, width: 0.5, height: 0.5), toLayer: coneView.layer)
        addSpriteImage(image, withContentRect: CGRect(x: 0.5, y: 0, width: 0.5, height: 0.5), toLayer: shipView.layer)
        addSpriteImage(image, withContentRect: CGRect(x: 0, y: 0.5, width: 0.5, height: 0.5), toLayer: iglooView.layer)
        addSpriteImage(image, withContentRect: CGRect(x: 0.5, y: 0.5, width: 0.5, height: 0.5), toLayer: anchorView.layer)

        view.addSubview(coneView)
        view.addSubview(shipView)
        view.addSubview(iglooView)
        view.addSubview(anchorView)
    }
    
    //set image
    func addSpriteImage(_ image: UIImage?, withContentRect rect: CGRect,  toLayer: CALayer) {
        toLayer.contents = image?.cgImage
        //scale contents to fit
        toLayer.contentsGravity = kCAGravityResizeAspect
        //set contentsRect
        toLayer.contentsRect = rect
    }
}
