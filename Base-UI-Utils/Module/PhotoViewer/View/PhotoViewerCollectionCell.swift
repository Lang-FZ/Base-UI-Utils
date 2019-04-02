//
//  PhotoViewerCollectionCell.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/3/30.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - PhotoViewerCollectionCell

open class PhotoViewerCollectionCell: UICollectionViewCell {

    public var item_dismiss:(() -> ())?
    private var pan_start_point:CGPoint = CGPoint.zero
    private var image_scale_transfrom:CGAffineTransform = CGAffineTransform.identity
    
    // MARK: - setModel
    public var model: PhotoViewerPhotoModel = PhotoViewerPhotoModel() {
        didSet {
            
            image.transform = image_scale_transfrom
            image.image = UIImage.init(named: "")
            scroll.setZoomScale(1, animated: false)
            
            if model.photoName != "" {
                
                let temp_image = UIImage.init(named: model.photoName)
                image.image = temp_image
                let temp_size = self.calculate_image_size(temp_image?.size ?? CGSize.init(width: 1, height: 1))
                self.refresh_image_size(temp_size)
                
            } else if model.photoUrl != nil {
                
                loading.startAnimating()
                image.sd_setImage(with: model.photoUrl) { (url_image, error, cacheType, url) in
                    self.loading.stopAnimating()
                    
                    let temp_size = self.calculate_image_size(url_image?.size ?? CGSize.init(width: 1, height: 1))
                    self.refresh_image_size(temp_size)
                }
            }
        }
    }
    
    public var maxScale:CGFloat = 0 {
        didSet {
            scroll.maximumZoomScale = maxScale
        }
    }
    
    // MARK: - 属性
    //scroll
    public lazy var scroll: UIScrollView = {
        
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH))
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.delegate = self
        
        scroll.zoomScale = 1
        scroll.minimumZoomScale = 1
        scroll.maximumZoomScale = 2
        
        scroll.addSubview(image)
        
        return scroll
    }()
    //image
    private lazy var image: UIImageView = {
        
        let image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH))
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        return image
    }()
    //loading
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
        loading.hidesWhenStopped = true
        loading.center = CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2)
        return loading
    }()
    
    
    // MARK: - 初始化
    override public init(frame: CGRect) {
        super.init(frame: frame)
        scroll.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height)
        scroll.contentSize = CGSize.init(width: frame.width, height: frame.height)
        self.createPhotoViewerCollectionCell()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoViewerCollectionCell {
    
    private func createPhotoViewerCollectionCell() {
        
        backgroundColor = UIColor.init("000000", alpha: 0.5)
        
        addSubview(scroll)
        addSubview(loading)
    }
    
    private func calculate_image_size(_ size:CGSize) -> CGSize {
        
        if (size.width / size.height) > (scroll.frame.size.width / scroll.frame.size.height) {
            return CGSize.init(width: scroll.frame.size.width, height: scroll.frame.size.width/size.width*size.height)
        } else {
            return CGSize.init(width: scroll.frame.size.height*size.width/size.height, height: scroll.frame.size.height)
        }
    }
    private func refresh_image_size(_ size:CGSize) {
        
        self.scroll.zoomScale = 1
        self.image.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        self.image.center = CGPoint.init(x: self.scroll.frame.size.width/2, y: self.scroll.frame.size.height/2)
        self.scroll.contentSize = CGSize.init(width: self.image.frame.size.width, height: self.image.frame.size.height)
    }
    private func scaleFromPoint(_ imageRect:CGRect,_ gesPoint:CGPoint) -> CGPoint {
        
        var temp_point = gesPoint
        
        if gesPoint.x < imageRect.minX {
            temp_point.x = imageRect.minX
        } else if gesPoint.x > imageRect.maxX {
            temp_point.x = imageRect.maxX
        }
        
        if gesPoint.y < imageRect.minY {
            temp_point.y = imageRect.minY
        } else if gesPoint.y > imageRect.maxY {
            temp_point.y = imageRect.maxY
        }
        
        return temp_point
    }
    private func zoomRect(_ scalePoint:CGPoint) -> CGRect {
        return CGRect.init(x: scalePoint.x-(scroll.frame.width/scroll.maximumZoomScale/2), y: scalePoint.y-(scroll.frame.height/scroll.maximumZoomScale/2), width: scroll.frame.width/scroll.maximumZoomScale, height: scroll.frame.height/scroll.maximumZoomScale)
    }
    
    @objc public func doubleClickImage(_ temp_point:CGPoint) {

        guard image.image != nil else {
            return
        }
        
        let point = scaleFromPoint(image.frame, temp_point)
        
        if scroll.zoomScale == scroll.maximumZoomScale {
            scroll.setZoomScale(scroll.minimumZoomScale, animated: true)
        } else {
            
            let rect = zoomRect(point)
            self.scroll.zoom(to: rect, animated: true)
//
//            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
//
//                self.scroll.setZoomScale(self.scroll.maximumZoomScale, animated: true)
            
//                self.scroll.contentInset = UIEdgeInsets.init(top: rect.origin.y, left: rect.origin.x, bottom: self.scroll.frame.size.height - rect.maxY, right: self.scroll.frame.size.width - rect.maxX)
//
//            }) { (success) in
//
//            }
        }
    }
    @objc public func panMove(ges:UIPanGestureRecognizer, location:CGPoint) {
        
        let move = CGPoint.init(x: location.x-pan_start_point.x, y: location.y-pan_start_point.y)
        
        switch ges.state {
            
        case .began:
            pan_start_point = move
            image_scale_transfrom = image.transform
            break
            
        case .changed:
            if move.y <= 0 {
                backgroundColor = UIColor.init("000000", alpha: 0.5)
                image.transform = CGAffineTransform.init(a: scroll.zoomScale*cos(0), b: scroll.zoomScale*sin(0), c: scroll.zoomScale*(-sin(0)), d: scroll.zoomScale*cos(0), tx: move.x*cos(0)+move.y*(-sin(0)), ty: move.x*sin(0)+move.y*cos(0))
            } else {
                let scale = (1 - move.y / scroll.frame.size.height) * image_scale_transfrom.a
                backgroundColor = UIColor.init("000000", alpha: 0.5*scale)
                image.transform = CGAffineTransform.init(a: scale*cos(0), b: scale*sin(0), c: scale*(-sin(0)), d: scale*cos(0), tx: move.x*cos(0)+move.y*(-sin(0)), ty: move.x*sin(0)+move.y*cos(0))
            }
            
        case .ended, .cancelled, .failed:
            pan_start_point = CGPoint.zero
            if move.y > 50 {
                item_dismiss?()
            } else {
                image.transform = image_scale_transfrom
            }
            
        case .possible:
            print_debug("possible")
        }
    }
}

extension PhotoViewerCollectionCell:UIScrollViewDelegate {
    
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.image
    }
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//        print_debug("\(scrollView.contentSize)")
    }
}
