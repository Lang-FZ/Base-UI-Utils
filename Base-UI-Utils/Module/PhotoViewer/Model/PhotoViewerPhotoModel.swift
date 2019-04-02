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
    public var photoData:[PhotoViewerPhotoModel] = []
    
    public var photoName:String = ""
    public var photoUrl:URL?
    
    override public init() {
        super.init()
    }
}
