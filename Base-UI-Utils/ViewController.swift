//
//  ViewController.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/3/27.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
//        testPhotoViewer()
        testCyclePage()
    }
    
    private func testCyclePage() {
        
        let photoModel = CyclePagePhotoModel.init()
        
        let url1 = CyclePagePhotoModel()
        url1.photoUrl = URL.init(string: "http://img.netbian.com/file/2019/0312/e70d8c660d7321b25096cb7247f9a11a.jpg")
        
        let model2 = CyclePagePhotoModel()
//        model2.photoName = "bizhi1.jpg"
        model2.photoName = "bizhi8.jpg"
        
        let model3 = CyclePagePhotoModel()
//        model3.photoName = "bizhi3.jpg"
        model3.photoName = "bizhi5.jpg"
        
        let model4 = CyclePagePhotoModel()
//        model4.photoName = "bizhi4.jpg"
        model4.photoName = "bizhi10.jpg"
        
        let model5 = CyclePagePhotoModel()
        model5.photoName = "bizhi4.jpg"

        photoModel.photoData.append(url1)
        photoModel.photoData.append(model2)
        photoModel.photoData.append(model3)
        photoModel.photoData.append(model4)
        photoModel.photoData.append(model5)
        photoModel.photoData.append(url1)
        photoModel.photoData.append(model2)
        photoModel.photoData.append(model3)
        photoModel.photoData.append(model4)
        photoModel.photoData.append(model5)
        photoModel.photoData.append(url1)
        photoModel.photoData.append(model2)
        photoModel.photoData.append(model3)
        photoModel.photoData.append(model4)
        photoModel.photoData.append(model5)
        photoModel.photoData.append(url1)
        photoModel.photoData.append(model2)
        photoModel.photoData.append(model3)
        photoModel.photoData.append(model4)
        photoModel.photoData.append(model5)
        
        let photoVC:CyclePageController = CyclePageController.init(CycleStyle.waterfall_flow)
        photoVC.is_page_loop = false
        photoVC.data = photoModel
        photoVC.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(photoVC, animated: true, completion: nil)
    }
    private func testPhotoViewer() {
        
        let photoModel = PhotoViewerPhotoModel.init()
        
        let url1 = PhotoViewerPhotoModel()
        url1.photoUrl = URL.init(string: "http://img.netbian.com/file/2019/0312/e70d8c660d7321b25096cb7247f9a11a.jpg")
        photoModel.photoData.append(url1)
        
        let model2 = PhotoViewerPhotoModel()
        model2.photoName = "bizhi2.jpg"
        photoModel.photoData.append(model2)
        
        let model6 = PhotoViewerPhotoModel()
        model6.photoName = "bizhi6.jpg"
        photoModel.photoData.append(model6)
        
        let model10 = PhotoViewerPhotoModel()
        model10.photoName = "bizhi10.jpg"
        photoModel.photoData.append(model10)
        
        let photoVC:PhotoViewerController = PhotoViewerController()
        photoVC.data = photoModel
        photoVC.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(photoVC, animated: true, completion: nil)
    }
}

