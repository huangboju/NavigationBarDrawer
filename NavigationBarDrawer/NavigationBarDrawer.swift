//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

enum NavigationBarDrawerState {
    case hidden
    case showing
    case shown
    case hiding
}

class NavigationBarDrawer: UIToolbar {
    var scrollView: UIScrollView?
    var visible: Bool? {
        return state != .hidden
    }

    var objects: [NSObject]? {
        willSet {
            if let objects = newValue {
                guard items == nil else {
                    fatalError("objects 和 items 只能设置一个")
                }
                let controls = objects.compactMap { $0 as? BDSwitch }
                let titleLable = UILabel(frame: CGRect(x: 8, y: 31, width: 0, height: 0))
                titleLable.text = controls[0].title
                titleLable.font = UIFont.systemFont(ofSize: 8)
                titleLable.sizeToFit()
                addSubview(titleLable)
                controls[0].transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                titleLable.center.x = controls[0].center.x + 4
                controls[0].frame.origin.x = 8
                addSubview(controls[0])
            }
        }
    }

    override var items: [UIBarButtonItem]? {
        didSet {
            guard objects == nil else {
                fatalError("objects 和 items 只能设置一个")
            }
        }
    }

    fileprivate var state = NavigationBarDrawerState.hidden
    fileprivate var parentBar: UINavigationBar?
    fileprivate var verticalDrawerConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    convenience init() {
        self.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
    }

    func setUp() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        let views = ["line": lineView]
        let metrics = ["width": 1 / UIScreen.main.scale]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: .alignAllLeft, metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(width)]|", options: .alignAllLeft, metrics: metrics, views: views))
        translatesAutoresizingMaskIntoConstraints = false
        state = .hidden
    }

    func setupConstraintsWithNavigationBar(_ navigationBar: UINavigationBar) {
        var constraint: NSLayoutConstraint!
        constraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: navigationBar, attribute: .left, multiplier: 1, constant: 0)
        superview?.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: navigationBar, attribute: .right, multiplier: 1, constant: 0)
        superview?.addConstraint(constraint)

        constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        addConstraint(constraint)
    }

    func constrainBehindNavigationBar(_ navigationBar: UINavigationBar) {
        if let verticalDrawerConstraint = verticalDrawerConstraint {
            superview?.removeConstraint(verticalDrawerConstraint)
        }
        verticalDrawerConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: navigationBar, attribute: .bottom, multiplier: 1, constant: 0)
        superview?.addConstraint(verticalDrawerConstraint!)
    }

    func constrainBelowNavigationBar(_ navigationBar: UINavigationBar) {
        if let verticalDrawerConstraint = verticalDrawerConstraint {
            superview?.removeConstraint(verticalDrawerConstraint)
        }
        verticalDrawerConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: navigationBar, attribute: .bottom, multiplier: 1, constant: 0)
        superview?.addConstraint(verticalDrawerConstraint!)
    }

    func showFromNavigationBar(_ controller: UINavigationController?, _ animated: Bool) {
        guard let navigationBar = controller?.navigationBar else {
            print("Cannot display navigation bar from nil.")
            return
        }
        navigationBar.hideBottomHairline()
        if state == .shown || state == .showing {
            print("BFNavigationBarDrawer: Inconsistency warning. Drawer is already showing or is shown.")
            hideAnimated(false)
        }

        parentBar = navigationBar

        navigationBar.superview?.insertSubview(self, belowSubview: navigationBar)
        setupConstraintsWithNavigationBar(navigationBar)

        if animated && state == .hidden {
            constrainBehindNavigationBar(navigationBar)
        }
        superview?.layoutIfNeeded()

        let height = frame.height
        if let scrollView = scrollView {
            let visible = scrollView.bounds.height - scrollView.contentInset.top - scrollView.contentInset.bottom
            let diff = visible - scrollView.contentSize.height
            let fix = max(0, min(height, diff))

            var insets = scrollView.contentInset
            insets.top += height
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + fix)

            constrainBelowNavigationBar(navigationBar)
            let animations = {
                self.state = .showing
                self.superview?.layoutIfNeeded()
                self.scrollView?.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y - height)
            }

            let completion = { (_: Bool) in
                if self.state == .showing {
                    self.state = .shown
                }
            }

            if animated {
                UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: animations, completion: completion)
            } else {
                animations()
                completion(true)
            }
        }
    }

    func hideAnimated(_ animated: Bool) {
        if state == .hiding || state == .hidden {
            print("BFNavigationBarDrawer: Inconsistency warning. Drawer is already hiding or is hidden.")
            return
        }

        guard let parentBar = parentBar else {
            print("BFNavigationBarDrawer: Navigation bar should not be released while drawer is visible.")
            return
        }

        let height = frame.height
        if let scrollView = scrollView {
            let visible = scrollView.bounds.height - scrollView.contentInset.top - scrollView.contentInset.bottom
            var fix = height
            if visible <= scrollView.contentSize.height - height {
                let bottom = -scrollView.contentOffset.y + scrollView.contentSize.height
                let diff = bottom - scrollView.bounds.height + scrollView.contentInset.bottom
                fix = max(0, min(height, diff))
            }
            let offset = height - (scrollView.contentOffset.y + scrollView.contentInset.top)
            let topFix = max(0, min(height, offset
            ))
            var insets = scrollView.contentInset
            insets.top -= height
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y - topFix)
            constrainBehindNavigationBar(parentBar)

            let animations = {
                self.state = .hiding
                self.superview?.layoutIfNeeded()
                self.scrollView?.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + fix)
            }

            let completion = { (_: Bool) in
                if self.state == .hiding {
                    parentBar.showBottomHairline()
                    self.parentBar = nil
                    self.removeFromSuperview()
                    self.state = .hidden
                }
            }

            if animated {
                UIView.animate(withDuration: 0.3, delay: 0, options: .beginFromCurrentState, animations: animations, completion: completion)
            } else {
                animations()
                completion(true)
            }
        }
    }
}

extension UINavigationBar {

    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.isHidden = true
    }

    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView?.isHidden = false
    }

    fileprivate func hairlineImageViewInNavigationBar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as? UIImageView)
        }

        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }

        return nil
    }
}

extension UIToolbar {

    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.isHidden = true
    }

    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.isHidden = false
    }

    fileprivate func hairlineImageViewInToolbar(_ view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as? UIImageView)
        }

        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView = hairlineImageViewInToolbar(subview) {
                return imageView
            }
        }

        return nil
    }
}

class BDSwitch: UISwitch {
    var title: String?

    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
