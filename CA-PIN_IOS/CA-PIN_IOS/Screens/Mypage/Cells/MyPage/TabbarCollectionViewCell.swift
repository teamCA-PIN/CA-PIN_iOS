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
    let tabbarImageView = UIImageView()
  
  override var isSelected: Bool {
      didSet {
        tabbarImageView.image = isSelected ? UIImage(named: "iconCloseBlack") : UIImage(named: "logo")
      }
  }
    
    // MARK: - LifeCycles
    override func awakeFromNib() {
      super.awakeFromNib()
      layout()
    }
}

// MARK: - Extensions
extension TabbarCollectionViewCell {
    
    //MARK: - Layout Helpers
    func layout(){
        layoutTabbarImageView()
    }
    func layoutTabbarImageView() {
        self.contentView.add(self.tabbarImageView) {
            $0.image = UIImage(named: "logo")
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.contentView.snp.top)
                $0.height.equalTo(28)
                $0.width.equalTo(28)
            }
        }
    }
}
