//
//  NewLoginViewController.swift
//  CA-PIN_IOS
//
//  Created by hansol on 2022/01/25.
//

import UIKit

import Moya
import RxSwift
import SnapKit
import SwiftKeychainWrapper
import Then

// MARK: - NewLoginViewController

final class LoginViewController: UIViewController {
    
    // MARK: - Components
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "capinLogo")
    }
    
    private let emailTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "이메일 아이디",
            color: .maincolor1,
            font: .notoSansKRMediumFont(fontSize: 16)
        )
    }
    
    private let emailTextField = UITextField().then {
        $0.keyboardType = .emailAddress
        $0.clearButtonMode = .whileEditing
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.font = .notoSansKRRegularFont(fontSize: 16)
        $0.textColor = .black
    }
    
    private let emailBottomLineView = UIView().then {
        $0.backgroundColor = .pointcolor1
    }
    
    private let passwordTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "비밀번호",
            color: .maincolor1,
            font: .notoSansKRMediumFont(fontSize: 16)
        )
    }
    
    private let passwordTextField = UITextField().then {
        $0.clearButtonMode = .whileEditing
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
        $0.font = .notoSansKRRegularFont(fontSize: 16)
        $0.textColor = .black
    }
    
    private let passwordBottomLineView = UIView().then {
        $0.backgroundColor = .pointcolor1
    }
    
    private let loginButton = UIButton().then {
        $0.setupButton(
            title: "로그인",
            color: .white,
            font: .notoSansKRRegularFont(fontSize: 16),
            backgroundColor: .gray3,
            state: .normal,
            radius: 24.5
        )
        $0.isUserInteractionEnabled = false
        $0.addTarget(self, action: #selector(touchupLoginButton), for: .touchUpInside)
    }
    
    private let findPasswordButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchupFindPasswordButton), for: .touchUpInside)
    }
    
    private let signupButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchupSignupButton), for: .touchUpInside)
    }
    
    private let testLabel = UILabel().then {
        $0.isHidden = true
    }
    
    // MARK: - Variables
    
    private let userAuthProvider = MoyaProvider<UserAuthService>(
        plugins: [
            NetworkLoggerPlugin(verbose: true)
        ]
    )
    
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        layout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Extensions

