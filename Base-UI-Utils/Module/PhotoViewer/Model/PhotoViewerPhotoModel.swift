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
class PhotoViewerPhotoModel: NSObject {
    
    /** 属性 */
    var photoData:[PhotoViewerPhotoModel] = []
    
    var photoName:String = ""
    var photoUrl:URL?
    
    override init() {
        super.init()
    }
    
    public func testModel() {
        
        let url1 = PhotoViewerPhotoModel()
        url1.photoUrl = URL.init(string: "http://img.netbian.com/file/2019/0312/e70d8c660d7321b25096cb7247f9a11a.jpg")
        photoData.append(url1)
        
        let model2 = PhotoViewerPhotoModel()
        model2.photoName = "bizhi2.jpg"
        photoData.append(model2)
        
        let model6 = PhotoViewerPhotoModel()
        model6.photoName = "bizhi6.jpg"
        photoData.append(model6)
        
        let model10 = PhotoViewerPhotoModel()
        model10.photoName = "bizhi10.jpg"
        photoData.append(model10)
    }
}
