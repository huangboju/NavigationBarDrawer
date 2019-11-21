//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class TiledLayerController: UIViewController {

    var tiledLayer: CATiledLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            self.cutImageAndSave()
        }
        addTiledLayer()
    }

    func addTiledLayer() {
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        let tiledLayer = CATiledLayer()
        tiledLayer.frame = CGRect(x: 0, y: 0, width: 1920, height: 1200)
        self.tiledLayer = tiledLayer
        tiledLayer.delegate = self
        scrollView.contentSize = tiledLayer.frame.size
        scrollView.layer.addSublayer(tiledLayer)
        tiledLayer.setNeedsDisplay()
    }

    func cutImageAndSave() {
        if let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last {
            let imageName = filePath + "/初雪-00-00.png"
            let titleImage = UIImage(contentsOfFile: imageName)
            if titleImage != nil {
                return
            }
            let image = UIImage(named: "BingWallpaper-2015-11-22.jpg")
            let imageView = UIImageView(image: image)
            let wh: CGFloat = 256
            let size = image?.size
            let rows = Int(ceil(size!.height / wh))
            let cols = Int(ceil(size!.width / wh))

            for y in 0 ..< rows {
                for x in 0 ..< cols {
                    if let subImage = captureView(imageView, frame: CGRect(x: CGFloat(x) * wh, y: CGFloat(y) * wh, width: wh, height: wh)) {
                        let path = "\(filePath)/初雪-\(x)-\(y).png"
                        ((try? subImage.pngData()?.write(to: URL(fileURLWithPath: path), options: [.atomic])) as ()??)
                    }
                }
            }
        }
    }

    /// 切图
    func captureView(_ theView: UIView, frame: CGRect) -> UIImage? {
        // 开启图形上下文 将heView的所有内容渲染到图形上下文中
        UIGraphicsBeginImageContext(theView.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            theView.layer.render(in: context)
        }
        // 获取图片
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let ref = (img?.cgImage)?.cropping(to: frame) {
            let item = UIImage(cgImage: ref)
            return item
        }
        return nil
    }

    deinit {
        tiledLayer?.removeFromSuperlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TiledLayerController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        if let layer = layer as? CATiledLayer {
            let bounds = ctx.boundingBoxOfClipPath
            let x = Int(floor(bounds.origin.x / layer.tileSize.width))
            let y = Int(floor(bounds.origin.y / layer.tileSize.height))
            if let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last {
                let imageName = "\(filePath)/初雪-\(x)-\(y).png"
                let titleImage = UIImage(contentsOfFile: imageName)
                UIGraphicsPushContext(ctx)
                titleImage?.draw(in: bounds)
                UIGraphicsPopContext()
            }
        }
    }
}
