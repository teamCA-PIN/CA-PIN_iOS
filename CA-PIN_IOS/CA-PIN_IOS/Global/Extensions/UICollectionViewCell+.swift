//
//  UICollectionViewCell+.swift
//  CA-PIN_IOS
//
//  Created by λΈνμ on 2021/06/28.
//


import UIKit

extension UICollectionViewCell: ReusableView {
  
    func getCollectionCellIndexPath() -> Int {
      var indexPath = 0
      
      guard let superView = self.superview as? UICollectionView else {
        return -1
      }
      indexPath = superView.indexPath(for: self)!.row
      
      return indexPath
    }
}
