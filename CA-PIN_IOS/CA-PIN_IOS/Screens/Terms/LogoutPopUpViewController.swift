//
//  LogoutPopUpViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/12/04.
//

import UIKit
import Moya
import RxMoya
import RxSwift
import SwiftKeychainWrapper

class LogoutPopUpViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let logoutButton = UIButton()
  
  var loginVCFlag: Int = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}

// MARK: - Extensions
extension LogoutPopUpViewController {
  
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
      $0.setupLabel(text: "로그아웃",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
//      $0.letterSpacing = -1
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.popupView.snp.top).offset(26)
      }
    }
  }
  func layoutDescriptionLabel() {
    popupView.add(descriptionLabel) {
      $0.numberOfLines = 0
      $0.setupLabel(text: "계정에 저장된 정보에 접근하려면\n다시 로그인해야 합니다. 로그아웃하시겠습니까?",
                    color: 0x6f6f6f.color,
                    font: .notoSansKRRegularFont(fontSize: 14),
                    align: .center)
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
      $0.setupButton(title: "취소",
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
      $0.setupButton(title: "확인",
                     color: .white,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .maincolor1,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.logoutButtonClicked), for: .touchUpInside)
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
  @objc func logoutButtonClicked() {
    KeychainWrapper.standard.remove(forKey: "loginEmail")
    KeychainWrapper.standard.remove(forKey: "loginPassword")
    KeychainWrapper.standard.remove(forKey: "tokenAccess")
    KeychainWrapper.standard.remove(forKey: "tokenRefresh")
    
    loginVCFlag = KeychainWrapper.standard.integer(forKey: "loginVCFlag") ?? 2
    
    var loginVC = self.presentingViewController?.children[1] as? LoginViewController
    let endIndex = self.presentingViewController?.children.endIndex ?? 0
    let newSettingVC = self.presentingViewController?.children[endIndex-1] as? NewSettingViewController
    print(newSettingVC?.navigationController?.children)
    if loginVCFlag == 0 {
      print("뷰 안뜸")
//      loginVC = self.navigationController?.children[2] as? LoginViewController
//      if let vc = loginVC {
//        self.dismiss(animated: false, completion: {
//          newSettingVC?.navigationController?.popToViewController(vc, animated: true)
//        })
      self.dismiss(animated: false, completion: {
        newSettingVC?.navigationController?.popToRootViewController(animated: true)
      })
    } else {
      print("뷰 뜸")
      if let vc = loginVC {
        self.dismiss(animated: false, completion: {
          newSettingVC?.navigationController?.popToViewController(vc, animated: true)
        })
      }
    }
  }
}
