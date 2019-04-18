//
//  CyclePageWaterfallCell.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/16.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CyclePageWaterfallCell: UICollectionViewCell {
    
    public var click_item:(() -> ())?
    public var created_image:((_ image:UIImage, _ width_height:CGFloat) -> ())?
    
    public var direction:UICollectionView.ScrollDirection = .vertical
    
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
            
            if direction == .horizontal {
                //横向滚动
                
                let temp_height = waterfallFlow_inset_top_bottom*CGFloat.init(2)+waterfallFlow_between_line*CGFloat.init(waterfallFlow_section_count-1)
                let image_height = (model.collection_width_height-temp_height)/CGFloat.init(waterfallFlow_section_count)
                
                image.image = UIImage.init(named: "")
                
                if let model_image = model.image {
                    
                    image.image = model_image
                    self.image.snp.updateConstraints({ (make) in
                        make.width.equalTo(model.photo_width_height)
                        make.height.equalTo(image_height)
                    })
                    
                } else {
                    
                    if model.photoName != "" {
                        
                        self.image.snp.updateConstraints({ (make) in
                            make.width.equalTo(0)
                            make.height.equalTo(image_height)
                        })
                        
                        DispatchQueue.global().async {
                            
                            let temp_image = UIImage.init(named: self.model.photoName) ?? UIImage.init()
                            
                            DispatchQueue.main.async {
                                
                                let image_width = image_height/temp_image.size.height*temp_image.size.width
                                self.created_image?(temp_image,image_width)
                            }
                        }
                    } else if model.photoUrl != nil {
                        
                        self.image.snp.updateConstraints({ (make) in
                            make.width.equalTo(20)
                            make.height.equalTo(image_height)
                        })
                        
                        loading.startAnimating()
                        
                        SDWebImageDownloader.shared().downloadImage(with: model.photoUrl, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil) { (url_image, data, error, success) in
                            
                            self.loading.stopAnimating()
                            self.image.image = url_image
                            
                            if let image:UIImage = url_image {
                                let image_width = image_height/image.size.height*image.size.width
                                self.created_image?(image,image_width)
                            }
                        }
                    }
                }
            } else {
                //纵向滚动
                
                let temp_width = waterfallFlow_inset_left_right*CGFloat.init(2)+waterfallFlow_between_line*CGFloat.init(waterfallFlow_section_count-1)
                let image_width = (model.collection_width_height-temp_width)/CGFloat.init(waterfallFlow_section_count)
                
                image.image = UIImage.init(named: "")
                
                if let model_image = model.image {
                    
                    image.image = model_image
                    self.image.snp.updateConstraints({ (make) in
                        make.width.equalTo(image_width)
                        make.height.equalTo(model.photo_width_height)
                    })
                    
                } else {
                    
                    if model.photoName != "" {
                        
                        self.image.snp.updateConstraints({ (make) in
                            make.width.equalTo(image_width)
                            make.height.equalTo(0)
                        })
                        
                        DispatchQueue.global().async {
                            
                            let temp_image = UIImage.init(named: self.model.photoName) ?? UIImage.init()
                            
                            DispatchQueue.main.async {
                                
                                let image_height = image_width/temp_image.size.width*temp_image.size.height
                                self.created_image?(temp_image,image_height)
                            }
                        }
                    } else if model.photoUrl != nil {
                        
                        self.image.snp.updateConstraints({ (make) in
                            make.width.equalTo(image_width)
                            make.height.equalTo(20)
                        })
                        
                        loading.startAnimating()
                        SDWebImageDownloader.shared().downloadImage(with: model.photoUrl, options: SDWebImageDownloaderOptions.useNSURLCache, progress: nil) { (url_image, data, error, success) in
                            
                            self.loading.stopAnimating()
                            self.image.image = url_image
                            
                            if let image:UIImage = UIImage.init(data: url_image!.sd_imageData()!) {
                                let image_height = image_width/image.size.width*image.size.height
                                self.created_image?(image,image_height)
                            }
                        }
                    }
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
        
        setup_UI()
        self.layer.masksToBounds = true
    }
    // MARK: - 约束
    private func setup_UI() {
        
        image.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.height.equalTo(0)
            make.width.equalTo(0)
            make.right.equalTo(self.snp.right).priority(600)
            make.bottom.equalTo(self.snp.bottom).priority(600)
        }
    }
}
