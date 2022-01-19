//
//  PhotoPreviewCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/10.
//

import UIKit

import SnapKit
import Then

// MARK: - PhotoPreviewCollectionViewCell
class PhotoPreviewCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let photoImageView = UIImageView()
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super .init(frame: frame)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Extensions
extension PhotoPreviewCollectionViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    self.backgroundColor = .clear
    self.contentView.backgroundColor = .clear
    contentView.add(photoImageView) {
      $0.setRounded(radius: 12)
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  
  // MARK: - General Helpers
  func dataBind(imageName: String?) {
    if let image = imageName {
      photoImageView.setImage(from: image, UIImage(named: "capinLogo")!)
    }
  }
}
