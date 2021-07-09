//
//  WriteReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/09.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - WriteReviewViewController

class WriteReviewViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
  
  // MARK: - Components
  
  let writeScrollView = UIScrollView()
  let writeScrollContainerView = UIView()
  let backButton = UIButton()
  let writereviewtitleLabel = UILabel()
  let photoLabel = UILabel()
  let explainphotoLabel = UILabel()
  let tasteLabel = UILabel()
  let explaintasteLabel = UILabel()
  let buttonContainerView = UIView()
  let tasteButton = UIButton()
  let feelButton = UIButton()
  let reviewLabel = UILabel()
  let reviewessentialImageView = UIImageView()
  let explainreviewLabel = UILabel()
  let reviewTextField = UITextField()
  let starLabel = UILabel()
  let explainstarLabel = UILabel()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    self.writeScrollView.delegate = self
    self.navigationController?.navigationBar.isHidden = true
  }
}

// MARK: - Extension

extension WriteReviewViewController {
  
  // MARK: - Helpers
  
  func layout() {
    layoutBackButton()
    layoutWritereviewtitleLabel()
    layoutPhotoLabel()
    layoutExplainphotoLabel()
    layoutTasteLabel()
    layoutExplaintasteLabel()
    layoutButtonContainerView()
    layoutTasteButton()
    layoutFeelButton()
    layoutReviewLabel()
    layoutReviewessentialImageView()
    layoutExplainreviewLabel()
    layoutReviewTextField()
    layoutStarLabel()
    layoutExplainstarLabel()
  }
  func layoutWriteScrollView() {
    self.view.add(writeScrollView) {
      $0.backgroundColor = .white
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.width.equalTo(self.view.frame.width)
        $0.top.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
  }
  func layoutWriteScrollContainerView() {
    self.writeScrollView.add(writeScrollContainerView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .clear
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints(<#T##closure: (ConstraintMaker) -> Void##(ConstraintMaker) -> Void#>)
    }
  }
  func layoutBackButton() {
    self.view.add(self.backButton) {
      $0.setImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(7)
        $0.leading.equalToSuperview().offset(20)
        $0.width.equalTo(28)
        $0.height.equalTo(28)
      }
    }
  }
  func layoutWritereviewtitleLabel() {
    self.view.add(self.writereviewtitleLabel) {
      $0.setupLabel(text: "리뷰 작성하기", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutPhotoLabel() {
    self.view.add(self.photoLabel) {
      $0.setupLabel(text: "사진", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.backButton.snp.bottom).offset(39)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutExplainphotoLabel() {
    self.view.add(self.explainphotoLabel) {
      $0.setupLabel(text: "방문한 카페와 관련된 사진을 공유해주세요.", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.photoLabel.snp.bottom).offset(10)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(21)
      }
    }
  }
  func layoutTasteLabel() {
    self.view.add(self.tasteLabel) {
      $0.setupLabel(text: "맛과 분위기 추천", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainphotoLabel.snp.bottom).offset(40)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutExplaintasteLabel() {
    self.view.add(self.explaintasteLabel) {
      $0.setupLabel(text: "방문한 카페의 분위기와 음식 맛은 어떠셨나요?", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.tasteLabel.snp.bottom).offset(10)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(21)
      }
    }
  }
  func layoutButtonContainerView() {
    self.view.add(self.buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explaintasteLabel.snp.bottom).offset(19)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(335)
        $0.height.equalTo(50)
      }
    }
  }
  func layoutTasteButton() {
    self.buttonContainerView.add(self.tasteButton) {
      $0.setTitle("맛 추천", for: .normal)
      $0.setTitleColor(.gray4, for: .normal)
      $0.backgroundColor = .gray1
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.tasteButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 25)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.leading.equalTo(self.buttonContainerView.snp.leading)
        $0.width.equalTo(162)
        $0.height.equalTo(50)
      }
    }
  }
  @objc func tasteButtonClicked() {
    
    if tasteButton.isSelected == true {
      tasteButton.backgroundColor = .gray1
      tasteButton.setTitleColor(.white, for: .normal)
    }
    else {
      tasteButton.backgroundColor = .gray1
      tasteButton.setTitleColor(.gray4, for: .normal)
    }
  }
  func layoutFeelButton() {
    self.buttonContainerView.add(self.feelButton) {
      $0.setTitle("분위기 추천", for: .normal)
      $0.setTitleColor(.gray4, for: .normal)
      $0.backgroundColor = .gray1
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.feelButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 25)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
        $0.width.equalTo(162)
        $0.height.equalTo(50)
      }
    }
  }
  @objc func feelButtonClicked() {
    print("asdfa")
    if feelButton.isSelected == true {
      print("dfs")
      feelButton.setupButton(title: "분위기 추천", color: .white, font: .notoSansKRRegularFont(fontSize: 16), backgroundColor: .pointcolor1, state: .normal, radius: 25)
    }
    else {
      print("fsfsfs")
      feelButton.setupButton(title: "분위기 추천", color: .gray4, font: .notoSansKRRegularFont(fontSize: 16), backgroundColor: .gray1, state: .normal, radius: 25)
    }
  }
  func layoutReviewLabel() {
    self.view.add(self.reviewLabel) {
      $0.setupLabel(text: "리뷰", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.bottom).offset(41)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutReviewessentialImageView() {
    self.view.add(self.reviewessentialImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewLabel.snp.top)
        $0.leading.equalTo(self.reviewLabel.snp.trailing)
        $0.width.equalTo(8)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutExplainreviewLabel() {
    self.view.add(self.explainreviewLabel) {
      $0.setupLabel(text: "방문한 카페와 메뉴에 대해 리뷰를 작성해주세요.", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewLabel.snp.bottom).offset(8)
        $0.leading.equalTo(self.reviewLabel.snp.leading)
        $0.height.equalTo(21)
      }
    }
  }
  func layoutReviewTextField() {
    self.view.add(self.reviewTextField) {
      $0.placeholder = "리뷰를 작성하세요."
      $0.delegate = self
      $0.borderStyle = UITextField.BorderStyle.line
      $0.borderWidth = 1
      $0.borderColor = .gray3
      $0.cornerRadius = 5
      $0.keyboardType = UIKeyboardType.default
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainreviewLabel.snp.bottom).offset(20)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(335)
        $0.height.equalTo(161)
      }
    }
  }
  func layoutStarLabel() {
    self.view.add(self.starLabel) {
      $0.setupLabel(text: "별점", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewTextField.snp.bottom).offset(40)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutExplainstarLabel() {
    self.view.add(self.explainstarLabel) {
      $0.setupLabel(text: "방문한 카페의 별점은 몇점인가요?", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.starLabel.snp.bottom).offset(4)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(21)
      }
    }
  }
}
