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
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

// MARK: - Extensions
extension TabbarCollectionViewCell {

  // MARK: - Helper
  
  //MARK: - Layout Helpers
  func layout(){
    layoutTabbarImageView()
  }
  func layoutTabbarImageView() {
    self.contentView.add(self.tabImageView) {
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.contentView.snp.top)
        $0.height.equalTo(28)
        $0.width.equalTo(28)
      }
    }
  }
  func setImage(name: String) {
    self.tabImageView.image = UIImage(named: name)
  }
  @objc func categoryTabAction() {
    
  }
  @objc func reviewTabAction() {
    
  }
}
