//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class BallController: UIViewController, CAAnimationDelegate {

    fileprivate lazy var layerView: UIView = {
        let layerView = UIView(frame: CGRect(x: 20, y: 264, width: 100.0, height: 100.0))
        layerView.backgroundColor = UIColor.cyan
        layerView.layer.cornerRadius = 50
        return layerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(layerView)

        animate()
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        animate()
    }

    func animate() {
        // reset ball to top of screen
        layerView.center = CGPoint(x: 150, y: 32)
        // create keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1.0
        animation.delegate = self

        animation.values = [
            NSValue(cgPoint: CGPoint(x: 150, y: 32)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
            NSValue(cgPoint: CGPoint(x: 150, y: 140)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
            NSValue(cgPoint: CGPoint(x: 150, y: 220)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
            NSValue(cgPoint: CGPoint(x: 150, y: 250)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
        ]

        animation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
        ]

        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0]
        // apply animation
        layerView.layer.position = CGPoint(x: 150, y: 268)
        layerView.layer.add(animation, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
