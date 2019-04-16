//
//  CyclePageController.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/4.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

private let CyclePage_Identifier = "CyclePage_Identifier"
private let CyclePage_waterfall_Identifier = "CyclePage_waterfall_Identifier"

class CyclePageController: NoneNaviBarController {
    
    private var cycle_style = CycleStyle.cover_flow     //显示类型
    private var isHadData:Bool = false      //已经赋值模型 可以触发 非初始化UI影响的 判断
    private var cycle_page_loop = false     //是否可循环
    
    public var is_page_loop = true          //外部控制可否循环
    public var current_page:Int = 0         //当前第几页
    public var before_after_add = 2         //可以循环时 前后各加几个
    
    private let collection_width = kScreenW_static
    
    public var item_size = CGSize.init(width: kScreenW_static - coverFlow_left_inset - (coverFlow_left_inset - coverFlow_between_cycle), height: frameMath_static(150))
    
    public var data: CyclePagePhotoModel = CyclePagePhotoModel.init() {
        didSet {
            
            if data.photoData.count > 2 && data.photoData.count >= before_after_add && is_page_loop {
                //大于2 前后各加2 可循环

                cycle_page_loop = true

                for index in 1...before_after_add {
                    data.photoData.insert(data.photoData[data.photoData.count-index], at: 0)
                }
                for index in 0..<before_after_add {
                    data.photoData.append(data.photoData[index+before_after_add])
                }
                
                isHadData = false
                cycle_page.reloadData()
                
                let item_width = (cycle_page.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.width ?? 0
                isHadData = true
                cycle_page.setContentOffset(CGPoint.init(x: item_width*CGFloat.init(before_after_add)-cycle_page.contentInset.left, y: 0), animated: false)

            } else {
                //不大于2 不可循环

                cycle_page_loop = false
                isHadData = true
                cycle_page.reloadData()
            }
        }
    }
    
    // MARK: - 懒加载
    // cover_flow
    private lazy var coverFlow: CyclePageCoverFlow = {
        let coverFlow = CyclePageCoverFlow.init()
        coverFlow.scrollDirection = .horizontal
        coverFlow.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        coverFlow.minimumLineSpacing = 0
        coverFlow.minimumInteritemSpacing = 0
        coverFlow.itemSize = CGSize.init(width: kScreenW, height: 1)
        return coverFlow
    }()
    // waterfall_flow
    private lazy var waterfallFlow: CyclePageWaterfallFlow = {
        let waterfallFlow = CyclePageWaterfallFlow.init()
        waterfallFlow.scrollDirection = .vertical
        waterfallFlow.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        waterfallFlow.minimumLineSpacing = waterfallFlow_between_line
        waterfallFlow.minimumInteritemSpacing = waterfallFlow_between_interitem
        waterfallFlow.itemSize = CGSize.init(width: kScreenW, height: 1)
        return waterfallFlow
    }()
    
    private lazy var cycle_page: UICollectionView = {
        
        var flow_layout:UICollectionViewDelegateFlowLayout?
        var cycle_page:UICollectionView?
        
        switch cycle_style {
        case .cover_flow:
            item_size = CGSize.init(width: kScreenW - coverFlow_left_inset - (coverFlow_left_inset - coverFlow_between_cycle), height: frameMath(150))
            coverFlow.itemSize = item_size
            flow_layout = coverFlow
            
            cycle_page = UICollectionView.init(frame: CGRect.init(x: 0, y: 200, width: collection_width, height: frameMath(150)), collectionViewLayout: flow_layout as! UICollectionViewLayout)
            cycle_page?.register(CyclePageCollectionCell.self, forCellWithReuseIdentifier: CyclePage_Identifier)
            
        case .waterfall_flow:
            waterfallFlow.estimatedItemSize = CGSize.init(width: (collection_width-waterfallFlow_inset_left_right*2-waterfallFlow_between_line*(waterfallFlow_section_count-1))/waterfallFlow_section_count, height: CGFloat.leastNormalMagnitude)
            flow_layout = waterfallFlow
            
            cycle_page = UICollectionView.init(frame: CGRect.init(x: 0, y: 44, width: collection_width, height: kScreenH-44-39), collectionViewLayout: flow_layout as! UICollectionViewLayout)
            cycle_page?.register(CyclePageWaterfallCell.self, forCellWithReuseIdentifier: CyclePage_waterfall_Identifier)
        }
        
        cycle_page?.backgroundColor = UIColor.clear
        cycle_page?.showsVerticalScrollIndicator = false
        cycle_page?.showsHorizontalScrollIndicator = false
        cycle_page?.delegate = self
        cycle_page?.dataSource = self
        cycle_page?.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.1)  //类似分页的减速效果
        
        cycle_page?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dismissController)))
        
        switch cycle_style {
        case .cover_flow:
            cycle_page?.contentInset = UIEdgeInsets.init(top: 0, left: coverFlow_left_inset, bottom: 0, right: coverFlow_left_inset - coverFlow_between_cycle)
        case .waterfall_flow:
            cycle_page?.contentInset = UIEdgeInsets.init(top: waterfallFlow_inset_top_bottom, left: waterfallFlow_inset_left_right, bottom: waterfallFlow_inset_top_bottom, right: waterfallFlow_inset_left_right)
        }
        
        
        return cycle_page ?? UICollectionView.init()
    }()
    
    init(_ style:CycleStyle) {
        super.init()
        cycle_style = style
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 系统方法
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        view.addSubview(cycle_page)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = (((touches as NSSet).anyObject() as AnyObject) as! UITouch)
        
        if touch.view == self.view {
            dismissController()
        } else if touch.view == cycle_page {
//            clickCollectionView(current_page)
            dismissController()
        }
    }
    @objc private func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    private func clickCollectionView(_ index:Int) {
        print_debug("page : \(index)")
    }
}

