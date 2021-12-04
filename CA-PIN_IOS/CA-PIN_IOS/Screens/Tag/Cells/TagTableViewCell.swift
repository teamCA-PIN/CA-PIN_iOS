//
//  TagTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - TagTableViewCell
class TagTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let containerView = UIView()
  let tagButton = UIButton().then {
    $0.tag = 0
  }
  var rootViewController = UIViewController()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

// MARK: - Extension
extension TagTableViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    self.contentView.backgroundColor = .white
    layoutContainerView()
    layoutTagButton()
  }
  func layoutContainerView() {
    contentView.add(containerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
        $0.top.equalTo(self.contentView.snp.top).offset(8)
        $0.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
      }
    }
  }
  func layoutTagButton() {
    containerView.add(tagButton) {
      $0.setTitle(" ", for: .normal)
      $0.setTitleColor(.pointcolor1, for: .normal)
      $0.setTitleColor(.white, for: .selected)
      $0.titleLabel?.font = .notoSansKRMediumFont(fontSize: 16)
      $0.backgroundColor = .white
      $0.setRounded(radius: 26)
      $0.addTarget(self, action: #selector(self.clickedTagButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  
  // MARK: - General Helpers
  @objc func clickedTagButton() {
    self.tagButton.isSelected.toggle()
    guard let rootVC = self.rootViewController as? TagViewController else { return }
    if self.tagButton.isSelected == true {
      let selectedNumber = getTableCellIndexPath()
      rootVC.selectedTag.append(selectedNumber)
    }
    else {
      let selectedNumber = getTableCellIndexPath()
      for i in 0..<rootVC.selectedTag.count {
        if rootVC.selectedTag[i] == selectedNumber {
          rootVC.selectedTag.remove(at: i)
          break
        }
      }
    }
    changeBackground()
    if rootVC.capinOrMyMap == 0 {
      rootVC.setupCafeList()
    }
    else {
      rootVC.setupMyMapList()
    }
    rootVC.reloadInputViews()
  }
  func changeBackground() {
    if self.tagButton.isSelected == true {
      self.tagButton.backgroundColor = .pointcolor1
    }
    else {
      self.tagButton.backgroundColor = .white
    }
  }
}
