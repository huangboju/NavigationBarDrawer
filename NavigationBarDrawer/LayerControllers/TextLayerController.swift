//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class TextLayerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 100, y: 100, width: 30, height: 100)
        view.layer.addSublayer(textLayer)

        let font = UIFont.systemFont(ofSize: 15)

        // set layer font
        let fontName: CFString = font.fontName as CFString
        let fontRef = CGFont(fontName)
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize

        // set text attributes
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.isWrapped = true
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = "aaaaaaaaa"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
