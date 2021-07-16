//
//  DeleteReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/11.
//

import UIKit
import Moya
import RxMoya
import RxSwift

class DeleteReviewViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let confirmButton = UIButton()
  
  var reviewId: String = ""
  
  
  let disposeBag = DisposeBag()
  private let reviewDeleteService = MoyaProvider<ReviewService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
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
  func reviewDeleteService(reviewId: String) {
    reviewDeleteService.rx.request(.deleteReview(reviewId: reviewId))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 { /// 삭제 성공
          do {
            self.dismiss(animated: false) {
              let mypageVC = self.presentingViewController?.children[0] as? MypageViewController
              mypageVC?.pageCollectionView.reloadData()
            }
//            self.navigationController?.popViewController(animated: false)
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
  @objc func clickedConfirmButton() {
    /// 삭제 서버 연결
    reviewDeleteService(reviewId: reviewId)
  }
}
