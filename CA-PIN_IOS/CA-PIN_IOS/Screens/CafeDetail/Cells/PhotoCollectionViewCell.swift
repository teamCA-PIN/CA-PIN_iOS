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
    let alphaView = UIView().then {
        $0.isHidden = true
    }
    let moreLabel = UILabel().then {
        $0.isHidden = true
    }
  
  var rootViewController: UIViewController?
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = .clear
    layout()
  }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        alphaView.isHidden = true
        moreLabel.isHidden = true
    }
  
}

// MARK: - Extensions
extension PhotoCollectionViewCell {
  func layout() {
    contentView.backgroundColor = .clear
    layoutContainerView()
    layoutPhotoImageView()
      layoutAlphaView()
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
      $0.setRounded(radius: 5)
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutAlphaView() {
    containerView.add(alphaView) {
      $0.backgroundColor = .photoCover
      $0.setRounded(radius: 5)
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutMoreLabel() {
    alphaView.add(moreLabel) {
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
  
  // MARK: - Genenral Helpers
  func dataBind(imageName: String?, moreNumber: Int) {
    if let image = imageName {
      photoImageView.imageFromUrl(image, defaultImgPath: "")
    }
    moreLabel.setupLabel(text: "+\(moreNumber)",
                         color: .white,
                         font: .notoSansKRRegularFont(fontSize: 14))
  }
  func updateLayout() {
    self.setNeedsLayout()
    self.layoutIfNeeded()
  }
}
