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

//        animate()
        animateAAA()
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
//        animate()
        animateAAA()
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
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn),
        ]

        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0]
        // apply animation
        layerView.layer.position = CGPoint(x: 150, y: 268)
        layerView.layer.add(animation, forKey: nil)
    }
    
    func animateAAA() {
        //reset ball to top of screen
        layerView.center = CGPoint(x: 150, y: 32)
        //set up animation parameters
        let fromValue = CGPoint(x: 150, y: 32)
        let toValue = CGPoint(x: 150, y: 268)
        let duration = 1.0
        //generate keyframes
        let numFrames = duration * 60
        var frames: [CGPoint] = []
        for i in 0 ..< Int(numFrames) {
            var time = 1 / CGFloat(numFrames) * CGFloat(i)
            //apply easing
            time = bounceEaseOut(time)
            //add keyframe
            frames.append(interpolateFromValue(fromValue: fromValue, toValue: toValue, time: time))
        }
        //create keyframe animation
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 1.0
        animation.values = frames
        //apply animation
        layerView.layer.add(animation, forKey: nil)
    }
    
    func interpolate(_ from: CGFloat, _ to: CGFloat, _ time: CGFloat) -> CGFloat {
        return (to - from) * time + from
    }

    func interpolateFromValue(fromValue: CGPoint, toValue: CGPoint, time: CGFloat) -> CGPoint {
        let from = fromValue
        let to = toValue
        let result = CGPoint(x: interpolate(from.x, to.x, time), y: interpolate(from.y, to.y, time))
        return result
    }

    func bounceEaseOut(_ t: CGFloat) -> CGFloat {
        if (t < 4/11.0) {
            return (121 * t * t)/16.0
        } else if (t < 8/11.0) {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0
        } else if (t < 9/10.0) {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
    }
    
    func quadraticEaseInOut(_ t: CGFloat) -> CGFloat {
        return (t < 0.5) ? (2 * t * t) : (-2 * t * t) + (4 * t) - 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