extension LoginViewController {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        view.backgroundColor = .white
        view.adds(
            [
                logoImageView,
                emailTitleLabel,
                emailTextField,
                emailBottomLineView,
                passwordTitleLabel,
                passwordTextField,
                passwordBottomLineView,
                loginButton,
                findPasswordButton,
                signupButton,
                testLabel
            ]
        )
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(121)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(82)
            $0.height.equalTo(127.2)
        }
        
        emailTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(68.8)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(48)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.emailTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.emailTitleLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        emailBottomLineView.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(7)
            $0.leading.trailing.equalTo(self.emailTextField)
            $0.height.equalTo(1)
        }
        
        passwordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.emailBottomLineView.snp.bottom).offset(32)
            $0.leading.equalTo(self.emailTitleLabel)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(self.passwordTitleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.emailTitleLabel)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        passwordBottomLineView.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(7)
            $0.leading.trailing.equalTo(self.emailTextField)
            $0.height.equalTo(1)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(self.passwordBottomLineView.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(219)
            $0.height.equalTo(49)
        }
        
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(self.loginButton.snp.bottom).offset(13)
            $0.leading.equalTo(self.loginButton).offset(22)
            $0.width.equalTo(95)
            $0.height.equalTo(30)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(self.findPasswordButton)
            $0.trailing.equalTo(self.loginButton).offset(-22)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        testLabel.snp.makeConstraints {
            $0.top.equalTo(self.findPasswordButton.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - General Helpers
    
    private func config() {
        KeychainWrapper.standard.set(1, forKey: "loginVCFlag")
        configButtonTitle()
        configPlaceholder()
        configDelegate()
        addKeyboardObserver()
    }
    
    private func configButtonTitle() {
        let findPasswordButtonTitle = NSAttributedString(
            string: "비밀번호 찾기",
            attributes:
                [
                    .font: UIFont.notoSansKRRegularFont(fontSize: 14),
                    .foregroundColor: UIColor.gray4,
                    .kern: -0.7
                ]
        )
        
        let signupButtonTitle = NSAttributedString(
            string: "회원가입",
            attributes:
                [
                    .font: UIFont.notoSansKRRegularFont(fontSize: 14),
                    .foregroundColor: UIColor.gray4,
                    .kern: -0.7
                ]
        )
        
        findPasswordButton.setAttributedTitle(findPasswordButtonTitle, for: .normal)
        signupButton.setAttributedTitle(signupButtonTitle, for: .normal)
    }
    
    private func configPlaceholder() {
        emailTextField.attributedPlaceholder =
        NSAttributedString(
            string: "yourname@example.com",
            attributes:
                [
                    .foregroundColor: UIColor.gray3,
                    .font: UIFont.notoSansKRRegularFont(fontSize: 16),
                    .kern: -0.48
                ]
        )
        
        passwordTextField.attributedPlaceholder =
        NSAttributedString(
            string: "yourpassword",
            attributes:
                [
                    .foregroundColor: UIColor.gray3,
                    .font: UIFont.notoSansKRRegularFont(fontSize: 16),
                    .kern: -0.48
                ]
        )
    }
    
    private func configDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func validate() {
        if emailTextField.hasText && passwordTextField.hasText {
            loginButton.backgroundColor = .maincolor1
            loginButton.isUserInteractionEnabled = true
        }
        else {
            loginButton.backgroundColor = .gray3
            loginButton.isUserInteractionEnabled = false
        }
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchupLoginButton() {
        login()
    }
    
    @objc
    private func touchupFindPasswordButton() {
        let findVC = FindPasswordViewController()
        navigationController?.pushViewController(findVC, animated: true)
    }
    
    @objc
    private func touchupSignupButton() {
        let signupVC = SignUpViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(
                withDuration: 0.3,
                animations: { self.view.transform = CGAffineTransform(translationX: 0, y: -50) }
            )
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        self.view.transform = .identity
    }
    
    // MARK: - Server Helpers
    
    private func login() {
        
        self.view.endEditing(true)
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text else { return }
        userAuthProvider.rx.request(.login(email: emailText, password: passwordText))
            .asObservable()
            .subscribe(onNext: { response in
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(
                            ResponseType<LoginData>.self,
                            from: response.data
                        )
                        
                        if let loginData = data.loginData {
                            KeychainWrapper.standard.set(loginData.nickname, forKey: "nickname")
                        }
                        KeychainWrapper.standard.set(emailText, forKey: "loginEmail")
                        KeychainWrapper.standard.set(passwordText, forKey: "loginPassword")
                        KeychainWrapper.standard.set(data.loginData!.tokenAccess, forKey: "tokenAccess")
                        KeychainWrapper.standard.set(data.loginData!.tokenRefresh, forKey: "tokenRefresh")
                        
                        let cafeTI = KeychainWrapper.standard.string(forKey: "userCafeTI")
                        if cafeTI != nil {
                            let mapVC = MapViewController()
                            self.emailTextField.text = ""
                            self.passwordTextField.text = ""
                            self.validate()
                            self.navigationController?.pushViewController(mapVC, animated: false)
                        }
                        else {
                            let cafeTIVC = CafeTIViewController()
                            self.emailTextField.text = ""
                            self.passwordTextField.text = ""
                            self.validate()
                            self.navigationController?.pushViewController(cafeTIVC, animated: false)
                        }
                    } catch {
                        self.testLabel.isHidden = false
                        self.testLabel.setupLabel(
                            text: "디코딩 에러",
                            color: .red,
                            font: .notoSansKRRegularFont(fontSize: 15)
                        )
                    }
                }
                else if response.statusCode == 404 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseType<LoginModel>.self,
                                                      from: response.data)
                        self.testLabel.isHidden = false
                        self.testLabel.setupLabel(
                            text: data.message ?? "로그인 에러",
                            color: .red,
                            font: .notoSansKRRegularFont(fontSize: 15)
                        )
                    }
                    catch {
                        self.testLabel.isHidden = false
                        self.testLabel.setupLabel(
                            text: "디코딩 에러",
                            color: .red,
                            font: .notoSansKRRegularFont(fontSize: 15)
                        )
                    }
                }
                else {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(ResponseType<LoginModel>.self,
                                                      from: response.data)
                        self.showGrayToast(message: data.message!)
                        
                    } catch {
                        self.testLabel.isHidden = false
                        self.testLabel.setupLabel(
                            text: "디코딩 에러",
                            color: .red,
                            font: .notoSansKRRegularFont(fontSize: 15)
                        )
                    }
                }
            }, onError: { error in
                print(error)
                self.testLabel.isHidden = false
                self.testLabel.setupLabel(
                    text: error.localizedDescription,
                    color: .red,
                    font: .notoSansKRRegularFont(fontSize: 15)
                )
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validate()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            login()
        }
        textField.resignFirstResponder()
        return true
    }
}
