//
//  Define.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

private let kScreen: CGRect = UIScreen.main.bounds
public let kScreenW: CGFloat = kScreen.size.width
public let kScreenH: CGFloat = kScreen.size.height

public let kNaviBarH: CGFloat = getNavigationBarHeight()
public let kStatusH: CGFloat = getStatusHeight()

public let kTabBarH: CGFloat = getTabBarHeight()
public let kTabBarBotH: CGFloat = getTabBarBottomHeight()

public func frameMath(_ frame: CGFloat) -> CGFloat {
    return frame/375.0*UIScreen.main.bounds.width
}

// MARK: - NavigationBar
private func getNavigationBarHeight() -> CGFloat {
    if isIphoneX() {
        return CGFloat.init(88)
    } else {
        return CGFloat.init(64)
    }
}
private func getStatusHeight() -> CGFloat {
    if isIphoneX() {
        return CGFloat.init(44)
    } else {
        return CGFloat.init(20)
    }
}

// MARK: - TabBar
public func getTabBarHeight() -> CGFloat {
    if isIphoneX() {
        return CGFloat.init(83)
    } else {
        return CGFloat.init(49)
    }
}
public func getTabBarBottomHeight() -> CGFloat {
    if isIphoneX() {
        return CGFloat.init(34)
    } else {
        return 0
    }
}

// MARK: - 刘海屏
public func isIphoneX()->Bool {
    if UIApplication.shared.statusBarFrame.height == 44 {
        return true
    } else {
        return false
    }
}

// MARK: - Debug模式下打印
public func print_debug(_ items: Any..., file:String = #file, funcName:String = #function, lineNum:Int = #line) {
    
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    
    var text = ""
    
    for item in items {
        text += "\n"
        text += "\(item)"
    }
    
    print("\nClass: \(fileName) === line: \(lineNum)\(text)")
    #endif
}
