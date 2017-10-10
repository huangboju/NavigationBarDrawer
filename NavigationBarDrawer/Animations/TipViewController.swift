//
//  TipViewController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/8/16.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

class TipViewController: UIViewController {
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 26))
        textLabel.text = "最多只可以管理4个班级哦~"
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(hex: 0xB07622)
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.backgroundColor = UIColor(hex: 0xFFFAD8)
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(textLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.textLabel.frame.origin.y -= 26
        }) { (flag) in
            
        }
    }
}
