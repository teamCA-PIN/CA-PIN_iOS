//
//  CafeDetailViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - CafeDetailViewController
class CafeDetailViewController: UIViewController {
  
  // MARK: - Components
  let cafeScrollView = UIScrollView()
  let cafeScrollContainerView = UIView()
  let bannerImageView = UIImageView()
  let titleContainerView = UIView()
  let cafeTitleLabel = UILabel()
  let starImageView = UIImageView()
  let starRatingLabel = UILabel()
  let addressLabel = UILabel()
  let tagCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
    return collectionView
  }()
  let informationView = UIView()
  let instagramLogoImageView = UIImageView()
  let instagramLabel = UILabel()
  let clockImageView = UIImageView()
  let clockLabel = UILabel()
  let menuImageView = UIImageView()
  let menuButton = UIButton()
  let reviewHeaderView = UIView()
  let reviewTitleLabel = UILabel()
  let reviewFilterLabel = UILabel()
  let reviewFilterButton = UIButton()
  let reviewEntireLabel = UILabel()
  let reviewEntireButton = UIButton()
  let reviewTableView = UITableView()
  let bottomView = UIView()
  let savePinButton = UIButton()
  let savePinLabel = UILabel()
  let writeReviewButton = UIButton()
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}

// MARK: - Extensions
extension CafeDetailViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    layoutCafeScrollView()
    layoutCafeScrollContainerView()
    layoutBannerImageView()
    layoutTitleContainerView()
    layoutCafeTitleLabel()
    layoutStarImageView()
    layoutStarRatingLabel()
    layoutAddressLabel()
    layoutTagCollectionView()
    layoutInformationView()
    layoutInstagramLogoImageView()
    layoutInstagramLabel()
    layoutClockImageView()
    layoutClockLabel()
    layoutMenuImageView()
    layoutMenuButton()
    layoutReviewHeaderView()
    layoutReviewTitleLabel()
    layoutReviewFilterLabel()
    layoutReviewFilterButton()
    layoutReviewEntireButton()
    layoutReviewEntireLabel()
    layoutBottomView()
    layoutSavePinButton()
    layoutSavePinLabel()
    layoutWriteReviewButton()
    layoutReviewTableView()
  }
  func layoutCafeScrollView() {
    view.add(cafeScrollView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
      }
    }
  }
  func layoutCafeScrollContainerView() {
    cafeScrollView.add(cafeScrollContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
    }
  }
  func layoutBannerImageView() {
    cafeScrollContainerView.add(bannerImageView) {
      $0.image = UIImage(named: "image176")
      $0.snp.makeConstraints {
        $0.top.leading.trailing.equalToSuperview()
        $0.height.equalTo(323)
      }
    }
  }
  func layoutTitleContainerView() {
    cafeScrollContainerView.add(titleContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.bannerImageView.snp.bottom)
        $0.leading.equalTo(self.cafeScrollView.snp.leading).offset(79)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(254)
      }
    }
  }
  func layoutCafeTitleLabel() {
    titleContainerView.add(cafeTitleLabel) {
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.titleContainerView.snp.top).offset(28)
      }
    }
  }
  func layoutStarImageView() {
    titleContainerView.add(starImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.titleContainerView.snp.leading).offset(69)
        $0.top.equalTo(self.titleContainerView.snp.top).offset(53)
        $0.width.height.equalTo(16)
      }
    }
  }
  func layoutStarRatingLabel() {
    titleContainerView.add(starRatingLabel) {
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.starImageView.snp.centerY)
        $0.leading.equalTo(self.starImageView.snp.trailing).offset(6)
      }
    }
  }
  func layoutAddressLabel() {
    titleContainerView.add(addressLabel) {
      $0.numberOfLines = 0
      $0.snp.makeConstraints {
        $0.centerX.leading.equalToSuperview()
        $0.top.equalTo(self.titleContainerView.snp.top).offset(82)
      }
    }
  }
  func layoutTagCollectionView() {
    cafeScrollContainerView.add(tagCollectionView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleContainerView.snp.bottom)
        $0.leading.equalTo(self.cafeScrollContainerView.snp.leading).offset(28)
        $0.centerX.equalTo(self.cafeScrollContainerView.snp.centerX)
        $0.height.equalTo(70)
      }
    }
  }
  func layoutInformationView() {
    cafeScrollContainerView.add(informationView) {
      $0.backgroundColor = .gray1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.tagCollectionView.snp.bottom).offset(28)
        $0.leading.equalTo(self.cafeScrollContainerView.snp.leading).offset(20)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(155)
      }
    }
  }
  func layoutInstagramLogoImageView() {
    informationView.add(instagramLogoImageView) {
      $0.image = UIImage(named: "iconInsta")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.informationView.snp.top).offset(20)
        $0.leading.equalTo(self.informationView.snp.leading).offset(19)
        $0.height.width.equalTo(24)
      }
    }
  }
  func layoutInstagramLabel() {
    informationView.add(instagramLabel) {
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.informationView.snp.leading).offset(58)
        $0.centerY.equalTo(self.instagramLogoImageView.snp.centerX)
      }
    }
  }
  func layoutClockImageView() {
    informationView.add(clockImageView) {
      $0.image = UIImage(named: "iconTime")
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.instagramLogoImageView)
        $0.top.equalTo(self.instagramLogoImageView.snp.bottom).offset(18)
        $0.height.width.equalTo(24)
      }
    }
  }
  func layoutClockLabel() {
    informationView.add(clockLabel) {
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.clockImageView.snp.top)
        $0.leading.equalTo(self.instagramLabel.snp.leading)
      }
    }
  }
  func layoutMenuImageView() {
    informationView.add(menuImageView) {
      $0.image = UIImage(named: "iconMenu")
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.instagramLogoImageView.snp.leading)
        $0.top.equalTo(self.clockImageView.snp.bottom).offset(29)
      }
    }
  }
  func layoutMenuButton() {
    informationView.add(menuButton) {
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.menuImageView.snp.centerX)
        $0.leading.equalTo(self.instagramLabel.snp.leading)
      }
    }
  }
  func layoutReviewHeaderView() {
    cafeScrollContainerView.add(reviewHeaderView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.informationView.snp.bottom).offset(48)
        $0.leading.equalTo(self.cafeScrollContainerView.snp.leading).offset(15)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(55)
      }
    }
  }
  func layoutReviewTitleLabel() {
    reviewHeaderView.add(reviewTitleLabel) {
      $0.setupLabel(text: "리뷰",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalTo(self.reviewHeaderView.snp.leading).offset(9)
      }
    }
  }
  func layoutReviewFilterLabel() {
    reviewHeaderView.add(reviewFilterLabel) {
      $0.setupLabel(text: "전체 보기",
                    color: .gray4,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.bottom.equalTo(self.reviewTitleLabel.snp.bottom)
        $0.leading.equalTo(self.reviewTitleLabel.snp.trailing).offset(15)
      }
    }
  }
  func layoutReviewFilterButton() {
    reviewHeaderView.add(reviewFilterButton) {
      $0.setBackgroundImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.reviewFilterLabel.snp.trailing).offset(4)
        $0.centerY.equalTo(self.reviewFilterLabel.snp.centerY)
        $0.width.equalTo(9)
        $0.height.equalTo(4)
      }
    }
  }
  func layoutReviewEntireButton() {
    reviewHeaderView.add(reviewEntireButton) {
      $0.setBackgroundImage(UIImage(named: "iconNextBtn"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewHeaderView.snp.top).offset(4)
        $0.trailing.equalTo(self.reviewHeaderView.snp.trailing).offset(-8)
        $0.width.height.equalTo(28)
      }
    }
  }
  func layoutReviewEntireLabel() {
    reviewHeaderView.add(reviewEntireLabel) {
      $0.setupLabel(text: "전체보기",
                    color: .gray3,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.reviewEntireButton.snp.centerX)
        $0.trailing.equalTo(self.reviewEntireButton.snp.leading).offset(-1)
      }
    }
  }
  func layoutBottomView() {
    view.add(bottomView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-22)
        $0.height.equalTo(73)
      }
    }
  }
  func layoutSavePinButton() {
    bottomView.add(savePinButton) {
      $0.setBackgroundImage(UIImage(named: "iconPinPlus"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.bottomView.snp.top).offset(11)
        $0.leading.equalTo(self.bottomView.snp.leading).offset(25)
        $0.width.height.equalTo(37)
      }
    }
  }
  func layoutSavePinLabel() {
    bottomView.add(savePinLabel) {
      $0.setupLabel(text: "핀저장",
                    color: .pointcolor1,
                    font: .notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.savePinButton.snp.bottom)
        $0.trailing.equalTo(self.savePinButton.snp.trailing)
      }
    }
  }
  func layoutWriteReviewButton() {
    bottomView.add(writeReviewButton) {
      $0.setupButton(title: "리뷰 작성하기",
                     color: .white,
                     font: .notoSansKRMediumFont(fontSize: 16),
                     backgroundColor: .black,
                     state: .normal,
                     radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.savePinButton.snp.top)
        $0.bottom.equalTo(self.savePinLabel.snp.bottom)
        $0.trailing.equalTo(self.bottomView.snp.trailing).offset(-20)
        $0.leading.equalTo(self.savePinButton.snp.trailing).offset(17)
      }
    }
  }
  func layoutReviewTableView() {
    cafeScrollContainerView.add(reviewTableView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.cafeScrollContainerView.snp.leading).offset(15)
        $0.trailing.equalTo(self.cafeScrollContainerView.snp.trailing).offset(-15)
        $0.top.equalTo(self.reviewHeaderView.snp.bottom)
        $0.bottom.equalTo(self.cafeScrollContainerView.snp.bottom)
      }
    }
  }
  
  // MARK: - General Helpers
  func dataBind() {
    
  }
}
