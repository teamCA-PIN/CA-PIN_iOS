//
//  LoginViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import SnapKit
import Then

// MARK: - LoginViewController
class LoginViewController: UIViewController {
  
  // MARK: - Components
  let logoImageView = UIImageView()
  let emailLabel = UILabel()
  let emailTextField = UITextField()
  let passwordLabel = UILabel()
  let passwordTextField = UITextField()
  let loginButton = UIButton()
  let buttonContainerView = UIView()
  let findPasswordButton = UIButton()
  let signupButton = UIButton()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
  
}

// MARK: - Extensions
extension LoginViewController {
  
  // MARK: - Layout Helper
  func layout() {
    layoutLogoImageView()
    layoutEmailLabel()
    layoutEmailTextField()
    layoutPasswordLabel()
    layoutPasswordTextField()
    layoutLoginButton()
    layoutButtonContainerView()
    layoutFindPasswordButton()
    layoutSignupButton()
  }
  func layoutLogoImageView() {
    self.view.add(self.logoImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(87)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(98)
        $0.height.equalTo(106)
      }
    }
  }
  func layoutEmailLabel() {
    self.view.add(self.emailLabel) {
      $0.setupLabel(text: "이메일 아이디", color: .brown, font: UIFont.systemFont(ofSize: 16))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.logoImageView.snp.bottom).offset(65)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
      }
    }
  }
  func layoutEmailTextField() {
    self.view.add(self.emailTextField) {
      $0.placeholder = "yourname@example.com"
      $0.borderStyle = .line
      $0.borderColor = .brown
      $0.borderWidth = 1
      $0.textColor = .black
      $0.font = UIFont.systemFont(ofSize: 16)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailLabel.snp.bottom).offset(16)
        $0.leading.equalTo(self.emailLabel.snp.leading)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(32)
      }
    }
  }
  func layoutPasswordLabel() {
    self.view.add(self.passwordLabel) {
      $0.setupLabel(text: "비밀번호", color: .brown, font: UIFont.systemFont(ofSize: 16))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailTextField.snp.bottom).offset(32)
        $0.leading.equalTo(self.emailLabel.snp.leading)
      }
    }
  }
  func layoutPasswordTextField() {
    self.view.add(self.passwordTextField) {
      $0.placeholder = "yourpassword"
      $0.borderStyle = .line
      $0.borderColor = .brown
      $0.borderWidth = 1
      $0.textColor = .black
      $0.font = UIFont.systemFont(ofSize: 16)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.passwordLabel.snp.bottom).offset(16)
        $0.leading.equalTo(self.passwordLabel.snp.leading)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(32)
      }
    }
  }
  func layoutLoginButton() {
    self.view.add(self.loginButton) {
      $0.setTitle("로그인", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.setTitleColor(.white, for: .selected)
      $0.backgroundColor = .gray
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      $0.setRounded(radius: 24)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.passwordTextField.snp.bottom).offset(42)
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(78)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutButtonContainerView() {
    self.view.add(self.buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.loginButton.snp.bottom).offset(16)
        $0.width.equalTo(145)
        $0.height.equalTo(21)
      }
    }
  }
  func layoutFindPasswordButton() {
    self.buttonContainerView.add(self.findPasswordButton) {
      $0.setTitle("비밀번호 찾기", for: .normal)
      $0.setTitleColor(.gray, for: .normal)
      $0.backgroundColor = .clear
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.leading.equalTo(self.buttonContainerView.snp.leading)
        $0.width.equalTo(77)
      }
    }
  }
  func layoutSignupButton() {
    self.buttonContainerView.add(self.signupButton) {
      $0.setTitle("회원가입", for: .normal)
      $0.setTitleColor(.gray, for: .normal)
      $0.backgroundColor = .clear
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
        $0.width.equalTo(50)
      }
    }
  }
}
