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
        
        let photoModel = PhotoViewerPhotoModel.init()
        photoModel.testModel()
        
        let photoVC:PhotoViewerController = PhotoViewerController()
        photoVC.data = photoModel
        photoVC.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(photoVC, animated: true, completion: nil)
    }
}

