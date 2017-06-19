//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

class EAGLLayerController: UIViewController {

    var glContext: EAGLContext?
    var glLayer: CAEAGLLayer?
    var framebuffer: GLuint?
    var colorRenderbuffer: GLuint?
    var framebufferWidth: GLint?
    var framebufferHeight: GLint?
    //    var effect: GLKBaseEffect?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
