//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class MainTabBar: UITabBarController, UITabBarControllerDelegate {

    var indexFlag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //set up crossfade transition
        let transition = CATransition()
        // www.jianshu.com/p/239cf81eb1eb
        // https://www.jianshu.com/p/7384c0c930df
//        NSString *const kCATransitionCube = @"cube";
//        NSString *const kCATransitionSuckEffect = @"suckEffect";
//        NSString *const kCATransitionOglFlip = @"oglFlip";
//        NSString *const kCATransitionRippleEffect = @"rippleEffect";
//        NSString *const kCATransitionPageCurl = @"pageCurl";
//        NSString *const kCATransitionPageUnCurl = @"pageUnCurl";
//        NSString *const kCATransitionCameraIrisHollowOpen = @"cameraIrisHollowOpen";
//        NSString *const kCATransitionCameraIrisHollowClose = @"cameraIrisHollowClose";
        // rippleEffect 滴水效果
        transition.type = CATransitionType.fade
        transition.duration = 0.25
        //apply transition to tab bar controller's view
        tabBarController.view.layer.add(transition, forKey: nil)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = tabBar.items?.firstIndex(of: item), indexFlag != index {
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