// MARK: - tableView 代理 数据源
extension CyclePageController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.photoData.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cycle_style {
        case .cover_flow:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CyclePage_Identifier, for: indexPath) as? CyclePageCollectionCell
            cell?.model = data.photoData[indexPath.item]
            
            return cell!
            
        case .waterfall_flow:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CyclePage_waterfall_Identifier, for: indexPath) as? CyclePageWaterfallCell
            
            let model = data.photoData[indexPath.item]
            model.collection_width = collection_width
            cell?.model = model
            
            cell?.click_item = { [weak self] in
                self?.clickCollectionView(indexPath.item)
            }
            
            return cell!
        }
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if cycle_page_loop {
            if indexPath.item < before_after_add {
                //左侧添加的
                clickCollectionView(indexPath.item+(data.photoData.count-before_after_add*2)-before_after_add)
            } else if indexPath.item >= data.photoData.count+before_after_add {
                //右侧添加的
                clickCollectionView(indexPath.item-(data.photoData.count-before_after_add))
            } else {
                //中间的item
                clickCollectionView(indexPath.item-before_after_add)
            }
        } else {
            clickCollectionView(indexPath.item)
        }
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isHadData {
            
            let item_width = ((scrollView as? UICollectionView)?.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.width ?? 0
            let real_offset_x = scrollView.contentOffset.x + scrollView.contentInset.left
            var current_index = 0
            
            if cycle_page_loop {
                
                if real_offset_x >= item_width*CGFloat.init(data.photoData.count-before_after_add) {
                    //大于 图片数组的最后一张 也就是加了四张图片之后的倒数第三张    (当前后各加2时)
                    cycle_page.setContentOffset(CGPoint.init(x: item_width*CGFloat.init(before_after_add)-cycle_page.contentInset.left, y: 0), animated: false)
                    
                } else if real_offset_x <= item_width*CGFloat.init(before_after_add-1) && real_offset_x != 0 {
                    //小于 图片最后一张 也就是加了四张图片之后的第二张     (当前后各加2时)
                    cycle_page.setContentOffset(CGPoint.init(x: item_width*CGFloat.init(data.photoData.count-before_after_add*2+before_after_add-1)-cycle_page.contentInset.left, y: 0), animated: false)
                }
                
                let temp_int_index = Int.init(real_offset_x/item_width)
                let temp_half_index = real_offset_x-CGFloat.init(temp_int_index)*item_width
                
                if real_offset_x < (item_width*CGFloat.init(before_after_add) - item_width/2) {
                    //显示 图片0 左侧
                    current_index = temp_int_index+(data.photoData.count-before_after_add*3) + Int.init(temp_half_index / (item_width/2))
                    
                } else if real_offset_x >= (item_width*CGFloat.init(data.photoData.count-before_after_add-1) + item_width/2) {
                    //显示 最后一张 右侧
                    current_index = temp_int_index-(data.photoData.count-before_after_add) + Int.init(temp_half_index / (item_width/2))
                    
                } else {
                    //中间真实显示图片数组的部分 0时 0+0 or -1+1
                    current_index = temp_int_index-before_after_add + Int.init(temp_half_index / (item_width/2))
                }
            } else {
                
                if real_offset_x < item_width/2 {
                    current_index = 0
                } else if real_offset_x > item_width*CGFloat.init(data.photoData.count-1) {
                    current_index = data.photoData.count-1
                } else {
                    let temp_int_index = Int.init(real_offset_x/item_width)
                    let temp_half_index = real_offset_x-CGFloat.init(temp_int_index)*item_width
                    current_index = temp_int_index + Int.init(temp_half_index / (item_width/2))
                }
            }
            
            current_page_index(current_index)
        }
    }
    
    /// 当前是第几页
    ///
    /// - Parameter index: 页码
    private func current_page_index(_ index:Int) {
        
        if index != current_page {
            current_page = index
            print_debug("current_index \(index)")
        }
    }
}

public enum CycleStyle {
    case cover_flow
    case waterfall_flow
}
