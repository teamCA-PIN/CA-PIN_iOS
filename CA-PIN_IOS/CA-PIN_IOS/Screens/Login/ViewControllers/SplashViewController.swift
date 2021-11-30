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
      $0.image = UIImage(named: "capinLogo")
      $0.snp.makeConstraints {
        let screenWidth = UIScreen.main.bounds.width
        $0.centerX.centerY.equalToSuperview()
      }
    }
  }
}

