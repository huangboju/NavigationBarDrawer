//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka
import GesturePassword
import Network

class ViewController: FormViewController {
    var drawer: NavigationBarDrawer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 12.0, *) {
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = {
                print($0)
            }
        } else {
            
        }

        form +++ Section("手势密码")
            <<< ButtonRow("设置密码") {
                $0.title = $0.tag
                $0.onCellSelection({ _, _ in
                   
                })
            }
            <<< ButtonRow("验证密码") {
                $0.title = $0.tag
                $0.onCellSelection({ _, _ in
                    
                })
            }
            <<< ButtonRow("修改密码") {
                $0.title = $0.tag
                $0.onCellSelection({ _, _ in
                    
                })
            }

        navigationBarDrawer()
    }

    func navigationBarDrawer() {
        let s = BDSwitch(title: "开发者")
        s.addTarget(self, action: #selector(action), for: .valueChanged)
        drawer = NavigationBarDrawer()
        drawer?.scrollView = tableView
        drawer?.objects = [s]
//        let systemItems: [UIBarButtonItem.SystemItem] = [.add, .flexibleSpace, .trash, .flexibleSpace, .add]
//                drawer?.items = systemItems.map{ UIBarButtonItem(barButtonSystemItem: $0, target: self, action: #selector(action)) }
        navigationItem.rightBarButtonItem = editButtonItem
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(leftAction))
        navigationItem.leftBarButtonItem = leftBarButton

        if let leftView = navigationItem.leftBarButtonItem?.value(forKey: "_view") as? UIView {

            let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
            leftView.addGestureRecognizer(longpress)
            leftView.backgroundColor = UIColor.red
        }
    }

    @objc func longPressAction(sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            drawer?.showFromNavigationBar(navigationController, true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            drawer?.showFromNavigationBar(navigationController, true)
        } else {
            drawer?.hideAnimated(true)
        }
    }

    @objc func leftAction() {
        print("aaaaaa")
    }

    @objc func action() {
        print("aaaaaa")
    }
}
