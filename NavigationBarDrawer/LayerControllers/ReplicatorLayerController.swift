//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class ReplicatorLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let replicator = CAReplicatorLayer()
        replicator.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        view.layer.addSublayer(replicator)

        // configure the replicator
        replicator.instanceCount = 5

        // apply a transform for each instance
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI) / 5.0, 0, 0, 1)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
