//
//  TagCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/08.
//

import UIKit

import SnapKit
import Then

// MARK: - TagCollectionViewCell
class MyReviewTagCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let tagLabel = UILabel()
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

extension MyReviewTagCollectionViewCell {
  func layout() {
    self.contentView.borderColor = .pointcolor1
    self.contentView.borderWidth = 1
    self.contentView.backgroundColor = .white
    self.contentView.layer.masksToBounds = true
    self.contentView.setRounded(radius: 11)
    layoutTagLabel()
  }
  func layoutTagLabel() {
    self.contentView.add(self.tagLabel) {
      $0.setupLabel(text: "", color: .pointcolor1, font: UIFont.notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
  func setTagData(tag: String) {
    self.tagLabel.text = tag
  }
}
