//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

enum ValidateType {
    case email, phoneNumber, idCard, password, number, englishName, verificationCode
}

extension String {
    
    func validate(with type: ValidateType, autoShowAlert: Bool = true) -> Bool {
        let regular: String
        let message: String
        switch type {
        case .email:
            regular = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"
            message = "邮箱格式不正确！"
        case .phoneNumber:
            regular = "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$"
            message = "请输入正确的手机号码"
        case .idCard:
            regular = "^(^\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$"
            message = "身份证号码不正确,请再次检查"
        case .number:
            regular = "^\\d+(\\.\\d+)?$"
            message = "请输入合法的数据"
        case .password:
            regular = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}"
            message = "请输入6-20位字母和数字"
        case .englishName:
            regular = "^[a-zA-Z\\u4E00-\\u9FA5]{2,20}"
            message = "英文名不允许有空格和特殊字符，2-20个英文字母"
        case .verificationCode:
            regular = "^[0-9]{4}$"
            message = "请输入正确的验证码"
        }
        let regexEmail = NSPredicate(format: "SELF MATCHES %@", regular)
        if regexEmail.evaluate(with: self) {
            return true
        } else {
//            if autoShowAlert {
//                let vc = UIApplication.shared.keyWindow?.visibleViewController
//                vc?.showToast(message: message)
//            }
            return false
        }
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window?.backgroundColor = .white
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {}
}


#if DEBUG
// 任意界面摇一摇
extension UIWindow {

    open override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print(#function)
    }

    open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        print(#function)
    }

    open override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        print(#function)
    }
}
#endif

