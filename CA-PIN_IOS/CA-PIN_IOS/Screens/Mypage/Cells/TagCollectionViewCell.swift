//
//  TagCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/08.
//

import UIKit

// MARK: - TagCollectionViewCell
class TagCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let tagStackView = UIStackView()
  let leftView = UIView()
  let tagLabel = UILabel()
  let rightView = UIView()
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

extension TagCollectionViewCell {
  func layout() {
    layoutTagStackView()
  }
  func layoutTagStackView() {
    self.contentView.add(self.leftView) {
      $0.setRounded(radius: 16)
      $0.backgroundColor = .subcolorBrown1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
}
