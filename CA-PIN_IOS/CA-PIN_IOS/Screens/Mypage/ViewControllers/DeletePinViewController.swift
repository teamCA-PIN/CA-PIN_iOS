//
//  DeletePinViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/12.
//

import UIKit
import Moya
import Moya
import RxSwift

class DeletePinViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  private let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let confirmButton = UIButton()
  
  var categoryId: String = "" /// 선택된 카테고리 아이디 -> 삭제할 때 쓸거임
  var cafeIdArrayToDelete: [String] = [] /// 삭제할 카페 id값만 넣어놓은 배열
  
  var mypageVC = UIViewController()
  let disposeBag = DisposeBag()
  private let CategoryService = MoyaProvider<CategoryService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
    // Do any additional setup after loading the view.
  }
}
// MARK: - Extensions
extension DeletePinViewController {
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
      $0.setupLabel(text: "선택된 핀을 모두\n삭제하시겠습니까?",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
      $0.numberOfLines = 0
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.popupView.snp.top).offset(41.5)
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
  
  
  func deleteService(categoryId: String, cafeList: [String]) {
    
    CategoryService.rx.request(.deleteCafeInCategory(categoryId: categoryId, cafeList: cafeList))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 { /// 삭제 성공
          do {
            
            let detailVC = self.presentingViewController?.children.last as? CategoryDetailViewController
            self.dismiss(animated: false) {
              detailVC?.setupCategoryData()
              detailVC?.showGreenToast(message: "핀 삭제가 완료되었습니다.")
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
//    self.navigationController?.popViewController(animated: false)
  }
  @objc func clickedConfirmButton() {
//    let categoryDetailVC = CategoryDetailViewController()
//    categoryDetailVC.deleteService()
    if categoryId.count == 0 {
      self.showToast("잘못된 접근입니다.")
    }
    else {
      self.deleteService(categoryId: self.categoryId, cafeList: self.cafeIdArrayToDelete)
    }
  }
}
