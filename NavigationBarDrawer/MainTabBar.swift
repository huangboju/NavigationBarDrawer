//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class MainTabBar: UITabBarController {

    var indexFlag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.index(of: item), indexFlag != index {
            animationWithIndex(index: index)
        }
    }

    var _tabBarButtons: [UIView]!
    
    var tabBarButtons: [UIView] {
        if _tabBarButtons == nil {
            _tabBarButtons = tabBar.subviews.filter { $0.isKind(of: NSClassFromString("UITabBarButton")!) }
        }
        return _tabBarButtons!
    }

    func animationWithIndex(index: Int) {

        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.08
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = NSNumber(value: 0.7)
        pulse.toValue = NSNumber(value: 1.3)
        tabBarButtons[index].layer.add(pulse, forKey: nil)
        indexFlag = index
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        _tabBarButtons = nil
    }
}
