//
//  CustomAnimatablePropertyVC.swift
//  NavigationBarDrawer
//
//  Created by xiAo_Ju on 2018/10/25.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

// https://blog.csdn.net/sinat_27706697/article/details/49738957

// Set Animation Trigger to 1 for explicit animations, 0 for implict animations.
let ANIMATION_TRIGGER_EXPLICIT = true

// Set Animation Type to 0 for basic animation (basic interpolation), 1 for keyframe animation.
let ANIMATION_TYPE_KEYFRAME = false

class CustomAnimatablePropertyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.yellow
        
        // Load the bulb image.
        
        let bulb = UIImage(named: "bulb.png")!
        
        // Base the size of the bulb views on the screen size.
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let bulbHeight = screenHeight / 2.1
        
        // Maintain image proportions by basing width on the width-to-height ratio.
        let widthHeightRatio = bulb.size.width / bulb.size.height
        let bulbWidth = ( bulbHeight * widthHeightRatio ) * 1.5 // times 1.5 to fatten up the bulb for added visual effect.
        
        // Define our view hierarchy.
        var bulbView: BulbView
        let startingFrame = CGRect(x: 0, y: 0, width: bulbWidth, height: bulbHeight)
        bulbView = BulbView(frame: startingFrame)
        bulbView.color = .red
        bulbView.center = CGPoint(x: 0.25 * screenWidth, y: 0.20 * screenHeight)
        view.addSubview(bulbView)
        bulbView = BulbView(frame: startingFrame)
        bulbView.color = .green
        bulbView.center = CGPoint(x: 0.5 * screenWidth, y: 0.5 * screenHeight)
        view.addSubview(bulbView)
        bulbView = BulbView(frame: startingFrame)
        bulbView.color = .blue
        bulbView.center = CGPoint(x: 0.75 * screenWidth, y: 0.80 * screenHeight)
        view.addSubview(bulbView)
    }
}
