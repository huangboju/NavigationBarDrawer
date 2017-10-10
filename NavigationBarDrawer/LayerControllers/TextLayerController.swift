//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class TextLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 100, y: 100, width: 30, height: 100)
        view.layer.addSublayer(textLayer)

        let font = UIFont.systemFont(ofSize: 15)

        // set layer font
        let fontName: CFString = font.fontName as CFString
        let fontRef = CGFont(fontName)
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize

        // set text attributes
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.isWrapped = true
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = "aaaaaaaaa"
        
        
        let tipView = TipView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        tipView.backgroundColor = UIColor.blue
        view.addSubview(tipView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class TipView: UIView {
    
    let bezierPath = UIBezierPath()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        draw()
    }

    func draw() {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 142, height: 31.6), true, 0)

        let shaperLayer = layer as? CAShapeLayer
        let strokeColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000)
        bezierPath.move(to: CGPoint(x: 71.1, y: 32.1))
        bezierPath.addLine(to: CGPoint(x: 67.1, y: 26.3))
        bezierPath.addLine(to: CGPoint(x: 5.5, y: 26.3))
        bezierPath.addLine(to: CGPoint(x: 5.5, y: 26.3))
        bezierPath.addLine(to: CGPoint(x: 5, y: 26.3))
        bezierPath.addCurve(to: CGPoint(x: 0.5, y: 21.8), controlPoint1: CGPoint(x: 2.5, y: 26.3), controlPoint2: CGPoint(x: 0.5, y: 24.3))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: 5))
        bezierPath.addLine(to: CGPoint(x: 0.5, y: 4.9))
        bezierPath.addCurve(to: CGPoint(x: 4.9, y: 0.5), controlPoint1: CGPoint(x: 0.6, y: 2.5), controlPoint2: CGPoint(x: 2.5, y: 0.6))
        bezierPath.addLine(to: CGPoint(x: 137.5, y: 0.5))
        bezierPath.addLine(to: CGPoint(x: 137.5, y: 0.5))
        bezierPath.addLine(to: CGPoint(x: 138, y: 0.5))
        bezierPath.addCurve(to: CGPoint(x: 142.5, y: 5), controlPoint1: CGPoint(x: 140.5, y: 0.5), controlPoint2: CGPoint(x: 142.5, y: 2.5))
        bezierPath.addLine(to: CGPoint(x: 142.5, y: 21.8))
        bezierPath.addLine(to: CGPoint(x: 142.5, y: 21.9))
        bezierPath.addCurve(to: CGPoint(x: 138, y: 26.3), controlPoint1: CGPoint(x: 142.4, y: 24.3), controlPoint2: CGPoint(x: 140.4, y: 26.3))
        bezierPath.addLine(to: CGPoint(x: 138, y: 26.3))
        bezierPath.addLine(to: CGPoint(x: 75.1, y: 26.3))
        bezierPath.addLine(to: CGPoint(x: 71.1, y: 32.1))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.miterLimit = 4
        bezierPath.stroke()

        shaperLayer?.fillColor = strokeColor.cgColor
        shaperLayer?.strokeColor = strokeColor.cgColor
        shaperLayer?.path = bezierPath.cgPath

        UIGraphicsEndImageContext()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
