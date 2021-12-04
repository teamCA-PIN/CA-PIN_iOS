//
//  NewSettingViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/11/23.
//

import UIKit

import SnapKit
import Then

// MARK: - NewSettingViewController
class NewSettingViewController: UIViewController {
  
  // MARK: - Components
  let backButton = UIButton()
  let capinImageView = UIImageView()
  let goTermsButton = UIButton()
  let logoutButton = UIButton()
  let animalImageContainerView = UIView()
  let firstAnimalIamge = UIImageView()
  let secondAnimalImage = UIImageView()
  let thirdAnimalImage = UIImageView()
  let fourthAnimalImage = UIImageView()
  let fifthAnimalImage = UIImageView()
  let sixthAnimalImage = UIImageView()
  let planTextLabel = UILabel()
  let planFirstNameLabel = UILabel()
  let planSecondNameLabel = UILabel()
  let designTextLabel = UILabel()
  let designFirstNameLabel = UILabel()
  let designSecondNameLabel = UILabel()
  let designThirdNameLabel = UILabel()
  let iosTextLabel = UILabel()
  let iosFirstNameLabel = UILabel()
  let iosSecondNameLabel = UILabel()
  let iosThirdNameLabel = UILabel()
  let androidTextLabel = UILabel()
  let androidFirstNameLabel = UILabel()
  let androidSecondNameLabel = UILabel()
  let androidThirdNameLabel = UILabel()
  let androidFourthNameLabel = UILabel()
  let serverTextLabel = UILabel()
  let serverFirstNameLabel = UILabel()
  let serverSecondNameLabel = UILabel()
  let copyrightImageView = UIImageView()
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    layout()
  }
}

// MARK: - Extensions
extension NewSettingViewController {
  
  // MARK: - Helper
  func layout() {
    layoutBackButton()
    layoutCapinImageView()
    layoutGoTermsButton()
    layoutLogoutButton()
    layoutAnimalImageContainerView()
    layoutFirstAnimalImage()
    layoutSecondAnimalImage()
    layoutThirdAnimalImage()
    layoutFourthAnimalImage()
    layoutFifthAnimalImage()
    layoutSixthAnimalImage()
    layoutPlanTextLabel()
    layoutPlanFirstNameLabel()
    layoutDesignTextLabel()
    layoutDesignFirstNameLabel()
    layoutIosTextLabel()
    layoutIosFirstNameLabel()
    layoutAndroidTextLabel()
    layoutAndroidFirstNameLabel()
    layoutServerTextLabel()
    layoutServerFirstNameLabel()
    layoutCopyrightImageView()
  }
  func layoutBackButton() {
    self.view.add(backButton) {
      $0.setImageByName("")
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(40)
        $0.trailing.equalToSuperview().offset(-20)
        $0.height.equalTo(30)
        $0.width.equalTo(30)
      }
    }
  }
  func layoutCapinImageView() {
    self.view.add(capinImageView) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.backButton.snp.bottom).offset(25)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(127.2)
        $0.width.equalTo(82)
      }
    }
  }
  func layoutGoTermsButton() {
    self.view.add(goTermsButton) {
      $0.setupButton(title: "약관 및 정책", color: .maincolor1, font: .notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.capinImageView.snp.bottom).offset(25.8)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutLogoutButton() {
    self.view.add(logoutButton) {
      $0.setupButton(title: "로그아웃", color: .maincolor1, font: .notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.goTermsButton.snp.bottom).offset(6)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutAnimalImageContainerView() {
    self.view.add(animalImageContainerView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.logoutButton.snp.bottom).offset(36)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(40)
        $0.width.equalTo(240)
      }
    }
  }
  func layoutFirstAnimalImage() {
    self.animalImageContainerView.add(firstAnimalIamge) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.leading.equalToSuperview()
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutSecondAnimalImage() {
    self.animalImageContainerView.add(secondAnimalImage) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalTo(self.firstAnimalIamge.snp.trailing)
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutThirdAnimalImage() {
    self.animalImageContainerView.add(thirdAnimalImage) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalTo(self.secondAnimalImage.snp.trailing)
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutFourthAnimalImage() {
    self.animalImageContainerView.add(fourthAnimalImage) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalTo(self.thirdAnimalImage.snp.trailing)
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutFifthAnimalImage() {
    self.animalImageContainerView.add(fifthAnimalImage) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalTo(self.fourthAnimalImage.snp.trailing)
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutSixthAnimalImage() {
    self.animalImageContainerView.add(sixthAnimalImage) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalTo(self.fifthAnimalImage.snp.trailing)
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutPlanTextLabel() {
    self.view.add(planTextLabel) {
      $0.setupLabel(text: "Plan", color: .pointcolor1, font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.animalImageContainerView.snp.bottom).offset(57)
        $0.leading.equalToSuperview().offset(77)
      }
    }
  }
  func layoutPlanFirstNameLabel() {
    self.view.add(planFirstNameLabel) {
      $0.setupLabel(text: "곽민제", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.planTextLabel)
        $0.trailing.equalToSuperview().offset(-80)
      }
    }
  }
  ///TODO - PlanSecondLabel
  func layoutDesignTextLabel() {
    self.view.add(designTextLabel) {
      $0.setupLabel(text: "Design", color: .pointcolor1, font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.planTextLabel.snp.bottom).offset(27)
        $0.leading.equalToSuperview().offset(77)
      }
    }
  }
  func layoutDesignFirstNameLabel() {
    self.view.add(designFirstNameLabel) {
      $0.setupLabel(text: "김나원", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.designTextLabel)
        $0.trailing.equalToSuperview().offset(-80)
      }
    }
  }
  ///TODO - Design Second & Third
  func layoutIosTextLabel() {
    self.view.add(iosTextLabel) {
      $0.setupLabel(text: "iOS", color: .pointcolor1, font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.designTextLabel.snp.bottom).offset(27)
        $0.leading.equalToSuperview().offset(77)
      }
    }
  }
  func layoutIosFirstNameLabel() {
    self.view.add(iosFirstNameLabel) {
      $0.setupLabel(text: "김지수", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.iosTextLabel)
        $0.trailing.equalToSuperview().offset(-80)
      }
    }
  }
  ///TODO - iOS Second & Third
  func layoutAndroidTextLabel() {
    self.view.add(androidTextLabel) {
      $0.setupLabel(text: "Android", color: .pointcolor1, font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.iosTextLabel.snp.bottom).offset(27)
        $0.leading.equalToSuperview().offset(77)
      }
    }
  }
  func layoutAndroidFirstNameLabel() {
    self.view.add(androidFirstNameLabel) {
      $0.setupLabel(text: "윤혁", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.androidTextLabel)
        $0.trailing.equalToSuperview().offset(-80)
      }
    }
  }
  ///TODO - Android Second&Third&Fourth
  func layoutServerTextLabel() {
    self.view.add(serverTextLabel) {
      $0.setupLabel(text: "Server", color: .pointcolor1, font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.androidTextLabel.snp.bottom).offset(27)
        $0.leading.equalToSuperview().offset(77)
      }
    }
  }
  func layoutServerFirstNameLabel() {
    self.view.add(serverFirstNameLabel) {
      $0.setupLabel(text: "이원석", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.serverTextLabel)
        $0.trailing.equalToSuperview().offset(-80)
      }
    }
  }
  func layoutCopyrightImageView() {
    self.view.add(copyrightImageView) {
      $0.image = UIImage(named: "")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.serverFirstNameLabel.snp.bottom).offset(70)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(12)
        $0.width.equalTo(138)
      }
    }
  }
}
