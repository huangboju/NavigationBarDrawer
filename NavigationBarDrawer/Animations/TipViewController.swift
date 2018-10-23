//
//  TipViewController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/8/16.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

extension UIView {
    func pushTransition(_ duration:CFTimeInterval = 0.4) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}

class TipViewController: UIViewController {
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 26))
        textLabel.text = "最多只可以管理4个班级哦~"
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(hex: 0xB07622)
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.backgroundColor = UIColor.white
        return textLabel
    }()
    
    let texts = [
        "星期一",
        "天气好",
        "范冰冰",
        "王者荣耀",
        "刺激战场"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        view.addSubview(textLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textLabel.pushTransition()
        self.textLabel.text = self.texts[Int(arc4random_uniform(UInt32(self.texts.count)))]
    }
}
