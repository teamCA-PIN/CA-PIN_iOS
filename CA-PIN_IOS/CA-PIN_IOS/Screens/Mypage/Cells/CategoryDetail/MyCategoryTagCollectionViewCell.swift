//
//  MyCategoryTagCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/12/04.
//

import UIKit

import SnapKit
import Then

// MARK: - TagCollectionViewCell
class MyCategoryTagCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let tagLabel = UILabel()
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

extension MyCategoryTagCollectionViewCell {
  func layout() {
    self.contentView.backgroundColor = .gray1
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
