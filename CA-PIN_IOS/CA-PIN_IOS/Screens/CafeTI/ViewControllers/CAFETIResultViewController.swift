//
//  CAFETIResultViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - CAFETIResultViewController

class CAFETIResultViewController: UIViewController {
  
  // MARK: - Componenets
  let titleLabel = UILabel()
  let resultImageView = UIImageView()
  let CAFETIresultView = UIView()
  let CAFETIresultLabel = UILabel()
  let CAFETItitleLabel = UILabel()
  let CAFETIintroLabel = UILabel()
  let CAFETIagainLabel = UILabel()
  let CAFETIendButton = UIButton()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    self.navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Extension

extension CAFETIResultViewController {
  // MARK: - Layout Helper
  
  func layout() {
    layoutTitleLabel()
    layoutResultImageView()
    layoutCAFETIResultView()
    layoutCAFETIResultLabel()
    layoutCAFETITitleLabel()
    layoutCAFETIIntroLabel()
    layoutCAFETIAgainLabel()
    layoutCAFETIEndButton()
  }
  func layoutTitleLabel() {
    self.view.add(self.titleLabel) {
      $0.setupLabel(text: "검사완료", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(50)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutResultImageView() {
    self.view.add(self.resultImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(35)
        $0.leading.equalTo(self.view.snp.leading).offset(3)
        $0.trailing.equalTo(self.view.snp.trailing).offset(36.9)
        $0.height.equalTo(302)
        $0.width.equalTo(375)
      }
    }
  }
  func layoutCAFETIResultView() {
    self.view.add(self.CAFETIresultView) {
      $0.backgroundColor = 0xa98e7a.color
      $0.setRounded(radius: 13)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.resultImageView.snp.bottom).offset(17)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(25)
        $0.width.equalTo(62)
      }
    }
  }
  func layoutCAFETIResultLabel() {
    self.CAFETIresultView.add(self.CAFETIresultLabel) {
      $0.setupLabel(text: "WBFJ", color: .white, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.CAFETIresultView)
        $0.centerY.equalTo(self.CAFETIresultView)
      }
    }
  }
  func layoutCAFETITitleLabel() {
    self.view.add(self.CAFETItitleLabel) {
      $0.setupLabel(text: "차분한 기린씨", color: 0x6b513d.color, font: UIFont.notoSansKRMediumFont(fontSize: 26))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETIresultView.snp.bottom).offset(5)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETIIntroLabel() {
    self.view.add(self.CAFETIintroLabel) {
      $0.setupLabel(text: "이제 카핀맵에서 ‘나를위한’ 버튼을 통해\n내 CAFETI 에 딱 맞는 카페를 모아보세요 !",
                    color: 0x91c2de.color,
                    font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETItitleLabel.snp.bottom).offset(11)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETIAgainLabel() {
    self.view.add(self.CAFETIagainLabel) {
      $0.setupLabel(text: "CAFETI는 프로필 수정페이지에서\n다시 검사하실 수 있습니다.",
                    color: 0xc4c4c4.color,
                    font: UIFont.notoSansKRRegularFont(fontSize: 12))
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETIintroLabel.snp.bottom).offset(47)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETIEndButton() {
    self.view.add(self.CAFETIendButton) {
      $0.setTitle("검사 종료", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.backgroundColor = 0xa98e7a.color
      $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.endButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETIagainLabel.snp.bottom).offset(94)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(49)
        $0.width.equalTo(335)
        $0.bottom.equalTo(self.view.snp.bottom).offset(-34)
      }
    }
  }
  @objc func endButtonClicked() {
      let MapViewController = MapViewController()
      self.navigationController?.pushViewController(MapViewController, animated: false)
          
      }
}

