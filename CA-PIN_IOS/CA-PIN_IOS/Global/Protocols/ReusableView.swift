//
//  ReusableView.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

