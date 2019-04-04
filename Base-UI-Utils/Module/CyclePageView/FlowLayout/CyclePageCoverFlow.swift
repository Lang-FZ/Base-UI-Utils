//
//  CyclePageCoverFlow.swift
//  Base-UI-Utils
//
//  Created by LangFZ on 2019/4/4.
//  Copyright © 2019 LangFZ. All rights reserved.
//

import UIKit

class CyclePageCoverFlow: UICollectionViewFlowLayout {
    //https://blog.csdn.net/u013410274/article/details/79925531
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CyclePageCoverFlow:UICollectionViewDelegateFlowLayout {
    
    /// 作用：在这个方法中做一些初始化操作
    /// 注意：子类重写prepareLayout，一定要调用[super prepareLayout]
    override func prepare() {
        super.prepare()
        
        self.scrollDirection = UICollectionView.ScrollDirection.horizontal
        // 决定第一张图片所在的位置
        self.collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: (collectionView?.frame.width ?? 0)*(1-0.627)/2, bottom: 0, right: (collectionView?.frame.width ?? 0)*(1-0.627)/2)
    }
    /// 作用：决定cell的排布方式（frame等）
    ///
    /// - Parameter rect:
    /// - Returns:  这个方法的返回值是个数组
    ///             这个数组中存放的都是UICollectionViewLayoutAttributes对象
    ///             UICollectionViewLayoutAttributes对象决定了cell的排布方式（frame等）
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var temp_rect = rect
        
        // 闪屏现象解决参考 ：https://blog.csdn.net/u013282507/article/details/53103816
        // 扩大控制范围，防止出现闪屏现象
        temp_rect.size.width = temp_rect.size.width + (collectionView?.frame.width ?? 0)
        temp_rect.origin.x = temp_rect.origin.x - (collectionView?.frame.width ?? 0 ) / 2
        
        // 让父类布局好样式
        let layout_arr:[UICollectionViewLayoutAttributes] = NSArray.init(array: NSArray.init(array: super.layoutAttributesForElements(in: rect) ?? []) as? [Any] ?? [], copyItems: true) as? [UICollectionViewLayoutAttributes] ?? []
        
        for attributes in layout_arr {
            
            let center_x = collectionView?.center.x ?? 0
            let step = abs(center_x - (attributes.center.x - (collectionView?.contentOffset.x ?? 0)))
            print("step \(step) : attX \(attributes.center.x) - offset \(collectionView?.contentOffset.x ?? 0)")
            let scale = fabsf(cosf(Float(step / center_x * CGFloat.init(Double.pi/5))))
            
            attributes.transform = CGAffineTransform.init(scaleX: CGFloat(scale), y: CGFloat(scale))
        }
        
        return layout_arr
    }
    /// 作用：如果返回YES，那么collectionView显示的范围发生改变时，就会重新刷新布局
    ///
    /// - Parameter newBounds:
    /// - Returns:  如果返回YES，那么collectionView显示的范围发生改变时，就会重新刷新布局
    ///             一旦重新刷新布局，就会按顺序调用下面的方法：
    ///                 prepare
    ///                 layoutAttributesForElementsInRect:
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    /// 作用：返回值决定了collectionView停止滚动时最终的偏移量（contentOffset）
    ///
    /// - Parameters:
    ///   - proposedContentOffset: 原本情况下，collectionView停止滚动时最终的偏移量
    ///   - velocity: 滚动速率，通过这个参数可以了解滚动的方向
    /// - Returns: 停止滚动时最终的偏移量
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        // 保证滚动结束后视图的显示效果
        
        // 计算出最终显示的矩形框
        let rect = CGRect.init(x: proposedContentOffset.x, y: 0, width: collectionView?.frame.width ?? 0, height: collectionView?.frame.height ?? 0)
        
        // 获得 super 已经计算好的布局的属性
        let attributes_arr = super.layoutAttributesForElements(in: rect) ?? []
        
        let center_x = proposedContentOffset.x + (collectionView?.frame.width ?? 0) * 0.5
        var min_delta = CGFloat.greatestFiniteMagnitude
        
        for attributes in attributes_arr {
            if abs(min_delta) > abs(attributes.center.x - center_x) {
                min_delta = attributes.center.x - center_x
            }
        }
        
        return CGPoint.init(x: proposedContentOffset.x + min_delta, y: proposedContentOffset.y)
    }
}

