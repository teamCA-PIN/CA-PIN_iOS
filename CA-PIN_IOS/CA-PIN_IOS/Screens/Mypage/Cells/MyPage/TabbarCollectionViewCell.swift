//
//  TabbarCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

// MARK: - TabbarCollectionViewCell
class TabbarCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let tabImageView = UIImageView()
  
  //  override var isSelected: Bool {
  //      didSet {
  //        tabButton
  //        tabbarImageView.image = isSelected ? UIImage(named: "iconPin") : UIImage(named: "iconCloseBlack")
  //      }
  //  }
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    notificationCenter()
    layout()
  }
}

// MARK: - Extensions
extension TabbarCollectionViewCell {

  // MARK: - Helper
  func notificationCenter() {
    NotificationCenter.default.addObserver(self, selector: #selector(categoryTabAction), name: Notification.Name("CheckButtonClicked"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(reviewTabAction), name: Notification.Name("CheckButtonClicked"), object: nil)
  }
  
  //MARK: - Layout Helpers
  func layout(){
    layoutTabbarImageView()
  }
  func layoutTabbarImageView() {
    self.contentView.add(self.tabImageView) {
      //            $0.image = UIImage(named: "iconPin")
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.contentView.snp.top)
        $0.height.equalTo(28)
        $0.width.equalTo(28)
      }
    }
  }
  @objc func categoryTabAction() {
    
  }
  @objc func reviewTabAction() {
    
  }
}
