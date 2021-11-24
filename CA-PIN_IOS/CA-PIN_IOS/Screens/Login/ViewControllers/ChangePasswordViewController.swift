//
//  ChangePasswordViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/11/24.
//

import UIKit

// MARK: - ChangePasswordViewController
class ChangePasswordViewController: UIViewController {
  
  // MARK: - Components
  let navigationBarView = UIView()
  let backButton = UIButton()
  let navigationTitleLabel = UILabel()
  let explationLabel = UILabel()
  let certificationNumberLabel = UILabel()
  let certificationNumberTextField = UITextField()
  let certificationNumberBorderView = UIView()
  let certifyButton = UIButton()
  let passwordLabel = UILabel()
  let passwordTextField = UITextField()
  let checkPasswordLabel = UILabel()
  let checkPasswordTextField = UITextField()
  let changeButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    attribute()
    setTextField()
    layout()
    // Do any additional setup after loading the view.
  }
}

extension ChangePasswordViewController {
  func attribute() {
    self.certificationNumberTextField.delegate = self
    self.passwordTextField.delegate = self
    self.checkPasswordTextField.delegate = self
  }
  func setTextField() {
    self.certificationNumberTextField.clearButtonMode = .whileEditing
    self.passwordTextField.clearButtonMode = .whileEditing
    self.checkPasswordTextField.clearButtonMode = .whileEditing
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  func layout() {
    layoutNavigationBarView()
    layoutNavigationTitle()
    layoutBackButton()
    layoutExplationLabel()
    
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
      $0.setupLabel(text: "인증번호를 입력하고,\n새로운 비밀번호를 설정하세요.", color: .gray4, font: .notoSansKRMediumFont(fontSize: 16), align: .center)
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.navigationBarView.snp.bottom).offset(70)
      }
    }
  }
}

extension ChangePasswordViewController: UITextFieldDelegate {
  
}
