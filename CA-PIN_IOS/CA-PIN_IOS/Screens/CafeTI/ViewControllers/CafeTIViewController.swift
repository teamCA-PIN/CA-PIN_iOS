//
//  CafeTIViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import SnapKit
import Then

// MARK: - CafeTIViewController

class CafeTIViewController: UIViewController {
  
  // MARK: - Components
  
  let backButton = UIButton()
  let cafetititleLabel = UILabel()
  let questionImageView = UIImageView()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let startButton = UIButton()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    self.navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Extension

extension CafeTIViewController {
  
  // MARK: - Layout Helper
  
  func layout() {
    layoutBackButton()
    layoutCafeTITitleLabel()
    layoutQuestionImageView()
    layoutTitleLabel()
    layoutSubTitleLabel()
    layoutStartButton()
    
    
  }
  func layoutBackButton() {
    self.view.add(self.backButton) {
      $0.setImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(11)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.width.equalTo(28)
        $0.height.equalTo(28)
      }
    }
    
  }
  func layoutCafeTITitleLabel() {
    self.view.add(self.cafetititleLabel) {
      $0.setupLabel(text: "CAFETI 검사", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutQuestionImageView() {
    self.view.add(self.questionImageView) {
      $0.image = UIImage(named: "frame139")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.cafetititleLabel.snp.bottom).offset(103)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutTitleLabel() {
    self.view.add(self.titleLabel) {
      $0.setupLabel(text: "당신의 카페 취향은?", color: .pointcolor1, font: UIFont.notoSansKRRegularFont(fontSize: 26))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.questionImageView.snp.bottom).offset(51)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(38)
      }
    }
  }
  func layoutSubTitleLabel() {
    self.view.add(self.subtitleLabel) {
      $0.setupLabel(text: "캐릭터로 알아보는\nCAFETI 카페이용유형 검사", color: .gray3, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutStartButton() {
    self.view.add(self.startButton) {
      $0.setTitle("시작하기", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.backgroundColor = .pointcolor1
      $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.startButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(125)
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.height.equalTo(49)
      }
    }
  }
  @objc func startButtonClicked() {
    let CafeTITest1ViewController = CafeTITest1ViewController()
    self.navigationController?.pushViewController(CafeTITest1ViewController, animated: false)
    
  }
}

