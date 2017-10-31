//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class ShapeController: UIViewController {
    
    
    private lazy var doorLayer: CALayer = {
        let doorLayer = CALayer()
        doorLayer.frame = CGRect(x: 0, y: 100, width: 128, height: 256)
        doorLayer.position = CGPoint(x: 150 - 64, y: 150)
        doorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        doorLayer.backgroundColor = UIColor.blue.cgColor
        return doorLayer
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        drawMatchstickMen()

        borderViewTest()
        
        timeOffsetTest()
    }
    
    
    func timeOffsetTest() {
        
        let containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.layer.addSublayer(doorLayer)
        
        //apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        containerView.layer.sublayerTransform = perspective
        //add pan gesture recognizer to handle swipes
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(action))
        view.addGestureRecognizer(pan)
        //pause all layer animations
        doorLayer.speed = 0.0
        //apply swinging animation (which won't play because layer is paused)
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.y"
        animation.toValue = -(CGFloat.pi / 2)
        animation.duration = 1.0
        doorLayer.add(animation, forKey: nil)
    }
    
    @objc func action(sender: UIPanGestureRecognizer) {
        //get horizontal component of pan gesture
        
        var x = sender.translation(in: view).x
        //convert from points to animation duration //using a reasonable scale factor
        x /= 200.0
        //update timeOffset and clamp result
        var timeOffset = CGFloat(doorLayer.timeOffset)
        timeOffset = min(0.999, max(0.0, timeOffset - x))
        doorLayer.timeOffset = CFTimeInterval(timeOffset)
        //reset pan gesture
        sender.setTranslation(.zero, in: view)
    }
    
    
    func borderViewTest() {
        let borderView = UIView(frame: CGRect(x: 0, y: 100, width: 100, height: 44))
        borderView.layer.addBorder(.top)
        view.addSubview(borderView)
    }
    
    func drawMatchstickMen() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = path.cgPath
        // add it to our view
        
        view.layer.addSublayer(shapeLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CALayer {

    func addBorder(_ edge: UIRectEdge, color: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1), thickness: CGFloat = 0.5) {

        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }

        border.backgroundColor = color.cgColor

        addSublayer(border)
    }
}
