//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka

class SecondController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++
            creatSegueRow(with: ShapeController.self)
            <<< creatSegueRow(with: TextLayerController.self)
            <<< creatSegueRow(with: TransformLayerController.self)
            <<< creatSegueRow(with: GradientLayerController.self)
            <<< creatSegueRow(with: ReplicatorLayerController.self)
            <<< creatSegueRow(with: ScrollLayerController.self)
            <<< creatSegueRow(with: TiledLayerController.self)
            <<< creatSegueRow(with: EmitterLayerController.self)
            <<< creatSegueRow(with: PlayerLayerController.self)
            <<< creatSegueRow(with: LayerController.self)
            <<< creatSegueRow(with: ContentsRectController.self)
            <<< creatSegueRow(with: PresentationLayerController.self)
            <<< creatSegueRow(with: TimeOffsetController.self)

            +++ Section("animation")

            <<< creatSegueRow(with: AnimationGroupController.self)
            <<< creatSegueRow(with: TransitionController.self)
            <<< creatSegueRow(with: TimingFunctionController.self)
            <<< creatSegueRow(with: MediaTimingFunctionController.self)
            <<< creatSegueRow(with: BallController.self)
            <<< creatSegueRow(with: CAMediaTimingFunctionController.self)
            <<< creatSegueRow(with: UIViewAnimationOptionController.self)
            <<< creatSegueRow(with: DrawingViewController.self)
            <<< creatSegueRow(with: SliderController.self)
            <<< creatSegueRow(with: PullToRefreshAnimation.self)
            <<< creatSegueRow(with: RecordingAnimController.self)
            <<< creatSegueRow(with: TipViewController.self)
            <<< creatSegueRow(with: StarAnimation.self)
    }

    func creatSegueRow(with dest: UIViewController.Type) -> SegueRow {
        return SegueRow("\(dest)") {
            $0.title = $0.tag
            $0.controller = dest
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
