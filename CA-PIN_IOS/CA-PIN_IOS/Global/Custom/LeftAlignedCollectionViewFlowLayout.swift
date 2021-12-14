//
//  LeftAlignedCollectionViewFlowLayout.swift
//  CA-PIN_IOS
//
//  Created by hansol on 2021/12/14.
//

import UIKit

class LeftAlignCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 3

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 3
        self.sectionInset = .zero
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
