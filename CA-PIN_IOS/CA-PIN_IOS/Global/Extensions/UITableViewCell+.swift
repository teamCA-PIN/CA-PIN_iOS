//
//  UITableViewCell++.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//


import UIKit

extension UITableViewCell: ReusableView {
  func getTableCellIndexPath() -> Int {
      var indexPath = 0
      
      guard let superView = self.superview as? UITableView else {
          return -1
      }
      indexPath = superView.indexPath(for: self)!.row

      return indexPath
  }

}
