//
//  UIFont+.swift
//  Zeepy
//
//  Created by 김태훈 on 2021/03/15.
//

import Foundation
import UIKit
extension UIFont {
  class func appGothicNeoMediumFont(fontSize: CGFloat) -> UIFont {
      return  UIFont(name: "AppleSDGothicNeo-Medium", size: fontSize)!
  }
  class func appGothicNeoSemiBoldFont(fontSize: CGFloat) -> UIFont {
      return  UIFont(name: "AppleSDGothicNeo-SemiBold", size: fontSize)!
  }
  class func appGothicNeoLightFont(fontSize: CGFloat) -> UIFont {
      return UIFont(name: "AppleSDGothicNeo-Light", size: fontSize)!
  }
  class func appGothicNeoBoldFont(fontSize: CGFloat) -> UIFont {
      return UIFont(name: "AppleSDGothicNeo-Bold", size: fontSize)!
  }
  class func appGothicNeoRegularFont(fontSize: CGFloat) -> UIFont {
      return UIFont(name: "AppleSDGothicNeo-Regular", size: fontSize)!
  }
  class func nanumRoundExtraBold(fontSize: CGFloat) -> UIFont{
    return UIFont(name: "NanumSquareRoundOTFEB", size: fontSize)!
  }
  class func nanumRoundBold(fontSize: CGFloat) -> UIFont{
    return UIFont(name: "NanumSquareRoundOTFB", size: fontSize)!
  }
  class func nanumRoundRegular(fontSize: CGFloat) -> UIFont{
    return UIFont(name: "NanumSquareRoundOTFR", size: fontSize)!
  }
  class func nanumRoundLite(fontSize: CGFloat) -> UIFont{
    return UIFont(name: "NanumSquareRoundOTFL", size: fontSize)!
  }
}
