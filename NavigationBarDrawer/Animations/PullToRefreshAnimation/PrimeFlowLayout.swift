//
//  PrimeFlowLayout.swift
//  NavigationBarDrawer
//
//  Created by 黄伯驹 on 2017/7/14.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

class PrimeFlowLayout: UICollectionViewFlowLayout {
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 800
        transform = CATransform3DRotate(transform, .pi / 2, -1, 0, 0)
        transform = CATransform3DScale(transform, 0.8, 0.8, 0.8)
        attributes?.transform3D = transform

        return attributes
    }
}
