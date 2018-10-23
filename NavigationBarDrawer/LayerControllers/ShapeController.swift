//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class ShapeController: UIViewController {
    
    let layerView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        
        //test layer action when outside of animation block
        
        print("Outside: \(layerView.action(for: layerView.layer, forKey: "backgroundColor"))");
        //begin animation block
        UIView.beginAnimations(nil, context: nil)
        //test layer action when inside of animation block
        print("Inside: \(layerView.action(for: layerView.layer, forKey: "backgroundColor"))")
        //end animation block
        UIView.commitAnimations()
        
        drawMatchstickMen()

        borderViewTest()
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
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
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
