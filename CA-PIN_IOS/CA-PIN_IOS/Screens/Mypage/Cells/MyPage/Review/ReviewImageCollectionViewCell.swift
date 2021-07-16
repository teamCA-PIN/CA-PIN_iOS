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
  let overlayButton = UIButton()
  
  var moreNumber: Int = 2
    
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    self.contentView.setRounded(radius: 5)
    self.contentView.backgroundColor = .brown
    layout()
    self.overlayButton.isEnabled = false
    self.overlayButton.isHidden = true
  }
}
extension ReviewImageCollectionViewCell {
  func layout() {
    layoutReviewImage()
    layoutOverlayButton()
  }
  func layoutReviewImage() {
    self.contentView.add(self.reviewImageView) {
      $0.image = UIImage(named: "group637")
      $0.contentMode = .scaleAspectFill
      $0.snp.makeConstraints {
//        $0.width.equalTo(80)
//        $0.height.equalTo(80)
        $0.centerX.centerY.equalToSuperview()
      }
    }
  }
  func layoutOverlayButton() {
    self.contentView.add(self.overlayButton) {
      let photoCover = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 0.4)
      $0.setupButton(title: "+\(self.moreNumber)", color: .white, font: .notoSansKRRegularFont(fontSize: 14), backgroundColor: photoCover, state: .normal, radius: 5)
      $0.addTarget(self, action: #selector(self.overlayButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.centerY.equalToSuperview()
        $0.top.leading.bottom.trailing.equalToSuperview()
      }
    }
  }
  @objc func overlayButtonClicked() {
    let previewVC = PhotoPreviewViewController()
    previewVC.modalPresentationStyle = .overCurrentContext
    self.parentViewController?.present(previewVC, animated: false, completion: nil)
  }
}
