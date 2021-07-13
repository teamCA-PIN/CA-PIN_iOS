//
//  CategoryCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/02.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - CategoryCollectionViewCell
class CategoryCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let colorView = UIImageView()
  
  var isViewSelected: Bool?
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = .clear
    layout()
  }
  
}

// MARK: - Extensions
extension CategoryCollectionViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    contentView.backgroundColor = .clear
    contentView.add(colorView) {
      $0.setRounded(radius: 17)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(17)
        $0.leading.equalTo(self.contentView.snp.leading).offset(13)
        $0.center.equalToSuperview()
        $0.width.height.equalTo(34)
      }
    }
  }
}
