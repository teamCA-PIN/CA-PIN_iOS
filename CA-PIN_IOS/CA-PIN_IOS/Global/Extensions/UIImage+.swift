//
//  CALayer+.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//



import UIKit
extension UIImage {
	func resizeImage(newWidth: CGFloat) -> UIImage {
		
		let scale = newWidth / self.size.width // 새 이미지 확대/축소 비율
		let newHeight = self.size.height * scale
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
		self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
	
	func resizeImage( newSize: CGSize) -> UIImage {
		UIGraphicsBeginImageContext(newSize)
		self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
}
