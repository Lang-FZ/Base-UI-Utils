//
//  CyclePagePhotoModel.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/12.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

// MARK: -
@objcMembers
open class CyclePagePhotoModel: NSObject {
    
    /** 属性 */
    public var photoData:[CyclePagePhotoModel] = []
    
    public var photoName:String = ""
    public var photoUrl:URL?
    
    override public init() {
        super.init()
    }
}
