//
//  LoginViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import SnapKit
import Moya
import RxMoya
import RxSwift
import SwiftKeychainWrapper
import Then


// MARK: - LoginViewController
class LoginViewController: UIViewController {
  
  // MARK: - Components
  let logoImageView = UIImageView()
  let emailLabel = UILabel()
  let emailTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 2, bottom: 6, right: 2))
  let cancelEmailTextingButton = UIButton()
  let emailBorderView = UIView()
  let passwordLabel = UILabel()
  let passwordTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 2, bottom: 6, right: 2))
  let cancelPasswordTextingButton = UIButton()
  let passwordBorderView = UIView()
  let loginButton = UIButton()
  let buttonContainerView = UIView()
  let findPasswordButton = UIButton()
  let signupButton = UIButton()
  let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
  let disposeBag = DisposeBag()
  private let UserAuthProvider = MoyaProvider<UserAuthService>()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    layout()
    makeDelegate()
    keyboardObserver()
    textFieldEditingCheck()
    cancelButtonNotVisible()
  }
}

// MARK: - Extensions
extension LoginViewController {
  
  // MARK: - Helpers
  func layout() {
    layoutLogoImageView()
    layoutEmailLabel()
    layoutEmailTextField()
    layoutEmailCancelButton()
    layoutEmailBorderView()
    layoutPasswordLabel()
    layoutPasswordTextField()
    layoutPasswordCancleButton()
    layoutPasswordBorderView()
    layoutLoginButton()
    layoutButtonContainerView()
    layoutFindPasswordButton()
    layoutSignupButton()
  }
  func makeDelegate() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
  }
  func keyboardObserver(){
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  func cancelButtonNotVisible() {
    cancelEmailTextingButton.isHidden = true
    cancelPasswordTextingButton.isHidden = true
    loginButton.isEnabled = false
  }
  
  /// 로그인 서버 연결
  @objc func loginButtonClicked() {
    appDel.isLoginManually = true
    
    guard let emailText = emailTextField.text,
          let passwordText = passwordTextField.text else { return }
    UserAuthProvider.rx.request(.login(email: emailText, password: passwordText))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ResponseType<LoginData>.self,
                                          from: response.data)
            KeychainWrapper.standard.set(emailText, forKey: "loginEmail")
            KeychainWrapper.standard.set(passwordText, forKey: "loginPassword")
            KeychainWrapper.standard.set(data.loginData!.token, forKey: "userToken")
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        let mapVC = MapViewController()
        self.navigationController?.pushViewController(mapVC, animated: false)
      }).disposed(by: disposeBag)
  }
  
  @objc func signUpButtonClicked() {
    let dvc = SignUpViewController()
    self.navigationController?.pushViewController(dvc, animated: false)
//    self.showGrayToast(message: "안녕")
  }
  
  /// TextField 입력 체크하는 함수
  private func textFieldEditingCheck() {
    /// 텍스트가 입력중일 때 동작
    emailTextField.addTarget(self, action: #selector(emailTextIsEditing(_:)), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(passwordTextIsEditing(_:)), for: .editingChanged)
    
    /// 텍스트 입력 끝났을 때 동작
    emailTextField.addTarget(self, action: #selector(emailTextIsEndEditing(_:)), for: .editingDidEnd)
    passwordTextField.addTarget(self, action: #selector(passwordTextIsEndEditing(_:)), for: .editingDidEnd)
  }
  ///emailTextField가 입력중일 때
  @objc func emailTextIsEditing(_ TextLabel: UITextField) {
    /// emailTextfield에 텍스트가 입력되면
    if emailTextField.text!.count > 0 {
      //취소버튼을 보이게 한다
      cancelEmailTextingButton.isHidden = false
    }
    enableLoginButton()
  }
  ///pwTextField가 입력중일 때
  @objc func passwordTextIsEditing(_ TextLabel: UITextField) {
    /// pwTextfield에 텍스트가 입력되면
    if passwordTextField.text!.count > 0 {
      //취소버튼을 보이게 한다
      cancelPasswordTextingButton.isHidden = false
    }
    enableLoginButton()
  }
  ///emailTextField 입력 끝났을 때
  @objc func emailTextIsEndEditing(_ TextLabel: UITextField) {
    /// emailTextfield에 텍스트가 없으면
    if emailTextField.text!.count == 0 {
      //취소버튼을 숨긴다
      cancelEmailTextingButton.isHidden = true
    }
    enableLoginButton()
  }
  ///: - pwTextField 입력 끝났을 때
  @objc func passwordTextIsEndEditing(_ TextLabel: UITextField) {
    /// pwTextfield에 텍스트가 없으면
    if passwordTextField.text!.count == 0 {
      //취소버튼을 숨긴다
      cancelPasswordTextingButton.isHidden = true
    }
    enableLoginButton()
  }
  func enableLoginButton() {
    if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
      self.loginButton.isEnabled = true
      self.loginButton.backgroundColor = .pointcolor1
    }
  }
  func disableLoginButton() {
    if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
      self.loginButton.isEnabled = false
      self.loginButton.backgroundColor = .gray4
    }
  }
  /// 뷰의 다른 곳 탭하면 키보드 내려가게
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  @objc func emailCancelButtonClicked() {
    // emailTextField의 텍스트 전부를 지우고, 취소버튼을 사라지게 한다
    print("clickclick")
    emailTextField.text?.removeAll()
    cancelEmailTextingButton.isHidden = true
  }
  @objc func passwordCancelButtonClicked() {
    // pwTextField의 텍스트 전부를 지우고, 취소버튼을 사라지게 한다
    passwordTextField.text?.removeAll()
    cancelPasswordTextingButton.isHidden = true
  }
  
  // MARK: - Layout Helpers
  func layoutLogoImageView() {
    self.view.add(self.logoImageView) {
      $0.image = UIImage(named: "loginLogo")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(83)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(98)
        $0.height.equalTo(106)
      }
    }
  }
  func layoutEmailLabel() {
    self.view.add(self.emailLabel) {
      $0.setupLabel(text: "이메일 아이디", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.logoImageView.snp.bottom).offset(84)
        $0.leading.equalTo(self.view.snp.leading).offset(48)
      }
    }
  }
  func layoutEmailTextField() {
    self.view.add(self.emailTextField) {
      $0.attributedPlaceholder = NSAttributedString(string: "yourname@example.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.textColor = .black
      $0.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailLabel.snp.bottom).offset(10)
        $0.leading.equalTo(self.emailLabel.snp.leading)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-49)
        $0.height.equalTo(35)
      }
    }
  }
  func layoutEmailCancelButton() {
    self.emailTextField.add(self.cancelEmailTextingButton) {
      $0.setImage(UIImage(named: "iconDelete1616"), for: .normal)
      $0.addTarget(self, action: #selector(self.emailCancelButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.trailing.equalTo(self.emailTextField.snp.trailing)
        $0.bottom.equalTo(self.emailTextField.snp.bottom).offset(-2)
      }
    }
  }
  func layoutEmailBorderView() {
    self.view.add(self.emailBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.width.equalTo(278)
        $0.top.equalTo(self.emailTextField.snp.bottom).offset(1)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutPasswordLabel() {
    self.view.add(self.passwordLabel) {
      $0.setupLabel(text: "비밀번호", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.emailBorderView.snp.bottom).offset(32)
        $0.leading.equalTo(self.emailLabel.snp.leading)
      }
    }
  }
  func layoutPasswordTextField() {
    self.view.add(self.passwordTextField) {
      $0.attributedPlaceholder = NSAttributedString(string: "yourpassword", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray3])
      $0.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.isSecureTextEntry = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
        $0.leading.equalTo(self.passwordLabel.snp.leading)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-49)
        $0.height.equalTo(32)
      }
    }
  }
  func layoutPasswordCancleButton() {
    self.passwordTextField.add(self.cancelPasswordTextingButton) {
      $0.setImage(UIImage(named: "iconDelete1616"), for: .normal)
      $0.addTarget(self, action: #selector(self.passwordCancelButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.trailing.equalTo(self.passwordTextField.snp.trailing)
        $0.bottom.equalTo(self.passwordTextField.snp.bottom).offset(-2)
      }
    }
  }
  func layoutPasswordBorderView() {
    self.view.add(self.passwordBorderView) {
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.width.equalTo(278)
        $0.top.equalTo(self.passwordTextField.snp.bottom).offset(1)
        $0.leading.equalToSuperview().offset(48)
      }
    }
  }
  func layoutLoginButton() {
    self.view.add(self.loginButton) {
      $0.setTitle("로그인", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.setTitleColor(.white, for: .selected)
      $0.titleLabel?.letterSpacing = -0.48
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.backgroundColor = .gray3
      $0.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.passwordBorderView.snp.bottom).offset(42)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(219)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutButtonContainerView() {
    self.view.add(self.buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.loginButton.snp.bottom).offset(13)
        $0.width.equalTo(175)
        $0.height.equalTo(30)
      }
    }
  }
  func layoutFindPasswordButton() {
    self.buttonContainerView.add(self.findPasswordButton) {
      $0.setupButton(title: "비밀번호 찾기", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
      $0.titleLabel?.letterSpacing = -0.7
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.leading.equalTo(self.buttonContainerView.snp.leading)
        $0.width.equalTo(95)
      }
    }
  }
  func layoutSignupButton() {
    self.buttonContainerView.add(self.signupButton) {
      $0.setupButton(title: "회원가입", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
      $0.titleLabel?.letterSpacing = -0.7
      $0.addTarget(self, action: #selector(self.signUpButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
        $0.width.equalTo(80)
      }
    }
  }
}
//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  
  @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
    self.emailTextField.resignFirstResponder()
    self.passwordTextField.resignFirstResponder()
  }
  
  // 키보드 return 눌렀을 때 Action
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      emailTextField.becomeFirstResponder()
    }
    textField.resignFirstResponder()
    return true
  }
  
  @objc func keyboardWillShow(_ notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      UIView.animate(withDuration: 0.3, animations: { self.view.transform = CGAffineTransform(translationX: 0, y: -50) })
    }
  }
  @objc func keyboardWillDisappear(_ notification: NSNotification){
    self.view.transform = .identity
  }
}
