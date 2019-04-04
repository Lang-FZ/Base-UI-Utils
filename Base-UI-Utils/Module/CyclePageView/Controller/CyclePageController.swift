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
    private lazy var coverFlow: CyclePageCoverFlow = {
        let coverFlow = CyclePageCoverFlow.init()
        coverFlow.scrollDirection = .horizontal
        coverFlow.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        coverFlow.minimumLineSpacing = 0
        coverFlow.minimumInteritemSpacing = 0
        coverFlow.estimatedItemSize = CGSize.init(width: kScreenW, height: frameMath(140))
        return coverFlow
    }()
    
    private lazy var cycle_page: UICollectionView = {
        
        let cycle_page = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: coverFlow)
        cycle_page.backgroundColor = UIColor.clear
        cycle_page.showsVerticalScrollIndicator = false
        cycle_page.showsHorizontalScrollIndicator = false
        cycle_page.delegate = self
        cycle_page.dataSource = self
        cycle_page.isPagingEnabled = true
        
//        cycle_page.register(CycleCyclePageItem.self, forCellWithReuseIdentifier: CycleCyclePageItem_Idenfitier)
        
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
