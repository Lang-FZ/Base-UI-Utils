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

public class BaseViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
    }
    override public func viewWillAppear(_ animated: Bool) {
        if self.conforms(to: NoneTabBarProtocol.self) {
            self.hidesBottomBarWhenPushed = false
        }
    }
}

public class NoneNaviBarController: BaseViewController,NoneNavigationBarProtocol {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
}
