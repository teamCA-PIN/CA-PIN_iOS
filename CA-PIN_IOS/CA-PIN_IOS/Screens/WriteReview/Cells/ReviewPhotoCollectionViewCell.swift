//
//  ReviewPhotoCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/11.
//

import UIKit

import Kingfisher
import SnapKit
import Then

// MARK: - ReviewPhotoCollectionViewCell

class ReviewPhotoCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  
  var reviewPhotoImageView = UIImageView() {
    didSet {
        self.reviewPhotoImageView.contentMode = .scaleAspectFill
    }
  }
  let photoDeleteButton = UIButton()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

// MARK: - Extensions

extension ReviewPhotoCollectionViewCell {
  func layout() {
    layoutReviewPhotoImageView()
    layoutPhotoDeleteButton()
  }
  
  func layoutReviewPhotoImageView() {
    self.contentView.add(reviewPhotoImageView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
  func layoutPhotoDeleteButton(){
    self.reviewPhotoImageView.add(photoDeleteButton) {
      $0.setImage(UIImage(named: "iconDelete"), for: .normal)
//      $0.addTarget(self, action: #selector(self.deleteButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewPhotoImageView.snp.top).offset(2)
        $0.leading.equalTo(self.reviewPhotoImageView.snp.leading).offset(58)
        $0.trailing.equalTo(self.reviewPhotoImageView.snp.trailing).offset(-2)
        $0.bottom.equalTo(self.reviewPhotoImageView.snp.bottom).offset(-58)
        $0.height.equalTo(20)
        $0.width.equalTo(20)
      }
    }
  }
}
