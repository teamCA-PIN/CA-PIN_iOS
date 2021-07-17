//
//  TermsVersionTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/06.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - TermsVersionTableViewCell
class TermsVersionTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let containerView = UIView()
  let titleLabel = UILabel()
  let versionLabel = UILabel()
  
  final let currentVersion = 1.0
  final let latestVersion = 1.0
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
  
}

// MARK: - Extensions
extension TermsVersionTableViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    self.backgroundColor = .clear
    self.contentView.backgroundColor = .clear
    layoutContainerView()
    layoutTitleLabel()
    layoutVersionLabel()
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
      $0.setupLabel(text: "버전",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.leading.equalToSuperview()
        $0.centerY.equalToSuperview()
      }
    }
  }
  func layoutVersionLabel() {
    containerView.add(versionLabel) {
      $0.setupLabel(text: "현재 \(self.currentVersion) / 최신 \(self.latestVersion)",
                    color: 0x878787.color,
                    font: .notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.trailing.equalToSuperview()
        $0.centerY.equalToSuperview()
      }
    }
  }
}
