////
////  LoginViewController.swift
////  CA-PIN_IOS
////
////  Created by λΈνμ on 2021/06/30.
////
//
//import UIKit
//
//import SnapKit
//import Moya
//import Moya
//import RxSwift
//import SwiftKeychainWrapper
//import Then
//
//
//// MARK: - LoginViewController
//class LoginViewController: UIViewController {
//
//  // MARK: - Components
//  let logoImageView = UIImageView()
//  let emailLabel = UILabel()
//  let emailTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 2, bottom: 6, right: 2))
//  let emailBorderView = UIView()
//  let passwordLabel = UILabel()
//  let passwordTextField = fourInsetTextField.textFieldWithInsets(insets: UIEdgeInsets(top: 6, left: 2, bottom: 6, right: 2))
//  let passwordBorderView = UIView()
//  let loginButton = UIButton()
//  let buttonContainerView = UIView()
//  let findPasswordButton = UIButton()
//  let signupButton = UIButton()
//let testLabel = UILabel()
//  let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
//
//  let disposeBag = DisposeBag()
//  private let UserAuthProvider = MoyaProvider<UserAuthService>(plugins: [NetworkLoggerPlugin(verbose: true)])
//
//  // MARK: - LifeCycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    self.view.backgroundColor = .white
//    self.navigationController?.navigationBar.isHidden = true
//    KeychainWrapper.standard.set(1, forKey: "loginVCFlag")
//    layout()
//    setTextField()
//    keyboardObserver()
//      addAction()
//  }
//
//  override func viewWillAppear(_ animated: Bool) {
//    self.emailTextField.text = ""
//    self.passwordTextField.text = ""
//    disableLoginButton()
//  }
//}
//
//// MARK: - Extensions
//extension LoginViewController {
//  func setTextField() {
//    self.emailTextField.clearButtonMode = .whileEditing
//    self.passwordTextField.clearButtonMode = .whileEditing
//    self.emailTextField.keyboardType = .emailAddress
//    self.passwordTextField.isSecureTextEntry = true
//    self.emailTextField.delegate = self
//    self.passwordTextField.delegate = self
//  }
//
//  // MARK: - Helpers
//  func layout() {
//    layoutLogoImageView()
//    layoutEmailLabel()
//    layoutEmailTextField()
//    layoutEmailBorderView()
//    layoutPasswordLabel()
//    layoutPasswordTextField()
//    layoutPasswordBorderView()
//    layoutLoginButton()
//    layoutButtonContainerView()
//    layoutFindPasswordButton()
//    layoutSignupButton()
//      layoutTestLabel()
//  }
//  func keyboardObserver(){
//    NotificationCenter.default.addObserver(self,
//                                           selector: #selector(keyboardWillShow(_:)),
//                                           name: UIResponder.keyboardWillShowNotification,
//                                           object: nil)
//
//    NotificationCenter.default.addObserver(self,
//                                           selector: #selector(keyboardWillDisappear(_:)),
//                                           name: UIResponder.keyboardWillHideNotification,
//                                           object: nil)
//  }
//
//  /// λ‘κ·ΈμΈ μλ² μ°κ²°
//  @objc func loginButtonClicked() {
//    appDel.isLoginManually = true
//
//    self.view.endEditing(true)
//
//    guard let emailText = emailTextField.text,
//          let passwordText = passwordTextField.text else { return }
//    UserAuthProvider.rx.request(.login(email: emailText, password: passwordText))
//      .asObservable()
//      .subscribe(onNext: { response in
//        if response.statusCode == 200 {
//          do {
//            let decoder = JSONDecoder()
//            let data = try decoder.decode(ResponseType<LoginData>.self,
//                                          from: response.data)
//              if let loginData = data.loginData {
//                  KeychainWrapper.standard.set(loginData.nickname, forKey: "nickname")
//              }
//            KeychainWrapper.standard.set(emailText, forKey: "loginEmail")
//            KeychainWrapper.standard.set(passwordText, forKey: "loginPassword")
//            KeychainWrapper.standard.set(data.loginData!.tokenAccess, forKey: "tokenAccess")
//            print("tokenAccess: \(data.loginData!.tokenAccess)")
//              KeychainWrapper.standard.set(data.loginData!.tokenRefresh, forKey: "tokenRefresh")
//
//            let cafeTI = KeychainWrapper.standard.string(forKey: "userCafeTI")
//            if cafeTI != nil {
//              let mapVC = MapViewController()
//              self.emailTextField.text = ""
//              self.passwordTextField.text = ""
//              self.navigationController?.pushViewController(mapVC, animated: false)
//            }
//            else {
//              let cafeTIVC = CafeTIViewController()
//              self.emailTextField.text = ""
//              self.passwordTextField.text = ""
//              self.navigationController?.pushViewController(cafeTIVC, animated: false)
//            }
//
////             μ§μμ½λ
////            let myPageVC = CafeTIViewController()
////            self.navigationController?.pushViewController(myPageVC, animated: false)
//
//          } catch {
//            print(error)
//          }
//        }
//          else if response.statusCode == 404 {
//              do {
//                  let decoder = JSONDecoder()
//                  let data = try decoder.decode(ResponseType<LoginModel>.self,
//                                                from: response.data)
//                  self.testLabel.isHidden = false
//                  self.testLabel.setupLabel(text: data.message ?? "λ‘κ·ΈμΈ μλ¬", color: .red, font: .notoSansKRRegularFont(fontSize: 15))
//              }
//              catch {
//
//              }
//          }
//          else {
//          do {
//            let decoder = JSONDecoder()
//            let data = try decoder.decode(ResponseType<LoginModel>.self,
//                                          from: response.data)
//            self.showGrayToast(message: data.message!)
//
//          } catch {
//
//          }
//        }
//      }, onError: { error in
//        print(error)
//      }, onCompleted: {
//      }).disposed(by: disposeBag)
//  }
//  @objc func findPasswordButtonClicked() {
//    let findVC = FindPasswordViewController()
//    self.navigationController?.pushViewController(findVC, animated: false)
//  }
//  @objc func signUpButtonClicked() {
//    let signUpVC = SignUpViewController()
//    self.navigationController?.pushViewController(signUpVC, animated: false)
//  }
//
//  func enableLoginButton() {
//    if emailTextField.text?.isEmpty == false || passwordTextField.text?.isEmpty == false {
//      self.loginButton.isUserInteractionEnabled = true
//      self.loginButton.backgroundColor = .pointcolor1
//    }
//  }
//  func disableLoginButton() {
//    if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
//      self.loginButton.isUserInteractionEnabled = false
//      self.loginButton.backgroundColor = .gray3
//    }
//  }
//
//    private func addAction() {
//        let gesture = UITapGestureRecognizer()
//        gesture.addTarget(self, action: #selector(self.loginButtonClicked))
//        loginButton.addGestureRecognizer(gesture)
//    }
//
//    private func validate() {
//        if passwordTextField.hasText && emailTextField.hasText {
//            loginButton.isUserInteractionEnabled = true
//            loginButton.backgroundColor = .pointcolor1
//        }
//        else {
//            self.loginButton.isUserInteractionEnabled = false
//            self.loginButton.backgroundColor = .gray3
//        }
//    }
//  /// λ·°μ λ€λ₯Έ κ³³ ν­νλ©΄ ν€λ³΄λ λ΄λ €κ°κ²
//  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    self.view.endEditing(true)
//  }
//
//  // MARK: - Layout Helpers
//  func layoutLogoImageView() {
//    self.view.add(self.logoImageView) {
//      $0.image = UIImage(named: "capinLogo")
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(83)
//        $0.centerX.equalToSuperview()
//        $0.width.equalTo(82)
//        $0.height.equalTo(127.2)
//      }
//    }
//  }
//    private func layoutTestLabel() {
//        self.view.add(testLabel) {
//            $0.isHidden = true
//            $0.snp.makeConstraints {
//                $0.centerX.equalToSuperview()
//                $0.top.equalTo(self.signupButton.snp.bottom).offset(15)
//            }
//        }
//    }
//  func layoutEmailLabel() {
//    self.view.add(self.emailLabel) {
//      $0.setupLabel(text: "μ΄λ©μΌ μμ΄λ",
//                    color: .maincolor1,
//                    font: UIFont.notoSansKRMediumFont(fontSize: 16))
//      $0.letterSpacing = -0.8
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.logoImageView.snp.bottom).offset(84)
//        $0.leading.equalTo(self.view.snp.leading).offset(48)
//      }
//    }
//  }
//  func layoutEmailTextField() {
//    self.view.add(self.emailTextField) {
//      $0.attributedPlaceholder = NSAttributedString(
//        string: "yourname@example.com",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray3])
//      $0.textColor = .black
//      $0.font = UIFont.notoSansKRRegularFont(fontSize: 16)
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.emailLabel.snp.bottom).offset(10)
//        $0.leading.equalTo(self.view.snp.leading).offset(48)
//        $0.centerX.equalToSuperview()
//        $0.height.equalTo(35)
//      }
//    }
//  }
//  func layoutEmailBorderView() {
//    self.view.add(self.emailBorderView) {
//      $0.backgroundColor = .pointcolor1
//      $0.snp.makeConstraints {
//        $0.height.equalTo(1)
//        $0.top.equalTo(self.emailTextField.snp.bottom).offset(1)
//        $0.leading.equalToSuperview().offset(48)
//        $0.trailing.equalToSuperview().offset(-48)
//      }
//    }
//  }
//  func layoutPasswordLabel() {
//    self.view.add(self.passwordLabel) {
//      $0.setupLabel(text: "λΉλ°λ²νΈ", color: .maincolor1, font: UIFont.notoSansKRMediumFont(fontSize: 16))
//      $0.letterSpacing = -0.8
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.emailBorderView.snp.bottom).offset(32)
//        $0.leading.equalTo(self.emailLabel.snp.leading)
//      }
//    }
//  }
//  func layoutPasswordTextField() {
//    self.view.add(self.passwordTextField) {
//      $0.attributedPlaceholder = NSAttributedString(
//        string: "yourpassword",
//        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray3])
//      $0.font = UIFont.notoSansKRRegularFont(fontSize: 16)
//      $0.isSecureTextEntry = true
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.passwordLabel.snp.bottom).offset(10)
//        $0.leading.equalTo(self.view.snp.leading).offset(48)
//        $0.centerX.equalToSuperview()
//        $0.height.equalTo(35)
//      }
//    }
//  }
//  func layoutPasswordBorderView() {
//    self.view.add(self.passwordBorderView) {
//      $0.backgroundColor = .pointcolor1
//      $0.snp.makeConstraints {
//        $0.height.equalTo(1)
//        $0.top.equalTo(self.passwordTextField.snp.bottom).offset(1)
//        $0.leading.equalToSuperview().offset(48)
//        $0.trailing.equalToSuperview().offset(-48)
//      }
//    }
//  }
//  func layoutLoginButton() {
//    self.view.add(self.loginButton) {
//      $0.setTitle("λ‘κ·ΈμΈ", for: .normal)
//      $0.setTitleColor(.white, for: .normal)
//      $0.setTitleColor(.white, for: .selected)
//      $0.titleLabel?.letterSpacing = -0.48
//      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
//      $0.backgroundColor = .gray3
//      $0.setRounded(radius: 24.5)
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.passwordBorderView.snp.bottom).offset(42)
//        $0.centerX.equalToSuperview()
//        $0.width.equalTo(219)
//        $0.height.equalTo(49)
//      }
//    }
//  }
//  func layoutButtonContainerView() {
//    self.view.add(self.buttonContainerView) {
//      $0.backgroundColor = .clear
//      $0.snp.makeConstraints {
//        $0.centerX.equalToSuperview()
//        $0.top.equalTo(self.loginButton.snp.bottom).offset(13)
//        $0.width.equalTo(175)
//        $0.height.equalTo(30)
//      }
//    }
//  }
//  func layoutFindPasswordButton() {
//    self.buttonContainerView.add(self.findPasswordButton) {
//      $0.setupButton(title: "λΉλ°λ²νΈ μ°ΎκΈ°", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
//      $0.titleLabel?.letterSpacing = -0.7
//      $0.addTarget(self, action: #selector(self.findPasswordButtonClicked), for: .touchUpInside)
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.buttonContainerView.snp.top)
//        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
//        $0.leading.equalTo(self.buttonContainerView.snp.leading)
//        $0.width.equalTo(95)
//      }
//    }
//  }
//  func layoutSignupButton() {
//    self.buttonContainerView.add(self.signupButton) {
//      $0.setupButton(title: "νμκ°μ", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
//      $0.titleLabel?.letterSpacing = -0.7
//      $0.addTarget(self, action: #selector(self.signUpButtonClicked), for: .touchUpInside)
//      $0.snp.makeConstraints {
//        $0.top.equalTo(self.buttonContainerView.snp.top)
//        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
//        $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
//        $0.width.equalTo(80)
//      }
//    }
//  }
//}
////MARK: - UITextFieldDelegate
//extension LoginViewController: UITextFieldDelegate {
//
//  func textFieldDidEndEditing(_ textField: UITextField) {
//      validate()
//  }
//
//  func textFieldDidBeginEditing(_ textField: UITextField) {
//
//  }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == passwordTextField && passwordTextField.hasText {
//            enableLoginButton()
//        }
//        return true
//    }
//
//  @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
//    self.emailTextField.resignFirstResponder()
//    self.passwordTextField.resignFirstResponder()
//  }
//
//  // ν€λ³΄λ return λλ μ λ Action
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    if textField == emailTextField {
//      passwordTextField.becomeFirstResponder()
//    }
//    textField.resignFirstResponder()
//    return true
//  }
//
//  @objc func keyboardWillShow(_ notification: NSNotification) {
//    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//      UIView.animate(withDuration: 0.3, animations: { self.view.transform = CGAffineTransform(translationX: 0, y: -50) })
//    }
//  }
//  @objc func keyboardWillDisappear(_ notification: NSNotification) {
//    self.view.transform = .identity
//  }
//}
