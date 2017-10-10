//
//  StarAnimation.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/8/24.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

class StarAnimation: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_star"))
        imageView.frame.origin = CGPoint(x: 100, y: 100)
        imageView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        imageView.alpha = 0
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(hex: 0x567321)
        textLabel.text = "65"
        textLabel.textAlignment = .center
        textLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)

        view.addSubview(textLabel)
        textLabel.center = imageView.center

        let startItem = UIBarButtonItem(title: "动画", style: .plain, target: self, action: #selector(animationAction))
        navigationItem.rightBarButtonItem = startItem
    }

    func animationAction() {
        
//        initBasicAnimation()

        UIView.animate(withDuration: 0.1, animations: {
            self.textLabel.alpha = 0
            self.imageView.alpha = 1
        }, completion: { _ in
            self.imageView.zoomIn(duration: 0.3) { _ in
                UIView.animate(withDuration: 0.25, animations: {
                    self.imageView.alpha = 0
                    self.imageView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                    self.textLabel.text = "\(arc4random_uniform(100))"
                    self.textLabel.alpha = 1
                })
            }
        })
    }

    func initBasicAnimation() {
        // 设定为缩放
        let animation = CABasicAnimation(keyPath: "transform.scale")

        // 动画选项设定
        animation.duration = 0.25 // 动画持续时间
        animation.repeatCount = 1 // 重复次数
        // 缩放倍数
        animation.fromValue = 0 // 开始时的倍率
        animation.toValue = 1 // 结束时的倍率

        let animation1 = CABasicAnimation(keyPath: "opacity")
        animation1.fromValue = 1
        animation1.toValue = 0
        animation1.duration = 0.25

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, animation1]
        groupAnimation.duration = 5
        groupAnimation.fillMode = kCAFillModeForwards
        // 添加动画 
        imageView.layer.add(groupAnimation, forKey: "scale-layer")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIView {

    /**
     Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.
    
     - parameter duration: animation duration
     */
    func zoomIn(duration: TimeInterval = 0.2, completion: ((Bool) -> Swift.Void)? = nil) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: {
            self.transform = .identity
        }, completion: completion)
    }
    
    /**
     Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.
     
     - parameter duration: animation duration
     */
    func zoomOut(duration: TimeInterval = 0.2, completion: ((Bool) -> Swift.Void)? = nil) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }, completion: completion)
    }
    
    /**
     Zoom in any view with specified offset magnification.
     
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform.identity
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
    
    /**
     Zoom out any view with specified offset magnification.
     
     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
        }, completion: { (completed: Bool) -> Void in
            UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }, completion: { (completed: Bool) -> Void in
            })
        })
    }
}
