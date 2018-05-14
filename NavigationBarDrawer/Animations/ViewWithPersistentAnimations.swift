//
//  ViewWithPersistentAnimations.swift
//
//  Created by Grzegorz Krukowski on 12/05/2017.
//  Copyright © 2017. All rights reserved.
//

/* Solving the problem of CALayers animations being lost when application is going to background */

class ViewWithPersistentAnimations : UIView {
    private var persistentAnimations: [String: CAAnimation] = [:]
    private var persistentSpeed: Float = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationDidEnterBackground, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func didBecomeActive() {
        restoreAnimations(withKeys: Array(persistentAnimations.keys))
        persistentAnimations.removeAll()
        if persistentSpeed == 1.0 { //if layer was plaiyng before backgorund, resume it
            layer.resume()
        }
    }

    @objc func willResignActive() {
        persistentSpeed = self.layer.speed

        layer.speed = 1.0 //in case layer was paused from outside, set speed to 1.0 to get all animations
        persistAnimations(withKeys: self.layer.animationKeys())
        layer.speed = persistentSpeed //restore original speed

        layer.pause()
    }

    func persistAnimations(withKeys: [String]?) {
        withKeys?.forEach({ (key) in
            if let animation = layer.animation(forKey: key) {
                self.persistentAnimations[key] = animation
            }
        })
    }

    func restoreAnimations(withKeys: [String]?) {
        withKeys?.forEach { key in
            if let persistentAnimation = persistentAnimations[key] {
                self.layer.add(persistentAnimation, forKey: key)
            }
        }
    }
}
