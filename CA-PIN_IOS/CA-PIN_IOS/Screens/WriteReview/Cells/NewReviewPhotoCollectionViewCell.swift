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
    layoutAddPhotoView()
    layoutAddPhotoIconImageView()
    layoutAddPhotoLabel()
  }
  func layoutAddPhotoView() {
    self.contentView.add(addPhotoView) {
      $0.setRounded(radius: 5)
      $0.backgroundColor = .maincolor1
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutAddPhotoIconImageView() {
    self.addPhotoView.add(addPhotoIconImageview) {
      $0.image = UIImage(named: "picturePlus")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.addPhotoView.snp.top).offset(23)
        $0.leading.equalTo(self.addPhotoView.snp.leading).offset(31)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(18)
        $0.width.equalTo(18)
      }
    }
  }
  func layoutAddPhotoLabel() {
    self.addPhotoView.add(addphotoLabel) {
      $0.setupLabel(text: "(최대5장)", color: .white, font: .notoSansKRMediumFont(fontSize: 12), align: .center)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.addPhotoIconImageview.snp.bottom).offset(3)
        $0.leading.equalTo(self.addPhotoView.snp.leading).offset(14)
        $0.centerX.equalToSuperview()
      }
    }
  }
}
