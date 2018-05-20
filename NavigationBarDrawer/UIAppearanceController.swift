//
//  UIAppearanceController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2018/5/20.
//  Copyright © 2018 xiAo_Ju. All rights reserved.
//

import UIKit

class UIAppearanceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 9.0, *) {
            UINavigationBar.appearance(whenContainedInInstancesOf: [UIAppearanceController.self]).tintColor = .red
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
