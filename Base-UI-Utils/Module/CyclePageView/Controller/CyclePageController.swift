//
//  CyclePageController.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/4.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class CyclePageController: NoneNaviBarController {
    
    // MARK: - 懒加载
    private lazy var cycle_page: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.estimatedItemSize = CGSize.init(width: kScreenW, height: frameMath(140))
        
        let cycle_page = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        cycle_page.backgroundColor = UIColor.clear
        cycle_page.showsVerticalScrollIndicator = false
        cycle_page.showsHorizontalScrollIndicator = false
        cycle_page.delegate = self
        cycle_page.dataSource = self
        cycle_page.isPagingEnabled = true
        
//        cycle_page.register(CarnivalActivitiesCell_Item.self, forCellWithReuseIdentifier: Carnival_Activities_Idenfitier)
        
        return cycle_page
    }()
    
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        UICollectionViewFlowLayout.init()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - tableView 代理 数据源
extension CyclePageController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
}
