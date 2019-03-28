//
//  BaseViewController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/5.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

@objc public protocol NoneInteractivePopGestureProtocol {}
@objc public protocol NoneNavigationBarProtocol {}
@objc public protocol NoneTabBarProtocol {}

open class BaseViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
    }
    override open func viewWillAppear(_ animated: Bool) {
        if self.conforms(to: NoneTabBarProtocol.self) {
            self.hidesBottomBarWhenPushed = false
        }
    }
}

open class NoneNaviBarController: BaseViewController,NoneNavigationBarProtocol {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}
