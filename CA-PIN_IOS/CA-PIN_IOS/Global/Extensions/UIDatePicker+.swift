//
//  UIDataPicker+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import Foundation
import UIKit

extension UIDatePicker {
	var textColor: UIColor? {
			set {
					setValue(newValue, forKeyPath: "textColor")
			}
			get {
					return value(forKeyPath: "textColor") as? UIColor
			}
		}
}
