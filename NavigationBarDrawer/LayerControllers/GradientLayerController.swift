//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class GradientLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        // create gradient layer and add it to our container view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 50, y: 100, width: 200, height: 200)
        view.layer.addSublayer(gradientLayer)

        // set gradient colors
        
        gradientLayer.colors = [
            UIColor(r: 0, g: 233, b: 249).cgColor,
            UIColor(r: 50, g: 254, b: 217).cgColor,
        ]

        gradientLayer.locations = [0.25, 0.75]
        // set gradient start and end points
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)

        let button = GradientButton(frame: CGRect(x: 15, y: 400, width: view.frame.width - 30, height: 44))
        button.setTitle("立即变现", for: .normal)
        button.setTitle("立即变现", for: .highlighted)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.highlightedBackgroundColor = UIColor(white: 1, alpha: 0.3)
        view.addSubview(button)

        generateButton()
        
        gradient()
    }
    
    func gradient() {
        // create gradient layer and add it to our container view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 500, width: view.frame.width, height: 20)
        view.layer.addSublayer(gradientLayer)
        
        // set gradient colors
        
        gradientLayer.colors = [
            UIColor(white: 1, alpha: 0.8).cgColor,
            UIColor(white: 1, alpha: 1).cgColor
        ]

        gradientLayer.locations = [0.25, 0.75]
        // set gradient start and end points
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    }

    func generateButton() {
    
        let buttonWithShadow = UIButton(type: .custom)
        buttonWithShadow.frame = CGRect(x: 15, y: 330, width: view.frame.width - 30, height: 44)
        buttonWithShadow.setTitle("SIGN UP", for: .normal)
        buttonWithShadow.setTitle("SIGN UP", for: .highlighted)
        buttonWithShadow.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        buttonWithShadow.setTitleColor(UIColor(r: 1, g: 168, b: 244), for: .normal)
        buttonWithShadow.backgroundColor = UIColor.white
        buttonWithShadow.layer.borderColor = UIColor(r: 1, g: 168, b: 244).cgColor
        buttonWithShadow.layer.borderWidth = 2
        buttonWithShadow.layer.cornerRadius = buttonWithShadow.frame.height / 2.0
        buttonWithShadow.layer.shadowColor = UIColor.lightGray.cgColor
        buttonWithShadow.layer.shadowOpacity = 0.3
        buttonWithShadow.layer.shadowRadius = 0
        buttonWithShadow.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonWithShadow.layer.masksToBounds = false
        view.addSubview(buttonWithShadow)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class GradientButton: UIButton {
    private var highlightedBackgroundLayer = CALayer()
    private var originBorderColor: UIColor?
    var highlightedBackgroundColor: UIColor?
    var adjustsButtonWhenHighlighted = true

    var highlightedBorderColor: UIColor? {
        didSet {
            if highlightedBorderColor != nil {
                // 只要开启了highlightedBorderColor，就默认不需要alpha的高亮
                adjustsButtonWhenHighlighted = false
            }
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted && originBorderColor == nil {
                // 手指按在按钮上会不断触发setHighlighted:，所以这里做了保护，设置过一次就不用再设置了
                self.originBorderColor = UIColor(cgColor: self.layer.borderColor!)
            }
            // 渲染背景色
            if highlightedBackgroundColor != nil || highlightedBorderColor != nil {
                adjustsButtonHighlighted()
            }

            // 如果此时是disabled，则disabled的样式优先
            if !isEnabled {
                return
            }
            // 自定义highlighted样式
            guard adjustsButtonWhenHighlighted else { return }
            if isHighlighted {
                alpha = 1
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.alpha = 1
                }
            }
        }
    }

    func adjustsButtonHighlighted() {
        guard let highlightedBackgroundColor = highlightedBackgroundColor else {
            return
        }
        
        CATransaction.begin()
        // 关闭layer默认动画
        CATransaction.setDisableActions(true)

//        highlightedBackgroundLayer.qmui_removeDefaultAnimations()
        layer.insertSublayer(highlightedBackgroundLayer, at: 0)

        highlightedBackgroundLayer.frame = bounds
        highlightedBackgroundLayer.cornerRadius = layer.cornerRadius
        highlightedBackgroundLayer.backgroundColor = isHighlighted ? highlightedBackgroundColor.cgColor : UIColor.clear.cgColor
        CATransaction.commit()

        guard let highlightedBorderColor = highlightedBorderColor else { return }
        layer.borderColor = isHighlighted ? highlightedBorderColor.cgColor : originBorderColor?.cgColor

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        if let gradientLayer = layer as? CAGradientLayer {
            gradientLayer.colors = [
                UIColor(r: 0, g: 233, b: 249).cgColor,
                UIColor(r: 50, g: 254, b: 217).cgColor,
            ]

            gradientLayer.locations = [0.25, 0.75]
            // set gradient start and end points
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)

            layer.cornerRadius = frame.height / 2
            layer.shadowColor = UIColor(r: 0, g: 233, b: 249).cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.9

            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: frame.height / 2).cgPath
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
