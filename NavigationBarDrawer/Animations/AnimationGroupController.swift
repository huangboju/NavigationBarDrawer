//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

// https://zsisme.gitbooks.io/ios-/content/chapter10/animation-velocity.html

class AnimationGroupController: UIViewController {
    
    private lazy var colorLayer: CALayer = {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        colorLayer.position = CGPoint(x: 0, y: 150)
        colorLayer.backgroundColor = UIColor.green.cgColor
        return colorLayer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        animation()
        
        let startItem = UIBarButtonItem(title: "恢复", style: .plain, target: self, action: #selector(resumeAction))
        let suspendItem = UIBarButtonItem(title: "暂停", style: .plain, target: self, action: #selector(suspendAction))

        navigationItem.rightBarButtonItems = [startItem, suspendItem]
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
        view.layer.addSublayer(colorLayer)

        // create the position animation
        let animation1 = CAKeyframeAnimation(keyPath: "position")
        animation1.path = bezierPath.cgPath
        animation1.rotationMode = kCAAnimationRotateAuto

        // create the color animation
        let animation2 = CABasicAnimation(keyPath: "backgroundColor")
        animation2.toValue = UIColor.red.cgColor
        // create group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1, animation2]
        groupAnimation.duration = 4.0
        // add the animation to the color layer
        colorLayer.add(groupAnimation, forKey: nil)
    }
    
    @objc func suspendAction() {
        colorLayer.animationPause()
    }

    @objc func resumeAction() {
        colorLayer.animationResume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CALayer {
    func animationPause() {
        // 当前时间（暂停时的时间）
        // CACurrentMediaTime() 是基于内建时钟的，能够更精确更原子化地测量，并且不会因为外部时间变化而变化（例如时区变化、夏时制、秒突变等）,但它和系统的uptime有关,系统重启后CACurrentMediaTime()会被重置
        let  pauseTime = convertTime(CACurrentMediaTime(), from: nil)
        // 停止动画
        speed = 0
        // 动画的位置（动画进行到当前时间所在的位置，如timeOffset=1表示动画进行1秒时的位置）
        timeOffset = pauseTime
    }

    func animationResume() {
        // 动画的暂停时间
        let pausedTime = timeOffset
        // 动画初始化
        speed = 1
        timeOffset = 0
        beginTime = 0
        // 程序到这里，动画就能继续进行了，但不是连贯的，而是动画在背后默默“偷跑”的位置，如果超过一个动画周期，则是初始位置
        
        // 当前时间（恢复时的时间）
        let continueTime = convertTime(CACurrentMediaTime(), to: nil)
        // 暂停到恢复之间的空档
        let timePause = continueTime - pausedTime
        // 动画从timePause的位置从动画头开始
        beginTime = timePause
    }
}
