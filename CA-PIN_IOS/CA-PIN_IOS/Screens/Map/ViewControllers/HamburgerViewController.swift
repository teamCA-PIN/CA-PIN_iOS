//
//  HamburgerViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/01.
//

import UIKit

import Kingfisher
import Moya
import RxMoya
import RxSwift
import SnapKit
import SwiftyColor
import Then

// MARK: - HamburgerViewController
class HamburgerViewController: UIViewController {
  
  // MARK: - Components
  let closeButton = UIButton()
  let profileImageView = UIImageView()
  let profileNameLabel = UILabel()
  let profileEmailLabel = UILabel()
  let cafetiContainerView = UIView()
  let cafetiLabel = UILabel()
  let archiveContainerView = UIView()
  let archiveTitleLabel = UILabel()
  let archiveNextButton = UIButton()
  let archivePinTitleLabel = UILabel()
  let archivePinContentLabel = UILabel()
  let archiveFeedTitleLabel = UILabel()
  let archiveFeedContentLabel = UILabel()
  let policyButton = UIButton()
  let logoutButton = UIButton()
  let copyrightLabel = UILabel()
  
  let disposeBag = DisposeBag()
  let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  
  var infoData: MyInfo?
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super .viewWillAppear(true)
    loadInfoData()
  }
}

