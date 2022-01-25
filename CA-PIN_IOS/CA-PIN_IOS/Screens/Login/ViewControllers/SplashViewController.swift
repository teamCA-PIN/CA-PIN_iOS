//
//  SplashViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/16.
//

import UIKit

import SnapKit
import Moya
import RxSwift
import SwiftKeychainWrapper
import Then

class SplashViewController: UIViewController {
    
    var logoImageView = UIImageView()
    private let UserAuthProvider = MoyaProvider<UserAuthService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .logoWhite
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.view.layoutIfNeeded()
        self.logoImageView.alpha = 0.0
        
        UIView.animate(withDuration: 2, animations:
                        {
            self.logoImageView.alpha = 1.0
            self.view.layoutIfNeeded()
        },completion: {finished in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if KeychainWrapper.standard.hasValue(forKey: "loginEmail") && KeychainWrapper.standard.hasValue(forKey: "loginPassword") {
                  KeychainWrapper.standard.set(0, forKey: "loginVCFlag")
                    if let email = KeychainWrapper.standard.string(forKey: "loginEmail"),
                       let password = KeychainWrapper.standard.string(forKey: "loginPassword") {
                        self.login(ID: email, PW: password)
                    }
                    else {
                        let loginVC = LoginViewController()
                        self.navigationController?.pushViewController(loginVC, animated: false)
                    }
                }
                else {
                    let loginVC = LoginViewController()
                    self.navigationController?.pushViewController(loginVC, animated: false)
                }
            }
        })
    }
}

extension SplashViewController {
    func layout() {
        layoutLogoImageView()
    }
    func layoutLogoImageView() {
        self.view.add(self.logoImageView) {
            $0.image = UIImage(named: "capinLogo")
            $0.snp.makeConstraints {
                let screenWidth = UIScreen.main.bounds.width
                $0.centerX.centerY.equalToSuperview()
            }
        }
    }
    
    private func login(ID: String, PW: String) {
        UserAuthProvider.rx.request(.login(email: ID, password: PW))
          .asObservable()
          .subscribe(onNext: { response in
            if response.statusCode == 200 {
              do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(ResponseType<LoginData>.self,
                                              from: response.data)
                  if let loginData = data.loginData {
                      KeychainWrapper.standard.set(loginData.nickname, forKey: "nickname")
                  }
                KeychainWrapper.standard.set(ID, forKey: "loginEmail")
                KeychainWrapper.standard.set(PW, forKey: "loginPassword")
                KeychainWrapper.standard.set(data.loginData!.tokenAccess, forKey: "tokenAccess")
                print("tokenAccess: \(data.loginData!.tokenAccess)")
                  KeychainWrapper.standard.set(data.loginData!.tokenRefresh, forKey: "tokenRefresh")

                let cafeTI = KeychainWrapper.standard.string(forKey: "userCafeTI")
                if cafeTI != nil {
                  let mapVC = MapViewController()
                  self.navigationController?.pushViewController(mapVC, animated: false)
                }
                else {
                  let cafeTIVC = CafeTIViewController()
                  self.navigationController?.pushViewController(cafeTIVC, animated: false)
                }

                
              } catch {
                print(error)
              }
            } else {
                  let loginVC = LoginViewController()
                  self.navigationController?.pushViewController(loginVC, animated: false)
            }
          }, onError: { error in
            print(error)
          }, onCompleted: {
          }).disposed(by: disposeBag)
    }
}

