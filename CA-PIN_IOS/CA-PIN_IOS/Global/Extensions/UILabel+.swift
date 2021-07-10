//
//  UILabel+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import Foundation
import UIKit

extension UILabel {
  
  func setupLabel(text: String,
                  color: UIColor,
                  font: UIFont,
                  align: NSTextAlignment? = .left) {
    self.font = font
    self.text = text
    self.textColor = color
    self.textAlignment = align ?? .left
  }
  
  func halfTextColorChange (fullText: String , changeText: String, color: UIColor) {
    let strNumber: NSString = fullText as NSString
    let range = (strNumber).range(of: changeText)
    let attribute = NSMutableAttributedString.init(string: fullText)
    attribute.addAttribute(NSAttributedString.Key.foregroundColor,
                           value: color,
                           range: range)
    self.attributedText = attribute
  }
  
  /// 자간 조정
  var letterSpacing: CGFloat {
      set {
          let attributedString: NSMutableAttributedString
          if let currentAttrString = attributedText {
              attributedString = NSMutableAttributedString(attributedString: currentAttrString)
          }
          else {
              attributedString = NSMutableAttributedString(string: self.text ?? "")
              self.attributedText = attributedString
          }
          
          attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
          self.attributedText = attributedString
      }
      get {
          if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
              return currentLetterSpace
          }
          else {
              return 0
          }
      }
  }
  
  /// 행간 조정
  func lineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
      
      guard let labelText = self.text else { return }
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = lineSpacing
      paragraphStyle.lineHeightMultiple = lineHeightMultiple
      
      let attributedString:NSMutableAttributedString
      if let labelattributedText = self.attributedText {
          attributedString = NSMutableAttributedString(attributedString: labelattributedText)
      } else {
          attributedString = NSMutableAttributedString(string: labelText)
      }
      
      // Line spacing attribute
      attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
      
      self.attributedText = attributedString
  }
  
}
