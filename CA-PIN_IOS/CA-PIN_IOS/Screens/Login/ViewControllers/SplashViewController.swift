//
//  SplashViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/16.
//

import UIKit

import SnapKit
import Then

class SplashViewController: UIViewController {
  
  var logoImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .subcolorBlue3
    layout()
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    
    self.view.layoutIfNeeded()
    self.logoImageView.alpha = 0.0
    
    UIView.animate(withDuration: 3.5, animations:
                    {
                      self.logoImageView.alpha = 1.0
                      self.view.layoutIfNeeded()
                    },completion: {finished in
                      
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        //                        if (UserDefaults.standard.string(forKey: "isFirstlaunch") == nil) {
                        //                          print("첫 로드 : 온보딩")
                        //                          UserDefaults.standard.set(true,forKey: "isFirstlaunch")
                        //
                        //                          let storyBoard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
                        //                          if let vc = storyBoard.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC {
                        //                            self.navigationController?.pushViewController(vc, animated: true)
                        //                          }
                        //                        }
                        //                        else {
                        //
                        //                          let vc = (self.storyboard?.instantiateViewController(identifier: "LoginVC"))! as LoginVC
                        //
                        //                          self.navigationController?.pushViewController(vc, animated: false)
                        //
                        //                        }
                        let loginVC = LoginViewController()
                        self.navigationController?.pushViewController(loginVC, animated: false)
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
      $0.image = UIImage(named: "splashLogo")
      $0.snp.makeConstraints {
        let screenWidth = UIScreen.main.bounds.width
        $0.width.equalTo(140)
        $0.height.equalTo(151)
        $0.centerX.centerY.equalToSuperview()
      }
    }
  }
}

