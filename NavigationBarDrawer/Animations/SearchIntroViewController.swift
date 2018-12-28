//
//  SearchIntroViewController.swift
//  NavigationBarDrawer
//
//  Created by xiAo_Ju on 2018/12/28.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import Foundation

class SearchIntroViewController: UIViewController {
    
    let introLayer = SearchIntroLayer()
    
    let layer2 = SearchIntroLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        introLayer.frame = CGRect(x: 100, y: 200, width: 162, height: 53)
        view.layer.addSublayer(introLayer)
        
        layer2.frame = CGRect(x: 100, y: 300, width: 162, height: 53)
        view.layer.addSublayer(layer2)
        
        
        let sinus = RBBAnimation(keyPath: "position.y")
        sinus.fromValue = 0
        sinus.toValue = 10
        sinus.easing = { sin($0 * 2 * CGFloat.pi) }

        sinus.isAdditive = true
        sinus.duration = 2
        sinus.repeatCount = HUGE
        
        layer2.add(sinus, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        introLayer.startAnimation()
    }
}

class SearchIntroLayer: CALayer {
    
    override init() {
        super.init()
        contents = UIImage(named: "search_intro")?.cgImage
        contentsScale = UIScreen.main.scale
    }
    
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "position.y")
        let y = position.y
        animation.fromValue = y
        animation.toValue = y - 10
        let duration = 0.4
        animation.duration = duration
        animation.repeatCount = ceil(Float(3.0 / duration))
        animation.autoreverses = true
        add(animation, forKey: "animation")
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
