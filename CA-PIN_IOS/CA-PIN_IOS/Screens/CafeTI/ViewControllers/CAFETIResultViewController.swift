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
  let CAFETISubtitleLabel = UILabel()
  let CAFETIintroLabel = UILabel()
  let CAFETIagainLabel = UILabel()
  let CAFETIendButton = UIButton()
  
  var resultData: CafeTIResult?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    setResultData()
    layout()
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super .viewWillAppear(animated)
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
    layoutCAFETISubTitleLabel()
    layoutCAFETIIntroLabel()
    layoutCAFETIEndButton()
  }
  func layoutTitleLabel() {
    self.view.add(self.titleLabel) {
      $0.setupLabel(text: "검사완료", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutResultImageView() {
    self.view.add(self.resultImageView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(34)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(UIScreen.main.bounds.width)
        $0.height.equalTo(320/375*UIScreen.main.bounds.width)
      }
    }
  }
  func layoutCAFETIResultView() {
    self.view.add(self.CAFETIresultView) {
      $0.backgroundColor = .pointcolor1
      $0.setRounded(radius: 13)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.resultImageView.snp.bottom)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(25)
        $0.width.equalTo(62)
      }
    }
  }
  func layoutCAFETIResultLabel() {
    self.CAFETIresultView.add(self.CAFETIresultLabel) {
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.CAFETIresultView)
        $0.centerY.equalTo(self.CAFETIresultView)
      }
    }
  }
  func layoutCAFETITitleLabel() {
    self.view.add(self.CAFETItitleLabel) {
      $0.letterSpacing = -1.3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETIresultView.snp.bottom).offset(5)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETISubTitleLabel() {
    self.view.add(self.CAFETISubtitleLabel) {
      $0.letterSpacing = -0.7
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETItitleLabel.snp.bottom)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETIIntroLabel() {
    self.view.add(self.CAFETIintroLabel) {
      $0.setupLabel(text: "CAFETI는 프로필 수정페이지에서\n다시 검사하실 수 있습니다.",
                    color: .subcolorBlue4,
                    font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.letterSpacing = -0.7
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETISubtitleLabel.snp.bottom).offset(20)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETIEndButton() {
    self.view.add(self.CAFETIendButton) {
      $0.setTitle("검사 종료", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.backgroundColor = .pointcolor1
      $0.addTextSpacing(spacing: -0.8)
      $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.endButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.height.equalTo(49*UIScreen.main.bounds.width/375)
        $0.width.equalTo(UIScreen.main.bounds.width-40)
        $0.bottom.equalTo(self.view.snp.bottom).offset(-34)
      }
    }
  }
  @objc func endButtonClicked() {
      let MapViewController = MapViewController()
      self.navigationController?.pushViewController(MapViewController, animated: false)
          
      }
  func setResultData() {
    self.resultImageView.imageFromUrl(self.resultData?.img, defaultImgPath: "https://capin.s3.ap-northeast-2.amazonaws.com/cafeti/Deer_coffee%402x.png")
    self.CAFETIresultLabel.setupLabel(text: self.resultData?.type ?? "", color: .white, font: UIFont.notoSansKRMediumFont(fontSize: 16))
    self.CAFETItitleLabel.setupLabel(text: self.resultData?.modifier ?? "", color: .subcolorBrown4, font: UIFont.notoSansKRMediumFont(fontSize: 26))
    self.CAFETISubtitleLabel.setupLabel(text: self.resultData?.modifierDetail ?? "", color: .gray3, font: UIFont.notoSansKRRegularFont(fontSize: 14))
    self.reloadInputViews()
    
  }
}
