//
//  DeleteReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/11.
//

import UIKit

class DeleteReviewViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let confirmButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    // Do any additional setup after loading the view.
  }
}
// MARK: - Extensions
extension DeleteReviewViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = .backgroundCover
    layoutPopupView()
    layoutTitleLabel()
    layoutButtonContainerView()
    layoutCancelButton()
    layoutDeleteButton()
  }
  func layoutPopupView() {
    self.view.add(self.popupView) {
      $0.setRounded(radius: 6)
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
      $0.setupLabel(text: "리뷰를 삭제하시겠습니까?",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.popupView.snp.top).offset(55.5)
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
      $0.titleLabel?.letterSpacing = -0.6
      $0.addTarget(self, action: #selector(self.clickedCancelButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.buttonContainerView.snp.centerX)
        $0.leading.top.bottom.equalToSuperview()
      }
    }
  }
  func layoutDeleteButton() {
    buttonContainerView.add(self.confirmButton) {
      $0.setupButton(title: "확인",
                     color: .white,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .pointcolor1,
                     state: .normal,
                     radius: 0)
      $0.titleLabel?.letterSpacing = -0.6
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
    print("확인 ㄷ ㄷ ㄷ")
    /// 삭제 서버 연결
  }
}
