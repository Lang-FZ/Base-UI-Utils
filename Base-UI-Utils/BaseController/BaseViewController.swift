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
@objc public protocol HadTabBarProtocol {}

open class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
    }
    override open func viewWillAppear(_ animated: Bool) {
        if self.conforms(to: HadTabBarProtocol.self) {
            self.hidesBottomBarWhenPushed = false
        }
    }
}

open class NoneNaviBarController: BaseViewController,NoneNavigationBarProtocol {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}
