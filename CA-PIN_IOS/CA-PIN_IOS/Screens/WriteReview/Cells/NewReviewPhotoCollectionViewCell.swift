//
//  NewReviewPhotoCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/11.
//

import UIKit

import Kingfisher
import SnapKit
import Then

// MARK: - NewReviewPhotoCollectionViewCell

class NewReviewPhotoCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  
  let addPhotoView = UIView()
  let addPhotoIconImageview = UIImageView()
  let addphotoLabel = UILabel()
  
  
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

// MARK: - Extensions

extension NewReviewPhotoCollectionViewCell {
  func layout() {
    
  }
  func layoutAddPhotoView() {
    self.contentView.add(addPhotoView) {
      $0.setRounded(radius: 5)
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading).offset(20)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
  func layoutAddPhotoIconImageView() {
    self.addPhotoView.add(addPhotoIconImageview) {
      $0.image = UIImage(named: "picturePlus")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.addPhotoView.snp.top).offset(23)
        $0.leading.equalTo(self.addPhotoView.snp.leading).offset(31)
        $0.trailing.equalTo(self.addPhotoView.snp.trailing).offset(-30)
      }
    }
  }
  func layoutAddPhotoLabel() {
    self.addPhotoView.add(addphotoLabel) {
      $0.setupLabel(text: "(최대5장)", color: .white, font: .notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.addPhotoIconImageview).offset(3)
        $0.leading.equalTo(self.addPhotoView).offset(14)
        $0.trailing.equalTo(self.addPhotoView).offset(-14)
        $0.bottom.equalTo(self.addPhotoView).offset(-18)
      }
    }
  }
  
  // MARK: - General Helpers
  
}

