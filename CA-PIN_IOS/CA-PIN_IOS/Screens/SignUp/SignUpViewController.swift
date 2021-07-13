//
//  SignUpViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/02.
//

import UIKit

import SnapKit
import Then

// MARK: - SignUpViewController
class SignUpViewController: UIViewController {
  
  // MARK: - Components
  let navigationBarView = UIView()
  let backButton = UIButton()
  let navigationTitleLabel = UILabel()
  let userNameLabel = UILabel()
  let userNameTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
  let nameBorderView = UIView()
  let userNameExplanationLabel = UILabel()
  let emailLabel = UILabel()
  let emailTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
  let emailBorderView = UIView()
  let emailExplanationLabel = UILabel()
  let passwordLabel = UILabel()
  let passwordTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
  let passwordBorderView = UIView()
  let checkPasswordLabel = UILabel()
  let checkPasswordTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
  let checkPasswordBordrView = UIView()
  let signUpButton = UIButton()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    layout()
  }
}

//MARK: - Extensions
extension SignUpViewController {
  
  //MARK: - Layout Helper
  func layout() {
    layoutNavigationBarView()
    layoutNavigationTitle()
    layoutBackButton()
    layoutUserNameLabel()
    layoutUserNameTextField()
    layoutUserNameBorderView()
    layoutUserNameExplanationLabel()
    layoutEmailLabel()
    layoutEmailTextField()
    layoutEmailBorderView()
    layoutEmailExplanationLabel()
    layoutPasswordLabel()
    layoutPasswordTextField()
    layoutPasswordBorderView()
    layoutCheckPasswordLabel()
    layoutCheckPasswordTextField()
    layoutCheckPasswordBorderView()
    layoutSignUpButton()
  }
  
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func signUpButtonClicked() {
    // TODO: - 회원가입 서버 연결
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
      $0.setupLabel(text: "회원가입", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20), align: .center)
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
  func layoutUserNameLabel() {
    self.view.add(self.userNameLabel) {
      $0.setupLabel(text: "사용자 이름", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.navigationBarView.snp.bottom).offset(99)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutUserNameTextField() {
    self.view.add(self.userNameTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "사용할 이름을 입력하세요",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(37)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.top.equalTo(self.userNameLabel.snp.bottom).offset(10)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutUserNameBorderView() {
    self.view.add(self.nameBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.userNameTextField.snp.bottom).offset(1)
        $0.leading.equalToSuperview().offset(48)
        $0.trailing.equalToSuperview().offset(-48)
      }
    }
  }
  func layoutUserNameExplanationLabel() {
    self.view.add(self.userNameExplanationLabel) {
      $0.setupLabel(text: "2~10자 이내의 한글, 영문, 숫자 사용가능", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.height.equalTo(17)
        $0.top.equalTo(self.nameBorderView.snp.bottom).offset(8)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
      }
    }
  }
  func layoutEmailLabel() {
    self.view.add(self.emailLabel) {
      $0.setupLabel(text: "이메일 아이디", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.userNameExplanationLabel.snp.bottom).offset(32)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutEmailTextField() {
    self.view.add(self.emailTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "이메일을 입력하세요.",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(37)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.top.equalTo(self.emailLabel.snp.bottom).offset(10)
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
        $0.trailing.equalToSuperview().offset(-48)
      }
    }
  }
  func layoutEmailExplanationLabel() {
    self.view.add(self.emailExplanationLabel) {
      $0.numberOfLines = 0
      $0.lineBreakMode = .byWordWrapping
      $0.sizeToFit()
      $0.setupLabel(text: "비밀번호를 잊어버렸을 때 회원가입 시 입력한 이메일로 임시 비밀번호를 보내드립니다.", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailBorderView.snp.bottom).offset(8)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-49)
      }
    }
  }
  func layoutPasswordLabel() {
    self.view.add(self.passwordLabel) {
      $0.setupLabel(text: "비밀번호", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailExplanationLabel.snp.bottom).offset(32)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutPasswordTextField() {
    self.view.add(self.passwordTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요.",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(37)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutPasswordBorderView() {
    self.view.add(self.passwordBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.passwordTextField.snp.bottom).offset(1)
        $0.leading.equalToSuperview().offset(48)
        $0.trailing.equalToSuperview().offset(-48)
      }
    }
  }
  func layoutCheckPasswordLabel() {
    self.view.add(self.checkPasswordLabel) {
      $0.setupLabel(text: "비밀번호 확인", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.passwordBorderView.snp.bottom).offset(32)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutCheckPasswordTextField() {
    self.view.add(self.checkPasswordTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한번 더 입력하세요",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(37)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.top.equalTo(self.checkPasswordLabel.snp.bottom).offset(10)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCheckPasswordBorderView() {
    self.view.add(self.checkPasswordBordrView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.checkPasswordTextField.snp.bottom).offset(1)
        $0.leading.equalToSuperview().offset(48)
        $0.trailing.equalToSuperview().offset(-48)
      }
    }
  }
  func layoutSignUpButton() {
    self.view.add(self.signUpButton) {
      $0.setTitle("가입하기", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.setTitleColor(.white, for: .selected)
      $0.backgroundColor = .gray
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
      $0.setupButton(title: "가입하기", color: UIColor.white, font: UIFont.notoSansKRRegularFont(fontSize: 16), backgroundColor: .gray3, state: .normal
                     , radius: 25)
      $0.setupButton(title: "가입하기", color: UIColor.white, font: UIFont.notoSansKRRegularFont(fontSize: 16), backgroundColor: .pointcolor1, state: .selected
                     , radius: 25)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(78)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-78)
        $0.bottom.equalTo(self.view.snp.bottom).offset(-34)
        $0.height.equalTo(49)
      }
    }
  }
}