// MARK: - Extensions
extension HamburgerViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = 0xDCECF5.color
    layoutCloseButton()
    layoutProfileImageView()
    layoutProfileNameLabel()
    layoutProfileEmailLabel()
    layoutCafetiContainerLabel()
    layoutCafetiLabel()
    layoutArchiveContainerView()
    layoutArchiveTitleLabel()
    layoutArchiveNextButton()
    layoutArchivePinTitleLabel()
    layoutArchivePinContentLabel()
    layoutArchiveFeedTitleLabel()
    layoutArchiveFeedContentLabel()
    layoutPolicyButton()
    layoutLogoutButton()
    layoutCopyrightLabel()
  }
  func layoutCloseButton() {
    view.add(closeButton) {
      $0.setBackgroundImage(UIImage(named:"iconCloseWhite"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedCloseButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.width.height.equalTo(30)
      }
    }
  }
  func layoutProfileImageView() {
    view.add(profileImageView) {
      $0.image = UIImage(named: "profile")
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.closeButton.snp.bottom).offset(68)
        $0.width.equalTo(self.view.frame.width * 160/375)
        $0.height.equalTo(self.view.frame.width * 144/375)
      }
    }
  }
  func layoutProfileNameLabel() {
    view.add(profileNameLabel) {
      $0.setupLabel(text: "김카핀", color: .black,
                    font: .notoSansKRRegularFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.profileImageView.snp.bottom).offset(15)
      }
    }
  }
  func layoutProfileEmailLabel() {
    view.add(profileEmailLabel) {
      $0.setupLabel(text: "capin@naver.com", color: 0x878787.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.profileNameLabel.snp.bottom).offset(3)
      }
    }
  }
  func layoutCafetiContainerLabel() {
    view.add(cafetiContainerView) {
      $0.backgroundColor = 0xA98E7A.color
      $0.setRounded(radius: 4)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.profileEmailLabel.snp.bottom).offset(11)
        $0.width.equalTo(self.view.frame.width * 54/375)
        $0.height.equalTo(self.view.frame.width * 18/375)
      }
    }
  }
  func layoutCafetiLabel() {
    cafetiContainerView.add(cafetiLabel) {
      $0.setupLabel(text: "WBFJ", color: .white, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
  func layoutArchiveContainerView() {
    view.add(archiveContainerView) {
      $0.backgroundColor = .white
      $0.setRounded(radius: 10)
      $0.applyShadow(color: 0xbddced.color, alpha: 1, x: 2, y: 4, blur: 10)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.cafetiContainerView.snp.bottom).offset(40)
        $0.width.equalTo(self.view.frame.width * 200/375)
        $0.height.equalTo(self.view.frame.width * 115/375)
      }
    }
  }
  func layoutArchiveTitleLabel() {
    archiveContainerView.add(archiveTitleLabel) {
      $0.setupLabel(text: "아카이브", color: 0xA98E7A.color,
                    font: .notoSansKRMediumFont(fontSize: 16))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.archiveContainerView.snp.top).offset(20)
        $0.leading.equalTo(self.archiveContainerView.snp.leading).offset(23)
      }
    }
  }
  func layoutArchiveNextButton() {
    archiveContainerView.add(archiveNextButton) {
      $0.setBackgroundImage(UIImage(named: "iconBack"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedNextButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.archiveTitleLabel.snp.centerY)
        $0.trailing.equalTo(self.archiveContainerView.snp.trailing).offset(-20)
        $0.height.equalTo(20)
        $0.width.equalTo(15)
      }
    }
  }
  func layoutArchivePinTitleLabel() {
    archiveContainerView.add(archivePinTitleLabel) {
      $0.setupLabel(text: "핀",
                    color: .black,
                    font: .notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.archiveTitleLabel.snp.leading)
        $0.top.equalTo(self.archiveTitleLabel.snp.bottom).offset(17)
      }
    }
  }
  func layoutArchivePinContentLabel() {
    archiveContainerView.add(archivePinContentLabel) {
      $0.setupLabel(text: "25",
                    color: 0x91C2DE.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.archivePinTitleLabel.snp.centerY)
        $0.trailing.equalTo(self.archiveNextButton.snp.trailing)
      }
    }
  }
  func layoutArchiveFeedTitleLabel() {
    archiveContainerView.add(archiveFeedTitleLabel) {
      $0.setupLabel(text: "피드",
                    color: .black,
                    font: .notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.archivePinTitleLabel.snp.leading)
        $0.top.equalTo(self.archivePinTitleLabel.snp.bottom).offset(3)
      }
    }
  }
  func layoutArchiveFeedContentLabel() {
    archiveContainerView.add(archiveFeedContentLabel) {
      $0.setupLabel(text: "17",
                    color: 0x91C2DE.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.archivePinContentLabel.snp.trailing)
        $0.centerY.equalTo(self.archiveFeedTitleLabel.snp.centerY)
      }
    }
  }
  func layoutPolicyButton() {
    view.add(policyButton) {
      $0.setupButton(title: "약관 및 정책",
                     color: 0xA98E7A.color,
                     font: .notoSansKRRegularFont(fontSize: 14),
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedTermsButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.archiveContainerView.snp.bottom).offset(56)
        $0.width.equalTo(self.view.frame.width * 67/375)
        $0.height.equalTo(self.view.frame.width * 21/375)
      }
      if $0.titleLabel?.adjustsFontSizeToFitWidth == false {
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
      }
    }
  }
  func layoutLogoutButton() {
    view.add(logoutButton) {
      $0.setupButton(title: "로그아웃",
                     color: 0xA98E7A.color,
                     font: .notoSansKRRegularFont(fontSize: 14),
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.policyButton.snp.bottom).offset(6)
        $0.width.equalTo(self.view.frame.width * 50/375)
        $0.height.equalTo(self.view.frame.width * 21/375)
      }
      if $0.titleLabel?.adjustsFontSizeToFitWidth == false {
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
      }
    }
  }
  func layoutCopyrightLabel() {
    view.add(copyrightLabel) {
      $0.setupLabel(text: "copyright CA:PIN",
                    color: 0x98E7A.color,
                    font: .notoSansKRRegularFont(fontSize: 8))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.logoutButton.snp.bottom).offset(84)
      }
    }
  }
  
  // MARK: - General Helpers
  @objc func clickedCloseButton() {
    self.navigationController?.popViewController(animated: true)
  }
  @objc func clickedTermsButton() {
    let termsVC = TermsViewController()
    self.navigationController?.pushViewController(termsVC, animated: false)
  }
  @objc func clickedNextButton() {
    let mypageVC = MypageViewController()
    mypageVC.userName = self.infoData!.nickname
    mypageVC.profileImage = self.infoData!.profileImg
    mypageVC.cafeTI = self.infoData!.cafeti.type
    mypageVC.plainImage = self.infoData!.cafeti.plainImg
    let mypageNavigation = UINavigationController()
    mypageNavigation.modalPresentationStyle = .currentContext
    mypageNavigation.addChild(mypageVC)
    self.present(mypageNavigation, animated: false, completion: nil)
  }
  func loadInfoData() {
    userProvider.rx.request(.myInfo)
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(MyInfoResponseType<MyInfo>.self,
                                          from: response.data)
            print(data)
            self.infoData = data.myInfo
            self.infoDataBind()
            self.reloadInputViews()
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  func infoDataBind() {
//    self.profileImageView.setImage(from: self.infoData?.profileImg ?? "", UIImage(named: "image176")!)
    self.profileImageView.imageFromUrl(self.infoData?.profileImg ?? "", defaultImgPath: self.infoData?.cafeti.plainImg ?? "")
    self.profileImageView.setRounded(radius: self.profileImageView.frame.height/2)
    self.profileNameLabel.text = self.infoData?.nickname
    self.profileEmailLabel.text = self.infoData?.email
    self.cafetiLabel.text = self.infoData?.cafeti.type
    self.archivePinContentLabel.text = "\(self.infoData?.pinNum ?? 0)"
    self.archiveFeedContentLabel.text = "\(self.infoData?.reviewNum ?? 0)"
  }
}

struct MyInfoResponseType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var myInfo: T?
}
