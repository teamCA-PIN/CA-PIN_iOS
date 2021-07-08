//
//  PhotoCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/09.
//

import UIKit

import Kingfisher
import SnapKit
import Then

// MARK: - PhotoCollectionViewCell
class PhotoCollectionViewCell: UICollectionViewCell {
    
  // MARK: - Components
  let containerView = UIView()
  let photoImageView = UIImageView()
  let moreLabel = UILabel()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = .clear
    layout()
  }
}

// MARK: - Extensions
extension PhotoCollectionViewCell {
  func layout() {
    contentView.backgroundColor = .clear
    layoutContainerView()
    layoutPhotoImageView()
    layoutMoreLabel()
  }
  func layoutContainerView() {
    contentView.add(containerView) {
      $0.setRounded(radius: 5)
      $0.backgroundColor = .gray1
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutPhotoImageView() {
    containerView.add(photoImageView) {
      $0.image = UIImage(named: "image176")
      $0.setRounded(radius: 5)
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutMoreLabel() {
    containerView.add(moreLabel) {
      $0.isHidden = true
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
  
  // MARK: - Genenral Helpers
  func dataBind(imageName: String, moreNumber: Int) {
    photoImageView.setImage(from: imageName, UIImage(named: "image176")!)
    moreLabel.setupLabel(text: "+\(moreNumber)",
                         color: .gray3,
                         font: .notoSansKRRegularFont(fontSize: 14))
  }
}
