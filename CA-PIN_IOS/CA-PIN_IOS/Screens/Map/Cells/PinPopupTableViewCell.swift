//
//  PinPopupTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/02.
//

import UIKit

import SnapKit
import Then

// MARK: - PinPopupTableViewCell
class PinPopupTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let containerView = UIView()
  let tagImageView = UIImageView()
  let categoryTitleLabel = UILabel()
  let selectbutton = UIButton()
  
  var rootViewController = UIViewController()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = .clear
    self.selectionStyle = .none
    layout()
  }

}

// MARK: - Extensions
extension PinPopupTableViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    self.backgroundColor = .white
    layoutContainerView()
    layoutTagImageView()
    layoutCategoryTitleLabel()
    layoutSelectButton()
  }
  func layoutContainerView() {
    contentView.add(containerView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutTagImageView() {
    containerView.add(tagImageView) {
      $0.image = UIImage(named: "colorchip1")
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalTo(self.containerView.snp.leading).offset(26)
        $0.width.height.equalTo(29)
      }
    }
  }
  func layoutCategoryTitleLabel() {
    containerView.add(categoryTitleLabel) {
      $0.setupLabel(text: "새 카테고리",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.tagImageView.snp.centerY)
        $0.leading.equalTo(self.tagImageView.snp.trailing).offset(22)
      }
    }
  }
  func layoutSelectButton() {
    containerView.add(selectbutton) {
      $0.setBackgroundImage(UIImage(named: "checkboxInactive"), for: .normal)
      $0.setBackgroundImage(UIImage(named: "checkboxActive"), for: .selected)
      $0.addTarget(self, action: #selector(self.clickedSelectButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.tagImageView.snp.centerY)
        $0.trailing.equalTo(self.containerView.snp.trailing).offset(-30)
        $0.width.height.equalTo(28)
      }
    }
  }
  
  // MARK: - General Helpers
  @objc func clickedSelectButton() {
    self.selectbutton.isSelected.toggle()
    guard let pinVC = self.rootViewController as? PinPopupViewController else { return }
    if self.selectbutton.isSelected == true {
      pinVC.selectedIndex = getTableCellIndexPath()
      pinVC.categoryTableView.reloadData()
    }
    else {
      pinVC.selectedIndex = 100
    }
  }
}
