//
//  CyclePageController.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/4.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

let FlowLayout_CoverFlow_Identifier = "FlowLayout_CoverFlow_Identifier"

let coverFlow_left_inset = NSObject.frameMath_static(45)
let coverFlow_between_cycle = NSObject.frameMath_static(0)

class CyclePageController: NoneNaviBarController {
    
    public var data: PhotoViewerPhotoModel = PhotoViewerPhotoModel.init() {
        didSet {
            cycle_page.reloadData()
        }
    }
    
    // MARK: - 懒加载
    private lazy var coverFlow: CyclePageCoverFlow = {
        let coverFlow = CyclePageCoverFlow.init()
        coverFlow.scrollDirection = .horizontal
        coverFlow.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        coverFlow.minimumLineSpacing = 0
        coverFlow.minimumInteritemSpacing = 0
        return coverFlow
    }()
    
    private lazy var cycle_page: UICollectionView = {
        
        let cycle_page = UICollectionView.init(frame: CGRect.init(x: 0, y: 200, width: kScreenW, height: frameMath(150)), collectionViewLayout: coverFlow)
        cycle_page.backgroundColor = UIColor.clear
        cycle_page.showsVerticalScrollIndicator = false
        cycle_page.showsHorizontalScrollIndicator = false
        cycle_page.delegate = self
        cycle_page.dataSource = self
        cycle_page.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.1)  //类似分页的减速效果
        
        cycle_page.contentInset = UIEdgeInsets.init(top: 0, left: coverFlow_left_inset, bottom: 0, right: coverFlow_left_inset - coverFlow_between_cycle)
        coverFlow.itemSize = CGSize.init(width: cycle_page.frame.size.width - cycle_page.contentInset.left - (coverFlow_left_inset - coverFlow_between_cycle), height: cycle_page.bounds.size.height)
        cycle_page.register(CyclePageCollectionCell.self, forCellWithReuseIdentifier: FlowLayout_CoverFlow_Identifier)
        
        return cycle_page
    }()
    
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        view.addSubview(cycle_page)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
        if touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        } else if touch.view == cycle_page {
            clickCollectionView()
        }
    }
    func clickCollectionView() {
        print_debug("cycle_page")
    }
}

// MARK: - tableView 代理 数据源
extension CyclePageController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.photoData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowLayout_CoverFlow_Identifier, for: indexPath) as? CyclePageCollectionCell
        
        cell?.model = data.photoData[indexPath.item]
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickCollectionView()
    }
}
