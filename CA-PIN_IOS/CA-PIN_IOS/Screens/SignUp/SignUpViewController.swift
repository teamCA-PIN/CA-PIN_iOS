//
//  SignUpViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/02.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper
import Moya
import RxMoya
import RxSwift
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
  
  let disposeBag = DisposeBag()
  private let UserAuthProvider = MoyaProvider<UserAuthService>()
  var isSame: Bool = false
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    layout()
    attribute()
    setTextField()
    keyboardObserver()
    self.signUpButton.isEnabled = false
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
  func attribute() {
    self.userNameTextField.delegate = self
    self.emailTextField.delegate = self
    self.passwordTextField.delegate = self
    self.checkPasswordTextField.delegate = self
  }
  func setTextField() {
    self.userNameTextField.clearButtonMode = .whileEditing
    self.emailTextField.clearButtonMode = .whileEditing
    self.passwordTextField.clearButtonMode = .whileEditing
    self.checkPasswordTextField.clearButtonMode = .whileEditing
    self.passwordTextField.isSecureTextEntry = true
    self.checkPasswordTextField.isSecureTextEntry = true
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func signUpButtonClicked() {
    guard let nicknameText = userNameTextField.text,
          let emailText = emailTextField.text,
          let passwordText = passwordTextField.text else { return }
    UserAuthProvider.rx.request(.signup(email: emailText, password: passwordText, nickname: nicknameText))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 201 { /// 회원가입 성공
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(Response.self, from: response.data)
            let loginVC = self.navigationController?.children[0]
            self.navigationController?.popViewController(animated: false, completion: {
              loginVC?.showGreenToast(message: "가입이 완료되었습니다.")
            })
          }
          catch {
            print(error)
          }
        }
        else { /// 회원가입 실패 -> 분기처리
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(Response.self, from: response.data)
            switch data.message {
            case "필요한 값이 없습니다.":
              self.showGrayToast(message: "필요한 값이 입력되지 않았습니다")
              break
            case "이미 존재하는 이메일 입니다.":
              self.showGrayToast(message: "이미 사용중인 이메일입니다.")
              break
            case "존재하는 닉네임 입니다.":
              self.showGrayToast(message: "이미 사용중인 이름입니다.")
              break
            case .none:
              break
            case .some(_):
              break
            }
          }
          catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  func enableSignupButton() {
    /// 텍스트필드 값이 모두 채워져있고, 비밀번호 두개가 일치할 때 enable
    let isNameEmpty = userNameTextField.text?.isEmpty
    let isEmailEmpty = emailTextField.text?.isEmpty
    let isPasswordEmpty = passwordTextField.text?.isEmpty
    let isCheckPasswordEmpty = checkPasswordTextField.text?.isEmpty
    
    if (isNameEmpty == false) && (isEmailEmpty == false) && (isPasswordEmpty == false) && (isCheckPasswordEmpty == false) && (isSame == true) {
      signUpButton.isEnabled = true
      self.signUpButton.backgroundColor = UIColor.pointcolor1
    }
  }
  
  func keyboardObserver(){
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
      $0.addTarget(self, action: #selector(self.signUpButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(78)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-78)
        $0.bottom.equalTo(self.view.snp.bottom).offset(-100)
        $0.height.equalTo(49)
      }
    }
  }
  
  /// 뷰의 다른 곳 탭하면 키보드 내려가게
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

extension SignUpViewController: UITextFieldDelegate {
  @objc func keyboardWillShow(_ notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      UIView.animate(withDuration: 0.3, animations: {
        self.userNameLabel.snp.updateConstraints {
          $0.top.equalTo(self.navigationBarView.snp.bottom).offset(20)
        }
        self.userNameTextField.snp.updateConstraints {
          $0.top.equalTo(self.userNameLabel.snp.bottom).offset(5)
        }
        self.emailLabel.snp.updateConstraints {
          $0.top.equalTo(self.userNameExplanationLabel.snp.bottom).offset(16)
        }
        self.emailTextField.snp.updateConstraints {
          $0.top.equalTo(self.emailLabel.snp.bottom).offset(5)
        }
        self.passwordLabel.snp.updateConstraints {
          $0.top.equalTo(self.emailExplanationLabel.snp.bottom).offset(16)
        }
        self.passwordTextField.snp.updateConstraints {
          $0.top.equalTo(self.passwordLabel.snp.bottom).offset(5)
        }
        self.checkPasswordLabel.snp.updateConstraints {
          $0.top.equalTo(self.passwordBorderView.snp.bottom).offset(16)
        }
        self.checkPasswordTextField.snp.updateConstraints {
          $0.top.equalTo(self.checkPasswordLabel.snp.bottom).offset(5)
        }
      })
    }
  }
  @objc func keyboardWillDisappear(_ notification: NSNotification){
    self.userNameLabel.snp.updateConstraints {
      $0.top.equalTo(self.navigationBarView.snp.bottom).offset(99)
    }
    self.userNameTextField.snp.updateConstraints {
      $0.top.equalTo(self.userNameLabel.snp.bottom).offset(10)
    }
    self.emailLabel.snp.updateConstraints {
      $0.top.equalTo(self.userNameExplanationLabel.snp.bottom).offset(32)
    }
    self.emailTextField.snp.updateConstraints {
      $0.top.equalTo(self.emailLabel.snp.bottom).offset(10)
    }
    self.passwordLabel.snp.updateConstraints {
      $0.top.equalTo(self.emailExplanationLabel.snp.bottom).offset(32)
    }
    self.passwordTextField.snp.updateConstraints {
      $0.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
    }
    self.checkPasswordLabel.snp.updateConstraints {
      $0.top.equalTo(self.passwordBorderView.snp.bottom).offset(32)
    }
    self.checkPasswordTextField.snp.updateConstraints {
      $0.top.equalTo(self.checkPasswordLabel.snp.bottom).offset(10)
    }
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    switch textField {
    case userNameTextField:
      enableSignupButton()
    case emailTextField:
      enableSignupButton()
    case passwordTextField:
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      enableSignupButton()
    case checkPasswordTextField:
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      guard let passwordText = passwordTextField.text,
            let checkPasswordText = checkPasswordTextField.text else { return }
      if passwordText != checkPasswordText {
        isSame = false
        self.showGrayToast(message: "비밀번호가 일치하지 않습니다.")
      }
      else {
        isSame = true
      }
      enableSignupButton()
    default: break
    }
  }

  /// Return 눌렀을 때 키보드 내리기
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
  }
}
