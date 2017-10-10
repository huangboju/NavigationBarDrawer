//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class ReplicatorLayerController: UIViewController {
    
    private lazy var flashingLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.backgroundColor = UIColor.orange.cgColor

        let changeColor = CABasicAnimation(keyPath: "opacity")
        changeColor.fromValue = 0.5
        changeColor.toValue   = 1
        changeColor.duration  = 0.45 // For convenience
        changeColor.repeatCount = HUGE
        changeColor.autoreverses = true
        layer.add(changeColor, forKey: "Change color")
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let replicator = CAReplicatorLayer()
        replicator.frame = CGRect(x: 40, y: 0, width: 100, height: 50)
        view.layer.addSublayer(replicator)

        // configure the replicator
        replicator.instanceCount = 5

        // apply a transform for each instance
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform = CATransform3DRotate(transform, CGFloat.pi / 5.0, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -200, 0)
        replicator.instanceTransform = transform

        // apply a color shift for each instance
        replicator.instanceBlueOffset = -0.1
        replicator.instanceGreenOffset = -0.1

        // create a sublayer and place it inside the replicator
        let layer = CALayer()
        layer.frame = CGRect(x: 100.0, y: 100.0, width: 50.0, height: 50.0)
        layer.backgroundColor = UIColor.white.cgColor
        replicator.addSublayer(layer)

        flashReplicator()
    }
    
    func flashReplicator() {
        let replicator = CAReplicatorLayer()
        replicator.frame = CGRect(x: 40, y: 100, width: 150, height: 150)
        replicator.backgroundColor = UIColor(white: 0.9, alpha: 1).cgColor
        replicator.instanceTransform = CATransform3DMakeTranslation(65, 0, 0)
        view.layer.addSublayer(replicator)
        replicator.instanceCount = 2
        replicator.addSublayer(flashingLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
