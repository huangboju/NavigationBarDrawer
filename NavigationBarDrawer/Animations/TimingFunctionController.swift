//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class TimingFunctionController: UIViewController {
    fileprivate lazy var colorLayer: CALayer = {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        colorLayer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        return colorLayer
    }()

    fileprivate lazy var colorView: UIView = {
        let colorView = UIView(frame: CGRect(x: 0, y: 164, width: 100.0, height: 100.0))
        colorView.backgroundColor = UIColor.blue
        return colorView
    }()

    fileprivate lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: self.view.frame.height - 54, width: self.view.frame.width - 100, height: 44))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(change), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white


        view.layer.addSublayer(colorLayer)
        view.addSubview(colorView)
        view.addSubview(button)
        
        let barsView = BarsView(frame: CGRect(x: 0, y: 100, width: 100, height: 200))
        barsView.backgroundColor = UIColor.red
        barsView.startAnimate()
        view.addSubview(barsView)
    }

    @objc func change() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2.0
        animation.values = [
            UIColor.blue.cgColor,
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
        ]
        // add timing function

        let fn = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.timingFunctions = [fn, fn, fn]
        // apply animation to layer
        colorLayer.add(animation, forKey: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        //        CATransaction.begin()
        //        CATransaction.setAnimationDuration(1)
        //        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
        //        //set the position
        //        colorLayer.position = (touches.first?.locationInView(view))!
        //        //commit transaction
        //        CATransaction.commit()
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            self.colorView.center = (touches.first?.location(in: self.view))!
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
