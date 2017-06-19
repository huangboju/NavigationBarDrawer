//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class LayerController: UIViewController, CAAnimationDelegate {

    fileprivate lazy var colorLayer: CALayer = {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        colorLayer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        return colorLayer
    }()

    fileprivate lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: self.view.frame.height - 54, width: self.view.frame.width - 100, height: 44))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(change), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var layerView: UIView = {
        let layerView = UIView(frame: CGRect(x: 50, y: 300, width: 100, height: 100))
        layerView.backgroundColor = UIColor.cyan
        return layerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.layer.addSublayer(colorLayer)

        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        colorLayer.actions = ["backgroundColor": transition]

        view.addSubview(button)

        keyframeAnimation()
    }

    func keyframeAnimation() {
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
        // add the ship
        let shipLayer = CALayer()
        shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: 0, y: 150)
        shipLayer.contents = UIImage(named: "star")?.cgImage
        view.layer.addSublayer(shipLayer)
        // create the keyframe animation
        //        let animation = CAKeyframeAnimation()
        //        animation.keyPath = "position"
        //        animation.duration = 4.0
        //
        //        animation.rotationMode = kCAAnimationRotateAuto
        //        animation.path = bezierPath.CGPath
        //        shipLayer.addAnimation(animation, forKey: nil)
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 2.0
        animation.byValue = (M_PI * 2)
        shipLayer.add(animation, forKey: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let point = touches.first?.location(in: view) {
            if colorLayer.presentation()!.hitTest(point) != nil {
                colorLayer.backgroundColor = UIColor.randomColor().cgColor
            } else {
                // otherwise (slowly) move the layer to new position
                CATransaction.begin()
                CATransaction.setAnimationDuration(1)
                colorLayer.position = point
                CATransaction.commit()
            }
        }
    }

    func change() {
        //        CATransaction.begin()
        // 关闭layer隐式动画
        //        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        //        CATransaction.setDisableActions(true)
        //        CATransaction.setAnimationDuration(1)
        //        CATransaction.setCompletionBlock {
        //            var transform = self.colorLayer.affineTransform()
        //            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
        //            self.colorLayer.setAffineTransform(transform)
        //        }

        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [UIColor.blue.cgColor, UIColor.red.cgColor, UIColor.green.cgColor]
        animation.delegate = self
        // apply animation to layer
        colorLayer.add(animation, forKey: nil)
        //        CATransaction.commit()
    }

    func animationDidStop(_: CAAnimation, finished _: Bool) {

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        CATransaction.commit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        let green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
