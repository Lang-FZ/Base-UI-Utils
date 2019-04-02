//
//  PhotoViewerController.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/3/30.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

fileprivate let photoCellIdentifier = "photoCellIdentifier"

open class PhotoViewerController: NoneNaviBarController {

    // MARK: - setModel
    public var data: PhotoViewerPhotoModel = PhotoViewerPhotoModel.init() {
        didSet {
            photoCollection.reloadData()
        }
    }
    
    private lazy var photoCollection: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize.init(width: kScreenW, height: kScreenH)
        
        let photoCollection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH), collectionViewLayout: flowLayout)
        photoCollection.backgroundColor = UIColor.clear
        photoCollection.showsVerticalScrollIndicator = false
        photoCollection.showsHorizontalScrollIndicator = false
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.isPagingEnabled = true
        
        photoCollection.register(PhotoViewerCollectionCell.self, forCellWithReuseIdentifier: photoCellIdentifier)
        
        return photoCollection
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear

        view.addSubview(photoCollection)
        createGes()
        
        photoCollection.reloadData()
    }
}

extension PhotoViewerController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.photoData.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as? PhotoViewerCollectionCell
        
        cell?.model = data.photoData[indexPath.item]
        
        cell?.item_dismiss = { [weak self] in
            self?.dismissAnimation()
        }
        
        return cell!
    }
}

// MARK: - 手势 单击、双击、拖拽、长按
extension PhotoViewerController {
    
    private func createGes() {
        
        let single:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(singleClickGes(ges:)))
        self.view.addGestureRecognizer(single)
        
        let double:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(doubleClickGes(ges:)))
        double.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(double)
        
        single.require(toFail: double)
        
        let pan:UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panDragDropGes(ges:)))
        self.view.addGestureRecognizer(pan)
        
        let long:UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGes(ges:)))
        self.view.addGestureRecognizer(long)
    }
    
    @objc private func singleClickGes(ges:UITapGestureRecognizer) {
        dismissAnimation()
    }
    @objc private func doubleClickGes(ges:UITapGestureRecognizer) {
        let cell = photoCollection.visibleCells.last as? PhotoViewerCollectionCell
        cell?.doubleClickImage(ges.location(in: cell?.scroll))
    }
    @objc private func panDragDropGes(ges:UIPanGestureRecognizer) {
        let cell = photoCollection.visibleCells.last as? PhotoViewerCollectionCell
        cell?.panMove(ges: ges, location: ges.location(in: cell?.scroll))
    }
    @objc private func longPressGes(ges:UILongPressGestureRecognizer) {
        print("long")
    }
    
    private func dismissAnimation() {
        self.dismiss(animated: true, completion: nil)
    }
}

