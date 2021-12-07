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
  let cafetiIntroBackgroundView = UIView()
  let CAFETIintroLabel = UILabel()
  let CAFETIagainLabel = UILabel()
  let CAFETIendButton = UIButton()
  
  var resultData: CafeTIResult?
  var cafetiJudgeData : Int = 0
  
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
    layoutcafetiIntroBackgroundView()
    layoutCAFETIIntroLabel()
    layoutCAFETIagainLabel()
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
      $0.backgroundColor = .subcolorBlue1
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
  func layoutcafetiIntroBackgroundView() {
    self.view.add(self.cafetiIntroBackgroundView) {
      $0.backgroundColor = .gray1
      $0.setRounded(radius: 10)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.CAFETISubtitleLabel.snp.bottom).offset(15)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(335)
        $0.height.equalTo(118)
      }
    }
  }
  func layoutCAFETIIntroLabel() {
    self.cafetiIntroBackgroundView.add(self.CAFETIintroLabel) {
      $0.numberOfLines = 0
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.cafetiIntroBackgroundView.snp.centerX)
        $0.centerY.equalTo(self.cafetiIntroBackgroundView.snp.centerY)
      }
    }
  }
  func layoutCAFETIagainLabel() {
    self.view.add(self.CAFETIagainLabel) {
      $0.setupLabel(text: "CAFETI는 프로필 수정페이지에서\n다시 검사하실 수 있습니다.",
                    color: .gray4,
                    font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.letterSpacing = -0.7
      $0.snp.makeConstraints {
        $0.top.equalTo(self.cafetiIntroBackgroundView.snp.bottom).offset(36)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCAFETIEndButton() {
    self.view.add(self.CAFETIendButton) {
      $0.setTitle("검사 종료", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.backgroundColor = .maincolor1
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
    if self.cafetiJudgeData == 1 {
      let mypageVC = MypageViewController()
      self.navigationController?.pushViewController(mypageVC, animated: false)
    } else {
      let MapViewController = MapViewController()
      self.navigationController?.pushViewController(MapViewController, animated: false)
    }
  }
  func setResultData() {
    self.resultImageView.imageFromUrl(self.resultData?.img, defaultImgPath: "https://capin.s3.ap-northeast-2.amazonaws.com/cafeti/Deer_coffee%402x.png")
    // 여기는 서현이가 추가했음 ㅈㅅ
    UserDefaults.standard.setValue(self.resultData?.img, forKey: "defaultImageURL")
    self.CAFETIresultLabel.setupLabel(text: self.resultData?.type ?? "", color: .white, font: UIFont.notoSansKRMediumFont(fontSize: 16))
    self.CAFETItitleLabel.setupLabel(text: self.resultData?.modifier ?? "", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 26))
    self.CAFETISubtitleLabel.setupLabel(text: self.resultData?.modifierDetail ?? "", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
    
    if let resultdata = resultData?.introduction {
      if resultdata == nil {
      } else {
        self.CAFETIintroLabel.setupLabel(text: resultdata, color: .subcolorBlue1, font: .notoSansKRRegularFont(fontSize: 14), align: .center)
      }
    }
    self.reloadInputViews()
    
  }
}
