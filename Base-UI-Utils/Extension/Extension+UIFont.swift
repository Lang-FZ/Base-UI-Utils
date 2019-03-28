//
//  Extension+UIFont.swift
//  OnceNaive_Swift
//
//  Created by LangFZ on 2019/3/8.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

/*
 PingFangSC-Medium
 PingFangSC-Semibold
 PingFangSC-Regular
 PingFangSC-Light
 PingFangSC-Ultralight
 PingFangSC-Thin
 
 HelveticaNeue
 HelveticaNeue-UltraLightItalic
 HelveticaNeue-Medium
 HelveticaNeue-MediumItalic
 HelveticaNeue-UltraLight
 HelveticaNeue-Italic
 HelveticaNeue-Light
 HelveticaNeue-ThinItalic
 HelveticaNeue-LightItalic
 HelveticaNeue-Bold
 HelveticaNeue-Thin
 HelveticaNeue-CondensedBlack
 HelveticaNeue-CondensedBold
 HelveticaNeue-BoldItalic
 */

public enum FontName:String {
    
    case PFSC_Medium        = "PingFangSC-Medium"
    case PFSC_Semibold      = "PingFangSC-Semibold"
    case PFSC_Regular       = "PingFangSC-Regular"
    case PFSC_Light         = "PingFangSC-Light"
    case PFSC_Ultralight    = "PingFangSC-Ultralight"
    case PFSC_Thin          = "PingFangSC-Thin"
    
    case HT_Neue            = "Helvetica Neue"
    case HT_Italic          = "HelveticaNeue-Italic"
    case HT_Medium          = "HelveticaNeue-Medium"
    case HT_MediumItalic    = "HelveticaNeue-MediumItalic"
    case HT_Bold            = "HelveticaNeue-Bold"
    case HT_BoldItalic      = "HelveticaNeue-BoldItalic"
    case HT_CondensedBlack  = "HelveticaNeue-CondensedBlack"
    case HT_CondensedBold   = "HelveticaNeue-CondensedBold"
    case HT_UltraLight      = "HelveticaNeue-UltraLight"
    case HT_UltraLightItalic    = "HelveticaNeue-UltraLightItalic"
    case HT_Light           = "HelveticaNeue-Light"
    case HT_LightItalic     = "HelveticaNeue-LightItalic"
    case HT_Thin            = "HelveticaNeue-Thin"
    case HT_ThinItalic      = "HelveticaNeue-ThinItalic"

    case OpenSansSemibold = "OpenSans-Semibold"
}

public extension UIFont {
    
    public class func custom(_ customFontName:FontName, size:CGFloat) -> UIFont {
        
        if let font:UIFont = UIFont.init(name: customFontName.rawValue, size: frameMath_static(size)) {
            return font
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}
