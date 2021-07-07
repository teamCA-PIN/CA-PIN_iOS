//
//  UITextField+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import Foundation
import UIKit

extension UITextField {
  func addLeftPadding(as offset: CGFloat? = 10) {
    let paddingView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: offset ?? 10,
                                           height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
  class func textFieldWithInsets(insets: UIEdgeInsets) -> UITextField {
    return fourInsetTextField(insets: insets)
  }
  func configureTextField(textColor: UIColor,
                          font: UIFont,
                          placeholder: String? = "") {
    self.autocorrectionType = .no
    self.autocapitalizationType = .none
    self.textColor = textColor
    self.font = font
    self.placeholder = placeholder ?? ""
  }
  
  func underlined(color: UIColor) {
    self.borderStyle = .none
    let border = CALayer()
    border.frame = CGRect(x: 0,
                          y: self.frame.height-1,
                          width: self.frame.width,
                          height: 1)
    border.backgroundColor = color.cgColor
    self.layer.addSublayer(border)
  }
}

class fourInsetTextField: UITextField {
  var insets: UIEdgeInsets
  
  init(insets: UIEdgeInsets) {
    self.insets = insets
    super.init(frame: .zero)
    self.autocorrectionType = .no
    self.autocapitalizationType = .none
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("not intended for use from a NIB")
  }
  
  /// placeholder position
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return super.textRect(forBounds: bounds.inset(by: insets))
  }
  
  /// text position
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return super.editingRect(forBounds: bounds.inset(by: insets))
  }
  
}
