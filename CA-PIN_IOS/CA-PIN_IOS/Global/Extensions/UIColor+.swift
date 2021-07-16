//
//  UIColor+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//


import UIKit

// MARK: - UIColor Extension
extension UIColor {
//  convenience init(rgb: Int) {
//      self.init(
//          red: (rgb >> 16) & 0xFF,
//          green: (rgb >> 8) & 0xFF,
//          blue: rgb & 0xFF
//      )
//  }


  @nonobjc class var gray2: UIColor {
    return UIColor(white: 237.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var gray3: UIColor {
    return UIColor(white: 196.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var gray4: UIColor {
    return UIColor(white: 135.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var black: UIColor {
    return UIColor(white: 0.0, alpha: 1.0)
  }

  @nonobjc class var white: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }

  @nonobjc class var maincolor1: UIColor {
    return UIColor(red: 107.0 / 255.0, green: 80.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var pointcolor1: UIColor {
    return UIColor(red: 169.0 / 255.0, green: 142.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category1: UIColor {
    return UIColor(red: 100.0 / 255.0, green: 146.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category2: UIColor {
    return UIColor(red: 107.0 / 255.0, green: 188.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category4: UIColor {
    return UIColor(red: 129.0 / 255.0, green: 111.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category3: UIColor {
    return UIColor(red: 1.0, green: 194.0 / 255.0, blue: 75.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category6: UIColor {
    return UIColor(red: 201.0 / 255.0, green: 215.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category7: UIColor {
    return UIColor(red: 178.0 / 255.0, green: 185.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category5: UIColor {
    return UIColor(red: 1.0, green: 194.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category8: UIColor {
    return UIColor(red: 1.0, green: 142.0 / 255.0, blue: 142.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category10: UIColor {
    return UIColor(red: 157.0 / 255.0, green: 197.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var category9: UIColor {
    return UIColor(red: 235.0 / 255.0, green: 234.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var logoSkyblue: UIColor {
    return UIColor(red: 172.0 / 255.0, green: 212.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var logoBrown: UIColor {
    return UIColor(red: 146.0 / 255.0, green: 120.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var logoWhite: UIColor {
    return UIColor(white: 1.0, alpha: 0.8)
  }

  @nonobjc class var subcolorBlue1: UIColor {
    return UIColor(red: 220.0 / 255.0, green: 236.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBlue3: UIColor {
    return UIColor(red: 187.0 / 255.0, green: 220.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBlue2: UIColor {
    return UIColor(red: 206.0 / 255.0, green: 228.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBlue4: UIColor {
    return UIColor(red: 145.0 / 255.0, green: 194.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBrown1: UIColor {
    return UIColor(red: 214.0 / 255.0, green: 199.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBrown2: UIColor {
    return UIColor(red: 198.0 / 255.0, green: 178.0 / 255.0, blue: 163.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBrown3: UIColor {
    return UIColor(red: 148.0 / 255.0, green: 125.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var subcolorBrown4: UIColor {
    return UIColor(red: 107.0 / 255.0, green: 81.0 / 255.0, blue: 61.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var backgroundCover: UIColor {
    return UIColor(white: 0.0, alpha: 0.6)
  }

  @nonobjc class var pointcolorGreen: UIColor {
    return UIColor(red: 145.0 / 255.0, green: 177.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var pointcolorYellow: UIColor {
    return UIColor(red: 1.0, green: 205.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var pointcolorRed: UIColor {
    return UIColor(red: 244.0 / 255.0, green: 94.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var gray1: UIColor {
    return UIColor(white: 249.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var photoCover: UIColor {
      return UIColor(white: 71.0 / 255.0, alpha: 0.4)
    }
}
