//
//  PhotoViewerPhotoModel.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/3/30.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

// MARK: -
@objcMembers
open class PhotoViewerPhotoModel: NSObject {
    
    /** 属性 */
    var photoData:[PhotoViewerPhotoModel] = []
    
    var photoName:String = ""
    var photoUrl:URL?
    
    override open init() {
        super.init()
    }
}
