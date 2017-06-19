//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

extension UIViewController {
    func pushTo(_ controller: UIViewController, tag _: String?) {
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}
