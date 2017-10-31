//
//  RecordingAnimController.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/7/21.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class RecordingAnimController: UIViewController {

    let replicatorLayer = CAReplicatorLayer()
    
    private lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        return displayLink
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        initAnimation()

        let slider = UISlider(frame: CGRect(x: 15, y: 500, width: view.frame.width - 30, height: 44))
        slider.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        view.addSubview(slider)

        
        displayLink.add(to: RunLoop.main, forMode: .commonModes)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        displayLink.invalidate()
    }

    // http://www.kittenyang.com/anchorpoint/
    func initAnimation() {
        
        // 1.1.设置复制图层中子层总数：这里包含原始层
        replicatorLayer.instanceCount = 8
        // 1.2.设置复制子层偏移量，不包含原始层，这里是相对于原始层的x轴的偏移量
        replicatorLayer.contentsScale = UIScreen.main.scale
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(15, 0, 0)
        // 1.3.设置复制层的动画延迟事件
        replicatorLayer.instanceDelay = 0.1
        // 1.4.设置复制层的背景色，如果原始层设置了背景色，这里设置就失去效果
        replicatorLayer.instanceColor = UIColor.green.cgColor
        // 1.5.设置复制层颜色的偏移量
//        replicatorLayer.instanceGreenOffset = -0.1

        
        // 2.创建一个图层对象  单条柱形 (原始层)
        let layer = CALayer()
        layer.contentsScale = UIScreen.main.scale
        // 2.1.设置layer对象的位置
        /*
            position是layer中的anchorPoint点在superLayer中的位置坐标。因此可以说, position点是相对suerLayer的，anchorPoint点是相对layer的，两者是相对不同的坐标空间的一个重合点。
        */
//        layer.position = CGPoint(x: 15, y: view.bounds.size.height)
        // 2.2.设置layer对象的锚点

        // 2.3.设置layer对象的位置大小
        layer.frame = CGRect(x: 100, y: 100, width: 10, height: 50)
        // 2.5.设置layer对象的颜色
        layer.backgroundColor = UIColor.white.cgColor
        
        // 3.创建一个基本动画
        let basicAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        // 3.2.设置动画的属性值
        basicAnimation.toValue = 0.1
        basicAnimation.fromValue = 1
        // 3.3.设置动画的重复次数
        basicAnimation.repeatCount = 2
        // 3.4.设置动画的执行时间
        basicAnimation.duration = 0.5
        // 3.5.设置动画反转
//        basicAnimation.autoreverses = true

        // 4.将动画添加到layer层上
        layer.add(basicAnimation, forKey: nil)
        
        // 5.将layer层添加到复制层上
        replicatorLayer.addSublayer(layer)
        replicatorLayer.speed = 0.0
    
        // 6.将复制层添加到view视图层上
        view.layer.addSublayer(replicatorLayer)
    }

    @objc func valueChange(sender: UISlider) {
        replicatorLayer.timeOffset = CFTimeInterval(sender.value)
    }

    var value: Double = 0.01

    @objc func getCurrentWave() {
        replicatorLayer.timeOffset = value
        value += 0.01
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
