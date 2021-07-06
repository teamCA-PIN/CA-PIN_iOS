//
//  HamburgerViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/01.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - HamburgerViewController
class HamburgerViewController: UIViewController {
  
  // MARK: - Components
  let closeButton = UIButton()
  let profileImageView = UIImageView()
  let profileNameLabel = UILabel()
  let profileEmailLabel = UILabel()
  let cafetiContainerView = UIView()
  let cafetiLabel = UILabel()
  let archiveContainerView = UIView()
  let archiveTitleLabel = UILabel()
  let archiveNextButton = UIButton()
  let archivePinTitleLabel = UILabel()
  let archivePinContentLabel = UILabel()
  let archiveFeedTitleLabel = UILabel()
  let archiveFeedContentLabel = UILabel()
  let policyButton = UIButton()
  let logoutButton = UIButton()
  let copyrightLabel = UILabel()
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}

// MARK: - Extensions
extension HamburgerViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = 0xDCECF5.color
    layoutCloseButton()
    layoutProfileImageView()
    layoutProfileNameLabel()
    layoutProfileEmailLabel()
    layoutCafetiContainerLabel()
    layoutCafetiLabel()
    layoutArchiveContainerView()
    layoutArchiveTitleLabel()
    layoutArchiveNextButton()
    layoutArchivePinTitleLabel()
    layoutArchivePinContentLabel()
    layoutArchiveFeedTitleLabel()
    layoutArchiveFeedContentLabel()
    layoutPolicyButton()
    layoutLogoutButton()
    layoutCopyrightLabel()
  }
  func layoutCloseButton() {
    view.add(closeButton) {
      $0.setBackgroundImage(UIImage(named:"logo"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedCloseButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.width.height.equalTo(30)
      }
    }
  }
  func layoutProfileImageView() {
    view.add(profileImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.snp.leading).offset(97)
        $0.top.equalTo(self.closeButton.snp.bottom).offset(68)
        $0.width.equalTo(self.view.frame.width * 160/375)
        $0.height.equalTo(self.view.frame.width * 144/375)
      }
    }
  }
  func layoutProfileNameLabel() {
    view.add(profileNameLabel) {
      $0.setupLabel(text: "김카핀", color: .black,
                    font: .notoSansKRRegularFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.profileImageView.snp.bottom).offset(15)
      }
    }
  }
  func layoutProfileEmailLabel() {
    view.add(profileEmailLabel) {
      $0.setupLabel(text: "capin@naver.com", color: 0x878787.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.profileNameLabel.snp.bottom).offset(3)
      }
    }
  }
  func layoutCafetiContainerLabel() {
    view.add(cafetiContainerView) {
      $0.backgroundColor = 0xA98E7A.color
      $0.setRounded(radius: 4)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.profileEmailLabel.snp.bottom).offset(11)
        $0.width.equalTo(self.view.frame.width * 54/375)
        $0.height.equalTo(self.view.frame.width * 18/375)
      }
    }
  }
  func layoutCafetiLabel() {
    cafetiContainerView.add(cafetiLabel) {
      $0.setupLabel(text: "WBFJ", color: .white, font: .notoSansKRRegularFont(fontSize: 15))
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
  func layoutArchiveContainerView() {
    view.add(archiveContainerView) {
      $0.backgroundColor = .white
      $0.setRounded(radius: 4)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.cafetiContainerView.snp.bottom).offset(40)
        $0.width.equalTo(self.view.frame.width * 200/375)
        $0.height.equalTo(self.view.frame.width * 115/375)
      }
    }
  }
  func layoutArchiveTitleLabel() {
    archiveContainerView.add(archiveTitleLabel) {
      $0.setupLabel(text: "아카이브", color: 0xA98E7A.color,
                    font: .notoSansKRRegularFont(fontSize: 18))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.archiveContainerView.snp.top).offset(20)
        $0.leading.equalTo(self.archiveContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutArchiveNextButton() {
    archiveContainerView.add(archiveNextButton) {
      $0.setBackgroundImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.archiveTitleLabel.snp.centerY)
        $0.trailing.equalTo(self.archiveContainerView.snp.trailing).offset(-20)
        $0.height.equalTo(20)
        $0.width.equalTo(15)
      }
    }
  }
  func layoutArchivePinTitleLabel() {
    archiveContainerView.add(archivePinTitleLabel) {
      $0.setupLabel(text: "핀",
                    color: .black,
                    font: .notoSansKRRegularFont(fontSize: 15))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.archiveTitleLabel.snp.leading)
        $0.top.equalTo(self.archiveTitleLabel.snp.bottom).offset(17)
      }
    }
  }
  func layoutArchivePinContentLabel() {
    archiveContainerView.add(archivePinContentLabel) {
      $0.setupLabel(text: "25",
                    color: 0x91C2DE.color,
                    font: .notoSansKRRegularFont(fontSize: 15))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.archivePinTitleLabel.snp.centerY)
        $0.trailing.equalTo(self.archiveNextButton.snp.trailing)
      }
    }
  }
  func layoutArchiveFeedTitleLabel() {
    archiveContainerView.add(archiveFeedTitleLabel) {
      $0.setupLabel(text: "피드",
                    color: .black,
                    font: .notoSansKRRegularFont(fontSize: 15))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.archivePinTitleLabel.snp.leading)
        $0.top.equalTo(self.archivePinTitleLabel.snp.bottom).offset(3)
      }
    }
  }
  func layoutArchiveFeedContentLabel() {
    archiveContainerView.add(archiveFeedContentLabel) {
      $0.setupLabel(text: "17",
                    color: 0x91C2DE.color,
                    font: .notoSansKRRegularFont(fontSize: 15))
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.archivePinContentLabel.snp.trailing)
        $0.centerY.equalTo(self.archiveFeedTitleLabel.snp.centerY)
      }
    }
  }
  func layoutPolicyButton() {
    view.add(policyButton) {
      $0.setupButton(title: "약관 및 정책",
                     color: 0xA98E7A.color,
                     font: .notoSansKRRegularFont(fontSize: 17),
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedTermsButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.archiveContainerView.snp.bottom).offset(56)
        $0.width.equalTo(self.view.frame.width * 67/375)
        $0.height.equalTo(self.view.frame.width * 21/375)
      }
      if $0.titleLabel?.adjustsFontSizeToFitWidth == false {
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
      }
    }
  }
  func layoutLogoutButton() {
    view.add(logoutButton) {
      $0.setupButton(title: "로그아웃",
                     color: 0xA98E7A.color,
                     font: .notoSansKRRegularFont(fontSize: 17),
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.policyButton.snp.bottom).offset(6)
        $0.width.equalTo(self.view.frame.width * 50/375)
        $0.height.equalTo(self.view.frame.width * 21/375)
      }
      if $0.titleLabel?.adjustsFontSizeToFitWidth == false {
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
      }
    }
  }
  func layoutCopyrightLabel() {
    view.add(copyrightLabel) {
      $0.setupLabel(text: "copyright CA:PIN",
                    color: 0x98E7A.color,
                    font: .notoSansKRRegularFont(fontSize: 10))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.logoutButton.snp.bottom).offset(84)
      }
    }
  }
  
  // MARK: - General Helpers
  @objc func clickedCloseButton() {
    self.navigationController?.popViewController(animated: true)
  }
  @objc func clickedTermsButton() {
    let termsVC = TermsViewController()
    self.navigationController?.pushViewController(termsVC, animated: false)
  }
}
