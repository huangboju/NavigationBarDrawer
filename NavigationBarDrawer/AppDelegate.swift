//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

