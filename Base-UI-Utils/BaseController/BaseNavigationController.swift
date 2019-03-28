//
//  BaseNavigationController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/5.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

open class BaseNavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    override open var shouldAutorotate : Bool {
        return true
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {

    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if let viewController = self.viewControllers.last {
            // MARK: - 不需要侧滑返回的类
            let iskind = viewController.conforms(to: NoneInteractivePopGestureProtocol.self)
            if iskind { return false }
        }
        return self.viewControllers.count > 1 ? true : false
    }
    
    open func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        var isHidden = false
        // MARK: - 不需要导航条的类
        let isvc = viewController.conforms(to: NoneNavigationBarProtocol.self)
        if isvc {
            isHidden = true
            navigationController.setNavigationBarHidden(true, animated: animated)
        } else {
            navigationController.setNavigationBarHidden(isHidden, animated: animated)
        }
    }
}

