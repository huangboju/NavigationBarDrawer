//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class MediaTimingFunctionController: UIViewController {

    fileprivate lazy var layerView: UIView = {
        let colorView = UIView(frame: CGRect(x: 20, y: 264, width: 100.0, height: 100.0))
        return colorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // create timing function
        let function = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        var controlPoint1: [Float] = [0, 0]
        var controlPoint2: [Float] = [0, 0]
        function.getControlPoint(at: 1, values: &controlPoint1)
        function.getControlPoint(at: 2, values: &controlPoint2)
        print(controlPoint1)
        print(controlPoint2)
        // create curve
        let path = UIBezierPath()
        path.move(to: .zero)

        path.addCurve(to: CGPoint(x: 1, y: 1),
                      controlPoint1: CGPoint(x: CGFloat(controlPoint1[0]), y: CGFloat(controlPoint1[1])),
                      controlPoint2: CGPoint(x: CGFloat(controlPoint2[0]), y: CGFloat(controlPoint2[1])))
        // scale the path up to a reasonable size for display
        path.apply(CGAffineTransform(scaleX: 200, y: 200))
        // create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.path = path.cgPath
        layerView.layer.addSublayer(shapeLayer)
        // flip geometry so that 0,0 is in the bottom-left
        layerView.layer.isGeometryFlipped = true

        view.addSubview(layerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
