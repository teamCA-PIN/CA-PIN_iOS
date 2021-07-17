//
//  TagCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/08.
//

import UIKit

import SnapKit
import Then

// MARK: - TagCollectionViewCell
class TagCollectionViewCell: UICollectionViewCell {
    
  // MARK: - Components
  let containerView = UIView()
  let tagLabel = UILabel()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.tagLabel.text = nil
    updateLayout()
  }
}

// MARK: - Extensions
extension TagCollectionViewCell {
  func layout() {
    layoutContainerView()
    layoutTagLabel()
  }
  func layoutContainerView() {
    contentView.add(containerView) {
      $0.setRounded(radius: 13)
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutTagLabel() {
    containerView.add(tagLabel) {
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
  
  // MARK: - General Helpers
  func dataBind(tagName: String) {
    tagLabel.setupLabel(text: tagName, color: .white, font: .notoSansKRRegularFont(fontSize: 12))
  }
  
  func updateLayout() {
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
}
