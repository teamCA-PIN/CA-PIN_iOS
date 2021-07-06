//
//  UIButton+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import Foundation
import UIKit

import SnapKit
import Then

extension UIButton {
  public typealias UIButtonTargetClosure = (UIButton) -> ()
  private class UIButtonClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
      self.closure = closure
    }
  }
  
  /** 매번 setimage할때 귀찮아서 만듦 (normal 상태)
   - Parameter name: UIImage 이름을 적어주세요
   - Returns: 없음
   */
  func setImageByName(_ name: String){
    self.setImage(UIImage(named: name), for: .normal)
  }
  
  /** 매번 setimage할때 귀찮아서 만듦 (selected상태)
   - Parameter name: UIImage 이름을 적어주세요
   - parameter selected: selected일 때 이름을 적어주세요
   - Returns: 없음
   */
  func setImageByName(_ name: String, _ selected: String){
    self.setImage(UIImage(named: name), for: .normal)
    self.setImage(UIImage(named: name), for: .selected)
  }
  
  private struct AssociatedKeys {
    static var targetClosure = "targetClosure"
  }
  private var targetClosure: UIButtonTargetClosure? {
    get {
      guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIButtonClosureWrapper else { return nil }
      return closureWrapper.closure
      
    }
    set(newValue) {
      guard let newValue = newValue else { return }
      objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIButtonClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  @objc
  func closureAction() {
    guard let targetClosure = targetClosure else { return }
    targetClosure(self)
    
  }
  public func addAction(for event: UIButton.Event, closure: @escaping UIButtonTargetClosure) {
    targetClosure = closure
    addTarget(self, action: #selector(UIButton.closureAction), for: event)
  }
  func setupButton(title: String,
                   color: UIColor,
                   font: UIFont,
                   backgroundColor: UIColor,
                   state: UIControl.State,
                   radius: CGFloat) {
    self.setTitle(title, for: state)
    self.setTitleColor(color, for: state)
    self.titleLabel?.font = font
    self.backgroundColor = backgroundColor
    self.setRounded(radius: radius)
  }
}
