//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class EmitterLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let emitter = CAEmitterLayer()
        emitter.frame = CGRect(x: 100, y: 164, width: 100, height: 100)
        view.layer.addSublayer(emitter)

        // configure emitter
        emitter.renderMode = kCAEmitterLayerAdditive
        emitter.emitterPosition = CGPoint(x: emitter.frame.width / 2.0, y: emitter.frame.height / 2.0)

        // create a particle template
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "star")?.cgImage
        cell.birthRate = 150
        cell.lifetime = 5.0
        cell.color = UIColor.blue.cgColor
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat.pi * 2.0

        // add particle template to emitter
        emitter.emitterCells = [cell]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
