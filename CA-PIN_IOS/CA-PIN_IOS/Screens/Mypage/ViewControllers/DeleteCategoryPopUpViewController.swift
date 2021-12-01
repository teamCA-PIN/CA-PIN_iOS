//
//  DeletePopUpViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/11.
//

import UIKit
import Moya
import RxMoya
import RxSwift


class DeleteCategoryPopUpViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let deleteButton = UIButton()
  
  let disposeBag = DisposeBag()
  private let CategoryService = MoyaProvider<CategoryService>()
  var categoryId: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    // Do any additional setup after loading the view.
  }
}

// MARK: - Extensions
extension DeleteCategoryPopUpViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = .backgroundCover
    layoutPopupView()
    layoutTitleLabel()
    layoutDescriptionLabel()
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
        $0.height.equalTo(175)
      }
    }
  }
  func layoutTitleLabel() {
    popupView.add(titleLabel) {
      $0.setupLabel(text: "카테고리를 삭제하시겠습니까?",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
//      $0.letterSpacing = -1
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.popupView.snp.top).offset(26)
      }
    }
  }
  func layoutDescriptionLabel() {
    popupView.add(descriptionLabel) {
      $0.setupLabel(text: "해당 카테고리에 저장된 모든 핀이 함께 삭제됩니다.",
                    color: 0x6f6f6f.color,
                    font: .notoSansKRRegularFont(fontSize: 14),
                    align: .center)
      $0.letterSpacing = -0.6
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
  func layoutDeleteButton() {
    buttonContainerView.add(deleteButton) {
      $0.setupButton(title: "삭제",
                     color: .white,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .pointcolor1,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedDeleteButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.buttonContainerView.snp.centerX)
        $0.trailing.top.bottom.equalToSuperview()
      }
    }
  }
  
  func deleteService(categoryId: String) {
    CategoryService.rx.request(.deleteCategory(categoryId: categoryId))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 { /// 삭제 성공
          do {
            let myPageVC = self.presentingViewController?.children[0] as? MypageViewController
            self.dismiss(animated: false) {
              myPageVC?.viewWillAppear(true)
              myPageVC?.showGreenToast(message: "카테고리 삭제가 완료되었습니다.")
            }
          }
          catch {
            print(error)
          }
        }
        else { /// 삭제 실패
          do {
            self.showGrayToast(message: "삭제에 실패했습니다")
          }
          catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  
  // MARK: - General Helpers
  @objc func clickedCancelButton() {
    self.dismiss(animated: false, completion: nil)
  }
  @objc func clickedDeleteButton() {
    deleteService(categoryId: categoryId)
    /// 삭제 서버 연결
  }
}
