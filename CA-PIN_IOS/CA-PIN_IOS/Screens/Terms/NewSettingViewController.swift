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
    layoutPlanSecondtNameLabel()
    layoutDesignTextLabel()
    layoutDesignFirstNameLabel()
    layoutDesignSecondNameLabel()
    layoutDesignThirdNameLabel()
    layoutIosTextLabel()
    layoutIosFirstNameLabel()
    layoutIosSecondNameLabel()
    layoutIosThirdNameLabel()
    layoutAndroidTextLabel()
    layoutAndroidFirstNameLabel()
    layoutAndroidSecondNameLabel()
    layoutAndroidThirdNameLabel()
    layoutAndroidFourthNameLabel()
    layoutServerTextLabel()
    layoutServerFirstNameLabel()
    layoutServerSecondNameLabel()
    layoutCopyrightImageView()
  }
  func layoutBackButton() {
    view.add(backButton) {
      $0.setImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(51)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.width.height.equalTo(28)
      }
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
    }
  }
  func layoutCapinImageView() {
    self.view.add(capinImageView) {
      $0.image = UIImage(named: "capinlogoforinfo")
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
      $0.addTarget(self, action: #selector(self.clickedGoTermsButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.capinImageView.snp.bottom).offset(25.8)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(21)
      }
    }
  }
  func layoutLogoutButton() {
    self.view.add(logoutButton) {
      $0.setupButton(title: "로그아웃", color: .maincolor1, font: .notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 0)
      $0.addTarget(self, action: #selector(self.logoutButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.goTermsButton.snp.bottom).offset(6)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(21)
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
      $0.image = UIImage(named: "animal1")
      $0.snp.makeConstraints {
        $0.top.leading.equalToSuperview()
        $0.height.equalTo(40)
        $0.width.equalTo(40)
      }
    }
  }
  func layoutSecondAnimalImage() {
    self.animalImageContainerView.add(secondAnimalImage) {
      $0.image = UIImage(named: "animal2")
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
      $0.image = UIImage(named: "animal3")
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
      $0.image = UIImage(named: "animal4")
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
      $0.image = UIImage(named: "animal5")
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
      $0.image = UIImage(named: "animal6")
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
  func layoutPlanSecondtNameLabel() {
    self.view.add(planSecondNameLabel) {
      $0.setupLabel(text: "김현아", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.planTextLabel)
        $0.trailing.equalTo(self.planFirstNameLabel.snp.leading).offset(-7)
      }
    }
  }
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
  func layoutDesignSecondNameLabel() {
    self.view.add(designSecondNameLabel) {
      $0.setupLabel(text: "한유진", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.designTextLabel)
        $0.trailing.equalTo(self.designFirstNameLabel.snp.leading).offset(-7)
      }
    }
  }
  func layoutDesignThirdNameLabel() {
    self.view.add(designThirdNameLabel) {
      $0.setupLabel(text: "이혜빈", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.designTextLabel)
        $0.trailing.equalTo(self.designSecondNameLabel.snp.leading).offset(-7)
      }
    }
  }
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
  func layoutIosSecondNameLabel() {
    self.view.add(iosSecondNameLabel) {
      $0.setupLabel(text: "장서현", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.iosTextLabel)
        $0.trailing.equalTo(self.iosFirstNameLabel.snp.leading).offset(-7)
      }
    }
  }
  func layoutIosThirdNameLabel() {
    self.view.add(iosThirdNameLabel) {
      $0.setupLabel(text: "노한솔", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.iosTextLabel)
        $0.trailing.equalTo(self.iosSecondNameLabel.snp.leading).offset(-7)
      }
    }
  }
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
  func layoutAndroidSecondNameLabel() {
    self.view.add(androidSecondNameLabel) {
      $0.setupLabel(text: "홍은결", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.androidTextLabel)
        $0.trailing.equalTo(self.androidFirstNameLabel.snp.leading).offset(-7)
      }
    }
  }
  func layoutAndroidThirdNameLabel() {
    self.view.add(androidThirdNameLabel) {
      $0.setupLabel(text: "조성림", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.androidTextLabel)
        $0.trailing.equalTo(self.androidSecondNameLabel.snp.leading).offset(-7)
      }
    }
  }
  func layoutAndroidFourthNameLabel() {
    self.view.add(androidFourthNameLabel) {
      $0.setupLabel(text: "손평화", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.androidTextLabel)
        $0.trailing.equalTo(self.androidThirdNameLabel.snp.leading).offset(-7)
      }
    }
  }
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
  func layoutServerSecondNameLabel() {
    self.view.add(serverSecondNameLabel) {
      $0.setupLabel(text: "이예슬", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.serverTextLabel)
        $0.trailing.equalTo(self.serverFirstNameLabel.snp.leading).offset(-7)
      }
    }
  }
  func layoutCopyrightImageView() {
    self.view.add(copyrightImageView) {
      $0.image = UIImage(named: "copyright")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.serverFirstNameLabel.snp.bottom).offset(70)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(12)
        $0.width.equalTo(138)
      }
    }
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: true)
  }
  @objc func clickedGoTermsButton() {
    let termVC = TermsViewController()
    self.navigationController?.pushViewController(termVC, animated: false)
  }
  @objc func logoutButtonClicked() {
    let popupVC = LogoutPopUpViewController()
    popupVC.modalPresentationStyle = .overCurrentContext
    self.present(popupVC, animated: false, completion: nil)
  }
}
