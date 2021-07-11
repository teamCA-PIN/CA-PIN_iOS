//
//  ReviewImageCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/11.
//

import UIKit

class ReviewImageCollectionViewCell: UICollectionViewCell {
  // MARK: - Components
  let reviewImageView = UIImageView()
    
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    self.contentView.setRounded(radius: 5)
    self.contentView.backgroundColor = .brown
    layout()
  }
}
extension ReviewImageCollectionViewCell {
  func layout() {
    layoutReviewImage()
  }
  func layoutReviewImage() {
    self.contentView.add(self.reviewImageView) {
      $0.image = UIImage(named: "group637")
      $0.contentMode = .scaleAspectFit
      $0.snp.makeConstraints {
        $0.width.equalTo(80)
        $0.height.equalTo(80)
        $0.centerX.centerY.equalToSuperview()
      }
    }
  }
}
