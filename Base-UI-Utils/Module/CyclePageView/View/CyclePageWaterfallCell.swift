//
//  CyclePageWaterfallCell.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/16.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import SnapKit

class CyclePageWaterfallCell: UICollectionViewCell {
    
    var click_item:(() -> ())?
    
    private lazy var image: UIImageView = {
        let image = UIImageView.init()
        return image
    }()
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
        loading.hidesWhenStopped = true
        loading.center = CGPoint.init(x: self.image.frame.size.width/2, y: self.image.frame.size.height/2)
        return loading
    }()
    
    // MARK: - setModel
    var model: CyclePagePhotoModel = CyclePagePhotoModel.init() {
        didSet {
            
            let temp_width = waterfallFlow_inset_left_right*CGFloat.init(2)+waterfallFlow_between_line*CGFloat.init(waterfallFlow_section_count-1)
            let image_width = (model.collection_width-temp_width)/CGFloat.init(waterfallFlow_section_count)

            image.image = UIImage.init(named: "")
            
            if model.photoName != "" {
                
                self.image.snp.updateConstraints({ (make) in
                    make.width.equalTo(image_width)
                    make.height.equalTo(0)
                })
                
                DispatchQueue.global().async {
                    let temp_image = UIImage.init(named: self.model.photoName)
                    DispatchQueue.main.async {
                        self.image.image = temp_image
                        self.image.snp.updateConstraints({ (make) in
                            make.width.equalTo(image_width)
                            make.height.equalTo(image_width/(temp_image?.size.width ?? 0)*(temp_image?.size.height ?? 0))
                        })
                        self.setNeedsLayout()
                        self.layoutIfNeeded()
                    }
                }
            } else if model.photoUrl != nil {
                
                self.image.snp.updateConstraints({ (make) in
                    make.width.equalTo(image_width)
                    make.height.equalTo(20)
                })
                
                loading.startAnimating()
                image.sd_setImage(with: model.photoUrl) { (url_image, error, cacheType, url) in
                    self.loading.stopAnimating()
                    self.image.snp.updateConstraints({ (make) in
                        make.width.equalTo(image_width)
                        make.height.equalTo(image_width/(url_image?.size.width ?? 0)*(url_image?.size.height ?? 0))
                    })
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createCyclePageWaterfallCell()
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickItemGes)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func clickItemGes() {
        click_item?()
    }
}

extension CyclePageWaterfallCell {
    
    private func createCyclePageWaterfallCell() {
        backgroundColor = UIColor.clear
        
        addSubview(image)
        addSubview(loading)
        
        backgroundColor = UIColor.init(red: CGFloat(Double.init(arc4random_uniform(255))/255.0), green: CGFloat(Double.init(arc4random_uniform(255))/255.0), blue: CGFloat(Double.init(arc4random_uniform(255))/255.0), alpha: 1)
        
        setup_UI()
        self.layer.masksToBounds = true
    }
    // MARK: - 约束
    private func setup_UI() {
        
        image.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.height.equalTo(0)
            make.width.equalTo(kScreenW)
            make.right.equalTo(self.snp.right).priority(600)
            make.bottom.equalTo(self.snp.bottom).priority(600)
        }
    }
}
