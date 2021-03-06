//
//  WithdrawPopUpViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/12/05.
//

import UIKit

import SnapKit
import Then

class WithdrawPopUpViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let logoutButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}

// MARK: - Extensions
extension WithdrawPopUpViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = .backgroundCover
    layoutPopupView()
    layoutTitleLabel()
    layoutDescriptionLabel()
    layoutButtonContainerView()
    layoutCancelButton()
    layoutLogoutButton()
  }
  func layoutPopupView() {
    self.view.add(self.popupView) {
      $0.setRounded(radius: 6)
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.width.equalTo(335)
        $0.height.equalTo(197)
      }
    }
  }
  func layoutTitleLabel() {
    popupView.add(titleLabel) {
      $0.setupLabel(text: "회원탈퇴",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.popupView.snp.top).offset(26)
      }
    }
  }
  func layoutDescriptionLabel() {
    popupView.add(descriptionLabel) {
      $0.numberOfLines = 0
      $0.setupLabel(text: "탈퇴 시 회원님의 계정에 저장된\n모든 정보가 삭제됩니다.",
                    color: 0x6f6f6f.color,
                    font: .notoSansKRRegularFont(fontSize: 14),
                    align: .center)
      $0.numberOfLines = 2
      $0.letterSpacing = -0.6
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
      }
    }
  }
  func layoutButtonContainerView() {
    popupView.add(buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.height.equalTo(56)
      }
    }
  }
  func layoutCancelButton() {
    buttonContainerView.add(cancelButton) {
      $0.setupButton(title: "아직",
                     color: .black,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .gray2,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedCancelButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.buttonContainerView.snp.centerX)
        $0.leading.top.bottom.equalToSuperview()
      }
    }
  }
  func layoutLogoutButton() {
    buttonContainerView.add(logoutButton) {
      $0.setupButton(title: "준비중 ㅋㅋ",
                     color: .white,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .maincolor1,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.withdrawButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.buttonContainerView.snp.centerX)
        $0.trailing.top.bottom.equalToSuperview()
      }
    }
  }
  // MARK: - General Helpers
  @objc func clickedCancelButton() {
    self.dismiss(animated: false, completion: nil)
  }
  @objc func withdrawButtonClicked() {
    self.dismiss(animated: false, completion: nil)
  }
}

