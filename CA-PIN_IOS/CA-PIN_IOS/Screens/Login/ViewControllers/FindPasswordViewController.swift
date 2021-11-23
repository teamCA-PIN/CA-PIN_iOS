//
//  FindPasswordViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/11/23.
//

import UIKit
import SnapKit
import Moya
import RxMoya
import RxSwift
import SwiftKeychainWrapper
import Then


// MARK: - FindPasswordViewController
class FindPasswordViewController: UIViewController {
  
  // MARK: - Components
  let navigationBarView = UIView()
  let backButton = UIButton()
  let navigationTitleLabel = UILabel()
  let explationLabel = UILabel()
  let emailLabel = UILabel()
  let emailTextField = UITextField()
  let emailBorderView = UIView()
  let emailExplationLabel = UILabel()
  let findPasswordButton = UIButton()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
    attribute()
    setTextField()
  }
}

extension FindPasswordViewController {
  func layout() {
    layoutNavigationBarView()
    layoutNavigationTitle()
    layoutBackButton()
    layoutExplationLabel()
    layoutEmailLabel()
    layoutEmailTextField()
    layoutEmailBorderView()
    layoutEmailExplationLabel()
    layoutFindPasswordButton()
  }
  func attribute() {
    self.emailTextField.delegate = self
  }
  func setTextField() {
    self.emailTextField.clearButtonMode = .whileEditing
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  func layoutNavigationBarView() {
    self.view.add(self.navigationBarView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.leading.equalToSuperview()
        $0.trailing.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutNavigationTitle() {
    self.navigationBarView.add(self.navigationTitleLabel) {
      $0.setupLabel(text: "비밀번호 찾기", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20), align: .center)
      $0.letterSpacing  = -1.0
      $0.snp.makeConstraints {
        $0.top.bottom.centerX.centerY.equalToSuperview()
      }
    }
  }
  func layoutBackButton() {
    self.navigationBarView.add(self.backButton) {
      $0.setImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.height.equalTo(28)
        $0.centerY.equalTo(self.navigationTitleLabel.snp.centerY)
        $0.leading.equalTo(self.navigationBarView.snp.leading).offset(20)
      }
    }
  }
  func layoutExplationLabel() {
    self.view.add(self.explationLabel) {
      $0.numberOfLines = 0
      $0.setupLabel(text: "회원가입 시에 사용한 이메일을 입력하시면\n인증번호를 전송해드립니다.", color: .gray4, font: .notoSansKRMediumFont(fontSize: 16), align: .center)
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.navigationBarView.snp.bottom).offset(70)
      }
    }
  }
  func layoutEmailLabel() {
    self.view.add(self.emailLabel) {
      $0.setupLabel(text: "이메일 아이디", color: .maincolor1, font: .notoSansKRMediumFont(fontSize: 16), align: .left)
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explationLabel.snp.bottom).offset(69)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutEmailTextField() {
    self.view.add(self.emailTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "yourname@example.com",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(23)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.top.equalTo(self.emailLabel.snp.bottom).offset(16)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutEmailBorderView() {
    self.view.add(self.emailBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.emailTextField.snp.bottom).offset(1)
        $0.leading.equalToSuperview().offset(48)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutEmailExplationLabel() {
    self.view.add(self.emailExplationLabel){
      $0.setupLabel(text: "회원가입시 사용한 이메일을 입력해주세요.", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12), align: .left)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailBorderView.snp.bottom).offset(8)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutFindPasswordButton() {
    self.view.add(self.findPasswordButton){
      $0.setupButton(title: "비밀번호 찾기", color: .white, font: .notoSansKRRegularFont(fontSize: 16), backgroundColor: .gray3, state: .normal, radius: 25)
      $0.titleLabel?.letterSpacing = -0.48
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(78)
        $0.height.equalTo(49)
        $0.bottom.equalToSuperview().offset(-34)
      }
    }
  }
}

extension FindPasswordViewController: UITextFieldDelegate {
  
}
