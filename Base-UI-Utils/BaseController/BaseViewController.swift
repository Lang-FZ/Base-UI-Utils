//
//  BaseViewController.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/5.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

@objc protocol NoneInteractivePopGestureProtocol {}
@objc protocol NoneNavigationBarProtocol {}
@objc protocol NoneTabBarProtocol {}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.conforms(to: NoneTabBarProtocol.self) {
            self.hidesBottomBarWhenPushed = false
        }
    }
}

class NoneNaviBarController: BaseViewController,NoneNavigationBarProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
