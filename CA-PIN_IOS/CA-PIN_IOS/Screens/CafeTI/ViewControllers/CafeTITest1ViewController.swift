//
//  CafeTITest1ViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/01.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - CafeTITest1ViewController

class CafeTITest1ViewController: UIViewController {
  
  // MARK: - Components
  
  let questiontitleLabel = UILabel()
  let coffeeImageView = UIImageView()
  let contentLabel = UILabel()
  let questiononeButton = UIButton()
  let questiontwoButton = UIButton()
  let buttonContainerView = UIView()
  let backButton = UIButton()
  let nextButton = UIButton()
  
  var selectedIndex = 10
  var buttons: [UIButton] = []
  var pagingnum = 0
  var resultAnswer: [Int] = []
  var temp: [Int] = []
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    addButtons()
    layout()
    self.navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Extensions

extension CafeTITest1ViewController {
  
  // MARK: - Helper
  
  func layout() {
    layoutQuestionTitleLabel()
    layoutCoffeeImageView()
    layoutContentLabel()
    layoutQuestiononeButton()
    layoutQuestiontwoButton()
    layoutButtonContainerView()
    layoutBackButton()
    layoutNextButton()
  }
  func layoutQuestionTitleLabel() {
    self.view.add(self.questiontitleLabel) {
      $0.setupLabel(text: "Question.01", color: .subcolorBlue4, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(30)
      }
    }
  }
  func layoutCoffeeImageView() {
    self.view.add(self.coffeeImageView) {
      $0.image = UIImage(named: "frame137")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.questiontitleLabel.snp.bottom).offset(3)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutContentLabel() {
    self.view.add(self.contentLabel) {
      $0.setupLabel(text: "주로 마시는 음료는 무엇인가요?", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.coffeeImageView.snp.bottom)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutQuestiononeButton() {
    self.view.add(self.questiononeButton) {
      $0.setTitle("커피", for: .normal)
      $0.setTitleColor(.black, for: .normal)
      $0.backgroundColor = .gray1
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
      $0.setRounded(radius: 5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentLabel.snp.bottom).offset(113)
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.height.equalTo(50)
      }
    }
  }
  func layoutQuestiontwoButton() {
    self.view.add(self.questiontwoButton) {
      $0.setTitle("논커피", for: .normal)
      $0.setTitleColor(.black, for: .normal)
      $0.backgroundColor = .gray1
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
      $0.setRounded(radius: 5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.questiononeButton.snp.bottom).offset(10)
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.height.equalTo(50)
      }
    }
  }
  func addButtons() {
    self.buttons.append(questiononeButton)
    self.buttons.append(questiontwoButton)
  }
  func layoutButtonContainerView() {
    self.view.add(self.buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-34)
        $0.width.equalTo(318)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutBackButton() {
    self.view.add(self.backButton) {
      $0.setTitle("이전", for: .normal)
      $0.setTitleColor(.gray4, for: .normal)
      $0.backgroundColor = .gray2
      $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.leading.equalTo(self.buttonContainerView.snp.leading)
        $0.width.equalTo(154)
      }
    }
  }
  func layoutNextButton() {
    self.view.add(self.nextButton) {
      $0.setTitle("다음", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.backgroundColor = .subcolorBlue2
      $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.nextButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
        $0.width.equalTo(154)
      }
    }
  }
  
  // MARK: - General Helpers
  
  @objc func clickedButton(_ sender: UIButton) {
    switch sender {
    case buttons[0]:
      self.selectedIndex = 0
    case buttons[1]:
      self.selectedIndex = 1
    default:
      self.selectedIndex = 10
    }
    sender.setBorder(borderColor: .subcolorBrown3, borderWidth: 2)
    sender.setTitleColor(.subcolorBrown3, for: .normal)
    sender.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
    for i in 0..<self.buttons.count {
      if self.selectedIndex != i {
        buttons[i].setBorder(borderColor: .clear, borderWidth: .none)
        buttons[i].setTitleColor(.black, for: .normal)
        buttons[i].titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      }
    }
    if self.selectedIndex == 0 {
      self.coffeeImageView.image = UIImage(named: "coffee")
      self.pagingnum = 1
    }
    if self.selectedIndex == 1 {
      self.coffeeImageView.image = UIImage(named: "nonCoffee")
      self.pagingnum = 1
    }
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func nextButtonClicked() {
    if self.pagingnum == 1 {
      if self.selectedIndex == 0 {
        // resultanswers 배열에 0 추가
        print(selectedIndex)
        let CAFETITest21ViewController = CAFETITest21ViewController()
        self.resultAnswer.append(selectedIndex)
        CAFETITest21ViewController.resultAnswer = self.resultAnswer
        CAFETITest21ViewController.temp = self.resultAnswer
        self.navigationController?.pushViewController(CAFETITest21ViewController, animated: false)
        self.resultAnswer = self.temp
       
      }
      else {
        // resultanswers 배열에 1 추가
        let CAFETITest22ViewController = CAFETITest22ViewController()
        self.resultAnswer.append(selectedIndex)
        CAFETITest22ViewController.resultAnswer = self.resultAnswer
        CAFETITest22ViewController.temp = self.resultAnswer
        self.navigationController?.pushViewController(CAFETITest22ViewController, animated: false)
        self.resultAnswer = self.temp
      
      }
    } else {
        self.showShortGrayToast(message: "한 가지 항목을 선택해주세요")
      
    }
  }
}


