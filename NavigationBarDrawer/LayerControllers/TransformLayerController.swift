//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class TransformLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        var pt = CATransform3DIdentity
        pt.m34 = -1.0 / 500.0
        view.layer.sublayerTransform = pt

        // set up the transform for cube 1 and add it
        var c1t = CATransform3DIdentity
        c1t = CATransform3DTranslate(c1t, -100, 0, 0)
        let cube1 = cubeWithTransform(c1t)
        view.layer.addSublayer(cube1)

        // set up the transform for cube 2 and add it

        var c2t = CATransform3DIdentity
        c2t = CATransform3DTranslate(c2t, 100, 0, 0)
        c2t = CATransform3DRotate(c2t, -CGFloat.pi / 4, 1, 0, 0)
        c2t = CATransform3DRotate(c2t, -CGFloat.pi / 4, 0, 1, 0)
        let cube2 = cubeWithTransform(c2t)
        view.layer.addSublayer(cube2)
    }

    func faceWithTransform(_ transform: CATransform3D) -> CALayer {
        let face = CALayer()
        face.frame = CGRect(x: 30, y: 10, width: 100, height: 100)

        // apply a random color
        let red = CGFloat(arc4random() / UInt32(INT_MAX))
        let green = CGFloat(arc4random() / UInt32(INT_MAX))
        let blue = CGFloat(arc4random() / UInt32(INT_MAX))
        face.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
        // apply the transform and return
        face.transform = transform
        return face
    }

    func cubeWithTransform(_ transform: CATransform3D) -> CALayer {
        // create cube layer
        let cube = CATransformLayer()

        // add cube face 1
        var ct = CATransform3DMakeTranslation(0, 0, 50)
        cube.addSublayer(faceWithTransform(ct))

        // add cube face 2
        ct = CATransform3DMakeTranslation(50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat.pi / 2, 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))

        // add cube face 3
        ct = CATransform3DMakeTranslation(0, -50, 0)
        ct = CATransform3DRotate(ct, CGFloat.pi / 2, 1, 0, 0)
        cube.addSublayer(faceWithTransform(ct))

        // add cube face 4
        ct = CATransform3DMakeTranslation(0, 50, 0)
        ct = CATransform3DRotate(ct, -CGFloat.pi / 2, 1, 0, 0)
        cube.addSublayer(faceWithTransform(ct))

        // add cube face 5
        ct = CATransform3DMakeTranslation(-50, 0, 0)
        ct = CATransform3DRotate(ct, -CGFloat.pi / 2, 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))

        // add cube face 6
        ct = CATransform3DMakeTranslation(0, 0, -50)
        ct = CATransform3DRotate(ct, CGFloat.pi, 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))

        // center the cube layer within the container
        cube.position = CGPoint(x: 80, y: 150)
        // apply the transform and return
        cube.transform = transform
        return cube
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
