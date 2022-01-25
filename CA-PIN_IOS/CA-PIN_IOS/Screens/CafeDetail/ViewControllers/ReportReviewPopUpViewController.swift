//
//  ReportReviewPopUpViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/12/04.
//

import UIKit
import Moya
import Moya
import RxSwift


class ReportReviewPopUpViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let deleteButton = UIButton()
  
  let disposeBag = DisposeBag()
  let reviewProvider = MoyaProvider<ReviewService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  var reviewId: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}

// MARK: - Extensions
extension ReportReviewPopUpViewController {
  
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
        $0.height.equalTo(197)
      }
    }
  }
  func layoutTitleLabel() {
    popupView.add(titleLabel) {
      $0.setupLabel(text: "리뷰를 신고하시겠습니까?",
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
      $0.numberOfLines = 0
      $0.setupLabel(text: "카페 후기와 관계없거나 무의미한 내용, 욕설 등이\n포함된 경우 검토 후 삭제됩니다.",
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
      $0.setupButton(title: "신고",
                     color: .white,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .maincolor1,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.reportButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.buttonContainerView.snp.centerX)
        $0.trailing.top.bottom.equalToSuperview()
      }
    }
  }
  
  func reportService(reviewId: String) {
    reviewProvider.rx.request(.reportReivew(reviewId: reviewId))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 { /// 신고
          do {
            let endIndex = self.presentingViewController?.children.endIndex ?? 0
            let cafeDetailVC = self.presentingViewController?.children[endIndex-1] as? CafeDetailViewController ?? UIViewController()
            self.dismiss(animated: false) {
              cafeDetailVC.viewWillAppear(true)
              cafeDetailVC.showGreenToast(message: "리뷰를 신고했습니다")
            }
          }
          catch {
            print(error)
          }
        }
        else { /// 삭제 실패
          do {
            self.showGrayToast(message: "신고에 실패했습니다")
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
  @objc func reportButtonClicked() {
    self.reportService(reviewId: self.reviewId)
  }
}
