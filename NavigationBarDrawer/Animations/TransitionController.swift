//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class TransitionController: UIViewController {

    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 64, width: 100, height: 100))
        imageView.image = UIImage(named: "AddICON")
        return imageView
    }()

    fileprivate lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: self.view.frame.height - 54, width: self.view.frame.width - 100, height: 44))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(performTransition), for: .touchUpInside)
        return button
    }()

    let images = [
        UIImage(named: "AddICON"),
        UIImage(named: "ads_feed"),
        UIImage(named: "ads"),
        UIImage(named: "Answer"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(imageView)
        view.addSubview(button)
    }

    func change() {
        UIView.transition(with: imageView, duration: 1, options: .transitionFlipFromLeft, animations: {
            let currentImage = self.imageView.image
            var index = self.images.firstIndex { $0 == currentImage }
            print(index ?? (Any).self)
            index = (index! + 1) % self.images.count
            self.imageView.image = self.images[index!]
        }, completion: nil)
        //        let transition = CATransition()
        //        transition.type = kCATransitionFade
        //        //apply transition to imageview backing layer
        //        imageView.layer.addAnimation(transition, forKey: nil)
        //        //cycle to next image
        //        let currentImage = imageView.image
        //        var index = images.indexOf { $0 == currentImage }
        //        print(index)
        //        index = (index! + 1) % images.count
        //        imageView.image = self.images[index!]
    }

    @objc func performTransition() {
        // preserve the current view snapshot
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        // insert snapshot view in front of this one
        let coverView = UIImageView(image: coverImage)
        coverView.frame = view.bounds
        view.addSubview(coverView)
        // update the view (we'll simply randomize the layer background color)
        view.backgroundColor = UIColor.randomColor()
        // perform animation (anything you like)
        UIView.animate(withDuration: 1, animations: {
            var transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            transform = transform.rotated(by: CGFloat.pi / 2)
            coverView.transform = transform
            coverView.alpha = 0.0
        }, completion: { _ in
            coverView.removeFromSuperview()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
