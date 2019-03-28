//
//  Define.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/7.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

public extension NSObject {
    
    public var kScreen: CGRect { return UIScreen.main.bounds }
    public var kScreenW: CGFloat { return kScreen.size.width }
    public var kScreenH: CGFloat { return kScreen.size.height }
    
    public var kNaviBarH: CGFloat { return getNavigationBarHeight() }
    public var kStatusH: CGFloat { return getStatusHeight() }
    
    public var kTabBarH: CGFloat { return getTabBarHeight() }
    public var kTabBarBotH: CGFloat { return getTabBarBottomHeight() }
    
    public func frameMath(_ frame: CGFloat) -> CGFloat {
        return frame/375.0*UIScreen.main.bounds.width
    }
    
    // MARK: - NavigationBar
    public func getNavigationBarHeight() -> CGFloat {
        if isIphoneX() {
            return CGFloat.init(88)
        } else {
            return CGFloat.init(64)
        }
    }
    public func getStatusHeight() -> CGFloat {
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
    
    public static var kScreen_static: CGRect { return UIScreen.main.bounds }
    public static var kScreenW_static: CGFloat { return kScreen_static.size.width }
    public static var kScreenH_static: CGFloat { return kScreen_static.size.height }
    
    public static var kNaviBarH_static: CGFloat { return getNavigationBarHeight_static() }
    public static var kStatusH_static: CGFloat { return getStatusHeight_static() }
    
    public static var kTabBarH_static: CGFloat { return getTabBarHeight_static() }
    public static var kTabBarBotH_static: CGFloat { return getTabBarBottomHeight_static() }
    
    public static func frameMath_static(_ frame: CGFloat) -> CGFloat {
        return frame/375.0*UIScreen.main.bounds.width
    }
    
    // MARK: - NavigationBar
    public static func getNavigationBarHeight_static() -> CGFloat {
        if isIphoneX_static() {
            return CGFloat.init(88)
        } else {
            return CGFloat.init(64)
        }
    }
    public static func getStatusHeight_static() -> CGFloat {
        if isIphoneX_static() {
            return CGFloat.init(44)
        } else {
            return CGFloat.init(20)
        }
    }
    
    // MARK: - TabBar
    public static func getTabBarHeight_static() -> CGFloat {
        if isIphoneX_static() {
            return CGFloat.init(83)
        } else {
            return CGFloat.init(49)
        }
    }
    public static func getTabBarBottomHeight_static() -> CGFloat {
        if isIphoneX_static() {
            return CGFloat.init(34)
        } else {
            return 0
        }
    }
    
    // MARK: - 刘海屏
    public static func isIphoneX_static()->Bool {
        if UIApplication.shared.statusBarFrame.height == 44 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Debug模式下打印
    public static func print_debug_static(_ items: Any..., file:String = #file, funcName:String = #function, lineNum:Int = #line) {
        
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
}
