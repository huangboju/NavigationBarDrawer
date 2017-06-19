//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class AnimationGroupController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        animation()
    }

    func animation() {
        // create a path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        // draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        view.layer.addSublayer(pathLayer)
        // add a colored layer
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        colorLayer.position = CGPoint(x: 0, y: 150)
        colorLayer.backgroundColor = UIColor.green.cgColor
        view.layer.addSublayer(colorLayer)
        // create the position animation
        let animation1 = CAKeyframeAnimation()
        animation1.keyPath = "position"
        animation1.path = bezierPath.cgPath
        animation1.rotationMode = kCAAnimationRotateAuto
        // create the color animation
        let animation2 = CABasicAnimation()
        animation2.keyPath = "backgroundColor"
        animation2.toValue = UIColor.red.cgColor
        // create group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1, animation2]
        groupAnimation.duration = 4.0
        // add the animation to the color layer
        colorLayer.add(groupAnimation, forKey: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
