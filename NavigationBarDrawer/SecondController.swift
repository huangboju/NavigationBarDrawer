//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka

class SecondController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            SegueRow("ShapeLayer") {
                $0.title = $0.tag
                $0.controller = ShapeController.self
            }
            <<< SegueRow("TextLayer") {
                $0.title = $0.tag
                $0.controller = TextLayerController.self
            }
            <<< SegueRow("TransformLayer") {
                $0.title = $0.tag
                $0.controller = TransformLayerController.self
            }
            <<< SegueRow("GradientLayer") {
                $0.title = $0.tag
                $0.controller = GradientLayerController.self
            }
            <<< SegueRow("ReplicatorLayer") {
                $0.title = $0.tag
                $0.controller = ReplicatorLayerController.self
            }
            <<< SegueRow("ScrollLayer") {
                $0.title = $0.tag
                $0.controller = ScrollLayerController.self
            }
            <<< SegueRow("TiledLayer") {
                $0.title = $0.tag
                $0.controller = TiledLayerController.self
            }
            <<< SegueRow("EmitterLayer") {
                $0.title = $0.tag
                $0.controller = EmitterLayerController.self
            }
            <<< SegueRow("PlayerLayer") {
                $0.title = $0.tag
                $0.controller = PlayerLayerController.self
            }
            <<< SegueRow("Layer") {
                $0.title = $0.tag
                $0.controller = LayerController.self
            }
            +++ Section("animation")
            <<< SegueRow("AnimationGroup") {
                $0.title = $0.tag
                $0.controller = AnimationGroupController.self
            }
            <<< SegueRow("Transition") {
                $0.title = $0.tag
                $0.controller = TransitionController.self
            }
            <<< SegueRow("TimingFunction") {
                $0.title = $0.tag
                $0.controller = TimingFunctionController.self
            }
            <<< SegueRow("MediaTimingFunctionController") {
                $0.title = $0.tag
                $0.controller = MediaTimingFunctionController.self
            }
            <<< SegueRow("BallController") {
                $0.title = $0.tag
                $0.controller = BallController.self
            }
            <<< SegueRow("CAMediaTimingFunctionController") {
                $0.title = $0.tag
                $0.controller = CAMediaTimingFunctionController.self
            }
            <<< SegueRow("UIViewAnimationOptionController") {
                $0.title = $0.tag
                $0.controller = UIViewAnimationOptionController.self
            }
            <<< SegueRow("DrawingViewController") {
                $0.title = $0.tag
                $0.controller = DrawingViewController.self
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
