//
//  TermsGeneralTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/06.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - TermsGeneralTableViewCell
class TermsGeneralTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let containerView = UIView()
  let titleLabel = UILabel()
  let nextButton = UIButton()
  
  var titleText: String?
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
  
}

// MARK: - Extensions
extension TermsGeneralTableViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    self.backgroundColor = .clear
    self.contentView.backgroundColor = .clear
    layoutContainerView()
    layoutTitleLabel()
    layoutNextButton()
  }
  func layoutContainerView() {
    contentView.add(containerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.contentView.snp.leading).offset(25)
        $0.trailing.equalTo(self.contentView.snp.trailing).offset(-20)
        $0.top.equalTo(self.contentView.snp.top).offset(18)
        $0.height.equalTo(28)
      }
    }
  }
  func layoutTitleLabel() {
    containerView.add(titleLabel) {
      $0.setupLabel(text: self.titleText ?? "제목",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = 0.8
      $0.snp.makeConstraints {
        $0.leading.equalToSuperview()
        $0.centerY.equalToSuperview()
      }
    }
  }
  func layoutNextButton() {
    containerView.add(nextButton) {
      $0.setBackgroundImage(UIImage(named: "iconNextbtn"), for: .normal)
      $0.snp.makeConstraints {
        $0.trailing.equalToSuperview()
        $0.centerY.equalToSuperview()
        $0.height.width.equalTo(28)
      }
    }
  }
}
