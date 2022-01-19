//
//  ChangePasswordViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/11/24.
//

import UIKit
import SnapKit
import Moya
import RxMoya
import RxSwift
import SwiftKeychainWrapper
import Then

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
  let passwordBorderView = UIView()
  let passwordCheckLabel = UILabel()
  let passwordCheckTextField = UITextField()
  let passwordCheckBorderView = UIView()
  let changeButton = UIButton()
  
  // MARK: - Variables
  let disposeBag = DisposeBag()
  private let UserAuthProvider = MoyaProvider<UserAuthService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  let certificationNumber = KeychainWrapper.standard.integer(forKey: "cerificationNumber")
  var certifyFlag = false
  var checkPasswordFlag = false
  var userEmail = ""
  var userPassword = ""
  
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
  
  // MARK: - objc
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func certifyButtonClicked() {
    if self.certificationNumberTextField.hasText {
      let text = self.certificationNumberTextField.text ?? "0"
      let num = Int(text) ?? 0
      certifyNumber(number: num)
    }
  }
  @objc func changeButtonClicked() {
    print(checkPasswordFlag)
    print(certifyFlag)
    if certifyFlag == false {
      self.showGrayToast(message: "인증에 실패했습니다.")
    }
    if checkPasswordFlag == false {
      self.showGrayToast(message: "비밀번호가 일치하지 않습니다.")
    }
    if certifyFlag == true && checkPasswordFlag == true {
      // TODO: - 서버 통신
      changePassword(email: userEmail, password: userPassword)
    }
  }
  
  // MARK: - Helpers
  func attribute() {
    self.certificationNumberTextField.delegate = self
    self.passwordTextField.delegate = self
    self.passwordCheckTextField.delegate = self
  }
  func setTextField() {
    self.certificationNumberTextField.clearButtonMode = .whileEditing
    self.passwordTextField.clearButtonMode = .whileEditing
    self.passwordCheckTextField.clearButtonMode = .whileEditing
    self.passwordTextField.isSecureTextEntry = true
    self.passwordCheckTextField.isSecureTextEntry = true
  }
  func certifyNumber(number: Int) {
    self.view.endEditing(true)
    if number == certificationNumber {
      self.certifyFlag = true
      self.showGreenToast(message: "인증되었습니다.")
    }
    else {
      self.certifyFlag = false
      self.showGrayToast(message: "인증에 실패했습니다.")
    }
  }
  func checkPassword() {
    let pw = passwordTextField.text
    let pwCheck = passwordCheckTextField.text
    if pw == pwCheck {
      self.checkPasswordFlag = true
      self.userPassword = pw!
    }
  }
  func changePassword(email: String, password: String) {
    self.view.endEditing(true)
    UserAuthProvider.rx.request(.changePassword(email: email, password: password))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: false)
            loginVC.showGreenToast(message: "비밀번호가 변경되었습니다.")
          } catch {
            print(error)
          }
        } else {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(Response.self, from: response.data)
            if let message = data.message {
              self.showGrayToast(message: message)
            }
          } catch {
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - Layout Helpers
  func layout() {
    layoutNavigationBarView()
    layoutNavigationTitle()
    layoutBackButton()
    layoutExplationLabel()
    layoutCertificationNumberLabel()
    layoutCertifyButton()
    layoutCertificationNumberTextField()
    layoutCertificationNumberBorderView()
    layoutPasswordLabel()
    layoutPasswordTextField()
    layoutPasswordBorderView()
    layoutPasswordCheckLabel()
    layoutPasswordCheckTextField()
    layoutPasswordCheckBorderView()
    layoutChangeButton()
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
  func layoutCertificationNumberLabel() {
    self.view.add(self.certificationNumberLabel) {
      $0.setupLabel(text: "인증번호", color: .maincolor1, font: .notoSansKRMediumFont(fontSize: 16), align: .left)
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explationLabel.snp.bottom).offset(69)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutCertifyButton() {
    self.view.add(self.certifyButton) {
      $0.setupButton(title: "인증하기", color: .pointcolor1, font: .notoSansKRMediumFont(fontSize: 16), backgroundColor: .white, state: .normal, radius: 15)
      $0.setBorder(borderColor: .pointcolor1, borderWidth: 1)
      $0.titleLabel?.letterSpacing = -0.8
      $0.addTarget(self, action: #selector(self.certifyButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(96)
        $0.height.equalTo(32)
        $0.top.equalTo(self.certificationNumberLabel.snp.bottom).offset(16)
        $0.trailing.equalToSuperview().offset(-48)
      }
    }
  }
  func layoutCertificationNumberTextField() {
    self.view.add(self.certificationNumberTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "인증번호를 입력하세요.",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(23)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.trailing.equalTo(self.certifyButton.snp.leading).offset(-17)
        $0.top.equalTo(self.certificationNumberLabel.snp.bottom).offset(16)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutCertificationNumberBorderView() {
    self.view.add(self.certificationNumberBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.certificationNumberTextField.snp.bottom).offset(7)
        $0.leading.equalToSuperview().offset(48)
        $0.trailing.equalTo(self.certifyButton.snp.leading).offset(-17)
      }
    }
  }
  func layoutPasswordLabel() {
    self.view.add(self.passwordLabel) {
      $0.setupLabel(text: "비밀번호", color: .maincolor1, font: .notoSansKRMediumFont(fontSize: 16), align: .left)
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.certificationNumberBorderView.snp.bottom).offset(24)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutPasswordTextField() {
    self.view.add(self.passwordTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "새로운 비밀번호를 입력하세요.",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(23)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.passwordLabel.snp.bottom).offset(16)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutPasswordBorderView() {
    self.view.add(self.passwordBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.passwordTextField.snp.bottom).offset(7)
        $0.leading.equalToSuperview().offset(48)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutPasswordCheckLabel() {
    self.view.add(self.passwordCheckLabel) {
      $0.setupLabel(text: "비밀번호 확인", color: .maincolor1, font: .notoSansKRMediumFont(fontSize: 16), align: .left)
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.passwordBorderView.snp.bottom).offset(24)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutPasswordCheckTextField() {
    self.view.add(self.passwordCheckTextField) {
      $0.configureTextField(textColor: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.attributedPlaceholder = NSAttributedString(string: "새로운 비밀번호를 입력하세요.",
                                                    attributes: [NSAttributedString.Key.font: UIFont.notoSansKRRegularFont(fontSize: 16),
                                                                 NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.snp.makeConstraints {
        $0.height.equalTo(23)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.passwordCheckLabel.snp.bottom).offset(16)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutPasswordCheckBorderView() {
    self.view.add(self.passwordCheckBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.passwordCheckTextField.snp.bottom).offset(7)
        $0.leading.equalToSuperview().offset(48)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutChangeButton() {
    self.view.add(self.changeButton){
      $0.setupButton(title: "변경하기", color: .white, font: .notoSansKRRegularFont(fontSize: 16), backgroundColor: .gray3, state: .normal, radius: 25)
      $0.titleLabel?.letterSpacing = -0.48
      $0.addTarget(self, action: #selector(self.changeButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(78)
        $0.height.equalTo(49)
        $0.bottom.equalToSuperview().offset(-34)
      }
    }
  }
}

extension ChangePasswordViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
  }
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.changeButton.backgroundColor = .maincolor1
  }
}
