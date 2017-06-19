//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class GradientLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
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
        view.addSubview(button)

        generateButton()
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
}

class GradientButton: UIButton {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
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
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
