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
    let userNameLabel = UILabel()
    let userNameTextField = UITextField()
    let userNameExplanationLabel = UILabel()
    let emailLabel = UILabel()
    let emailTextField = UITextField()
    let emailExplanation = UILabel()
    let passwordLabel = UILabel()
    let passwordTextField = UITextField()
    let checkPasswordLabel = UILabel()
    let checkPasswordTextField = UITextField()
    let signUpButton = UIButton()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
}

//MARK: - Extensions
extension SignUpViewController {
    
     //MARK: - Layout Helper
    func layout() {
        layoutUserNameLabel()
        layoutUserNameTextField()
        layoutUserNameExplanation()
        layoutEmailLabel()
        layoutEmailTextField()
        layoutEmailExplanation()
        layoutPasswordLabel()
        layoutPasswordTextField()
        layoutCheckPasswordLabel()
        layoutCheckPasswordTextField()
        layoutSignUpButton()
    }
    func layoutUserNameLabel() {
        self.view.add(self.userNameLabel) {
            $0.setupLabel(text: "사용자 이름", color: .brown, font: UIFont.systemFont(ofSize: 16))
        }
    }
    func layoutUserNameTextField() {
        
    }
    func layoutUserNameExplanation() {
        
    }
    func layoutEmailLabel() {
        
    }
    func layoutEmailTextField() {
        
    }
    func layoutEmailExplanation() {
        
    }
    func layoutPasswordLabel() {
        
    }
    func layoutPasswordTextField() {
        
    }
    func layoutCheckPasswordLabel() {
        
    }
    func layoutCheckPasswordTextField() {
        
    }
    func layoutSignUpButton() {
        self.view.add(self.signUpButton) {
            $0.setTitle("가입하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitleColor(.white, for: .selected)
            $0.backgroundColor = .gray
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            $0.setRounded(radius: 24)
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
