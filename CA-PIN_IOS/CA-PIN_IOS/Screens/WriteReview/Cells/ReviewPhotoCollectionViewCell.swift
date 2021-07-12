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
  
  let reviewPhotoImageView = UIImageView()
  
  func setData(photoView : String)
  
  {
    if let image = UIImage(named: photoView)
    {
      reviewPhotoImageView.image = image
    }
    
  }
  
  
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
  }
  
  func layoutReviewPhotoImageView() {
    self.contentView.add(reviewPhotoImageView) {
      $0.image = UIImage(named: "group637")
      
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView
                              .snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom)
        
      }
    }
  }
}


