//
//  ExitViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/07.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - ExitViewController
class ExitViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let confirmButton = UIButton()
  
  var tagVC = UIViewController()
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
  }
}

// MARK: - Extensions
extension ExitViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = .backgroundCover
    layoutPopupView()
    layoutTitleLabel()
    layoutDescriptionLabel()
    layoutButtonContainerView()
    layoutCancelButton()
    layoutConfirmButton()
  }
  func layoutPopupView() {
    self.view.add(popupView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.width.equalTo(335)
        $0.height.equalTo(197)
      }
    }
  }
  func layoutTitleLabel() {
    popupView.add(titleLabel) {
      $0.setupLabel(text: "페이지를 나가시겠습니까?",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.popupView.snp.top).offset(26)
      }
    }
  }
  func layoutDescriptionLabel() {
    popupView.add(descriptionLabel) {
      $0.setupLabel(text: "검색결과 보기를 눌러\n원하시는 검색 결과를 받아보세요.",
                    color: 0x6f6f6f.color,
                    font: .notoSansKRRegularFont(fontSize: 14))
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
      }
    }
  }
  func layoutButtonContainerView() {
    popupView.add(buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.height.equalTo(56)
      }
    }
  }
  func layoutCancelButton() {
    buttonContainerView.add(cancelButton) {
      $0.setupButton(title: "취소",
                     color: .black,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .gray2,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedCancelButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.buttonContainerView.snp.centerX)
        $0.leading.top.bottom.equalToSuperview()
      }
    }
  }
  func layoutConfirmButton() {
    buttonContainerView.add(confirmButton) {
      $0.setupButton(title: "확인",
                     color: .white,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .pointcolor1,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedConfirmButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.buttonContainerView.snp.centerX)
        $0.trailing.top.bottom.equalToSuperview()
      }
    }
  }
  
  // MARK: - General Helpers
  @objc func clickedCancelButton() {
    self.dismiss(animated: false, completion: nil)
  }
  @objc func clickedConfirmButton() {
    self.dismiss(animated: false) {
      let tagVC = self.tagVC as? TagViewController
      tagVC?.selectedTag = []
      NotificationCenter.default.post(name: NSNotification.Name("pop"), object: nil)
    }
  }
}
