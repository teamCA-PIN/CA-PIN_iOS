//
//  UITableView+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//


import UIKit

extension UITableView {
  func dequeueCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                         for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    
    return cell
  }
  
  
}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
