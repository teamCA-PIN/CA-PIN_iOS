//
//  CALayer+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import UIKit

extension CALayer {
  
  func applyShadow(color: UIColor,
                   alpha: Float,
                   x: CGFloat,
                   y: CGFloat,
                   blur: CGFloat) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 1.0
  }
  
  func applyDefaultShadow(color: UIColor = .black,
                          alpha: Float = 0.5,
                          x: CGFloat = 0,
                          y: CGFloat = 10,
                          blur: CGFloat = 4) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 1.0
  }
  
  func applyCardShadow(color: UIColor = .black,
                       alpha: Float = 0.1,
                       x: CGFloat = 0,
                       y: CGFloat = 0,
                       blur: CGFloat = 8) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 1.0
  }
}

