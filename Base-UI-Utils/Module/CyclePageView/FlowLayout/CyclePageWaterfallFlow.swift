//
//  CyclePageWaterfallFlow.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/15.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

public let waterfallFlow_section_count = 3                                  //一共几列
public let waterfallFlow_between_line = NSObject.frameMath_static(5)        //最小行间距
public let waterfallFlow_between_interitem = NSObject.frameMath_static(5)   //同一列中间隔的cell最小间距
public let waterfallFlow_inset_left_right = NSObject.frameMath_static(10)   //inset 左右
public let waterfallFlow_inset_top_bottom = NSObject.frameMath_static(5)    //inset 上下

class CyclePageWaterfallFlow: UICollectionViewFlowLayout {
    
    lazy private var column_width:CGFloat = {
        let temp_column_all_width = (self.collectionView?.frame.size.width ?? 0) - waterfallFlow_inset_left_right*2
        let column_all_width = temp_column_all_width - waterfallFlow_between_line*CGFloat.init(waterfallFlow_section_count-1)
        let column_width = column_all_width/CGFloat.init(waterfallFlow_section_count)
        return column_width
    } ()
    
    lazy private var column_heights:[CGFloat] = {
        var column_heights:[CGFloat] = []
        for i in 0..<waterfallFlow_section_count {
            column_heights.append(0)
        }
        return column_heights
    } ()
    
    override public init() {
        super.init()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CyclePageWaterfallFlow:UICollectionViewDelegateFlowLayout {
    
    /// 作用：在这个方法中做一些初始化操作
    /// 注意：子类重写prepareLayout，一定要调用[super prepareLayout]
    override open func prepare() {
        super.prepare()
        column_heights = []
        for _ in 0..<waterfallFlow_section_count {
            column_heights.append(0)
        }
    }
    
    /// 返回indexPath位置cell对应的布局属性
    ///
    /// - Parameter indexPath: 位置
    /// - Returns: 返回indexPath位置cell对应的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let layout_arr:UICollectionViewLayoutAttributes? = super.layoutAttributesForItem(at: indexPath)
        let shortest = column_heights.sorted(by: <).first ?? 0
        let shortCol = NSArray.init(array: column_heights).index(of: shortest)
        
        let x = CGFloat.init(shortCol)*column_width+waterfallFlow_inset_left_right+waterfallFlow_between_line*CGFloat.init(shortCol)
        let y = shortest + waterfallFlow_inset_top_bottom
        
        //获取cell高度
        let height = 50+arc4random_uniform(50)
        
        layout_arr?.frame = CGRect.init(x: x, y: y, width: column_width, height: CGFloat(height))
        column_heights[shortCol] = y + CGFloat(height)
        
        return layout_arr
    }
    
    /// 作用：决定cell的排布方式（frame等）
    ///
    /// - Parameter rect:
    /// - Returns:  这个方法的返回值是个数组
    ///             这个数组中存放的都是UICollectionViewLayoutAttributes对象
    ///             UICollectionViewLayoutAttributes对象决定了cell的排布方式（frame等）
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var temp_arr:[UICollectionViewLayoutAttributes] = []
        let items = collectionView?.numberOfItems(inSection: 0) ?? 0

        for i in 0..<items {

            let att = self.layoutAttributesForItem(at: IndexPath.init(row: i, section: 0)) ?? UICollectionViewLayoutAttributes.init()
            temp_arr.append(att)
        }

        return temp_arr
    }
    
    override var collectionViewContentSize: CGSize {
        let longest = self.column_heights.sorted(by: <).first ?? 0
        return CGSize.init(width: (collectionView?.frame.size.width ?? 0), height: longest)
    }
    
    /// 作用：如果返回YES，那么collectionView显示的范围发生改变时，就会重新刷新布局
    ///
    /// - Parameter newBounds:
    /// - Returns:  如果返回YES，那么collectionView显示的范围发生改变时，就会重新刷新布局
    ///             一旦重新刷新布局，就会按顺序调用下面的方法：
    ///                 prepare
    ///                 layoutAttributesForElementsInRect:
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
