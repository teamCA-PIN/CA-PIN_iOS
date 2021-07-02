//
//  MypageViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import SnapKit
import Then

// MARK: - MypageViewController
class MypageViewController: UIViewController {
    // MARK: - Components
    let backButton = UIButton()
    let profileContainerView = UIView()
    let profileImageView = UIImageView()
    let hiLabel = UILabel()
    let nicknameLabel = UILabel()
    let cafeTILabel = UILabel()
    let profileEditButton = UIButton()
//    let tabBarCollectionView = UICollectionView()
//    let pageCollectionView = UICollectionView()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    self.navigationController?.navigationBar.isHidden = true
  }
  
}

// MARK: - Extensions
extension MypageViewController {
    
    // MARK: - Layout Helper
    func layout() {
        layoutBackButton()
        layoutProfileContainerView()
        layoutProfileImageView()
        layoutHiLabel()
        layoutNicknameLabel()
        layoutCafeTILabel()
        layoutProfileEditButton()
        
    }
    func layoutBackButton() {
        self.view.add(self.backButton) {
            $0.setImage(UIImage(named: "logo"), for: .normal)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(11)
                $0.trailing.equalTo(self.view.snp.trailing).offset(-21)
                $0.width.equalTo(30)
                $0.height.equalTo(30)
            }
        }
    }
    func layoutProfileContainerView() {
        self.view.add(self.profileContainerView) {
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.backButton.snp.bottom).offset(17)
                $0.leading.equalTo(self.view.snp.leading).offset(20)
                $0.trailing.equalTo(self.view.snp.trailing).offset(-21)
                $0.height.equalTo(90)
            }
        }
    }
    func layoutProfileImageView() {
        self.profileContainerView.add(self.profileImageView) {
            $0.setRounded(radius: 45)
            $0.image = UIImage(named: "logo")
            $0.snp.makeConstraints {
                $0.top.equalTo(self.profileContainerView.snp.top)
                $0.leading.equalTo(self.profileContainerView.snp.leading)
                $0.bottom.equalTo(self.profileContainerView.snp.bottom)
                $0.width.equalTo(self.profileImageView.snp.width)
                $0.height.equalTo(self.profileImageView.snp.width)
            }
        }
    }
    func layoutHiLabel() {
        self.profileContainerView.add(self.hiLabel) {
            $0.setupLabel(text: "안녕하세요", color: .gray, font: UIFont.systemFont(ofSize: 16))
            $0.snp.makeConstraints {
                $0.height.equalTo(23)
                $0.top.equalTo(self.profileContainerView.snp.top).offset(7)
                $0.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
            }
        }
    }
    func layoutNicknameLabel() {
        self.profileContainerView.add(self.nicknameLabel) {
            $0.setupLabel(text: "김카핀님", color: .brown, font: UIFont.systemFont(ofSize: 20))
            $0.snp.makeConstraints {
                $0.height.equalTo(27)
                $0.top.equalTo(self.hiLabel.snp.bottom)
                $0.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
            }
        }
    }
    func layoutCafeTILabel() {
        self.profileContainerView.add(self.cafeTILabel) {
            $0.setupLabel(text: "WBFJ", color: .white, font: UIFont.systemFont(ofSize: 12), align: .center)
            $0.backgroundColor = .brown
            $0.setRounded(radius: 10)
            $0.snp.makeConstraints {
                $0.height.equalTo(17)
                $0.width.equalTo(54)
                $0.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
                $0.bottom.equalTo(self.profileContainerView.snp.bottom).offset(-4)
            }
        }
    }
    func layoutProfileEditButton() {
        self.profileContainerView.add(self.profileEditButton) {
            $0.setupButton(title: "프로필 편집", color: .gray, font: UIFont.systemFont(ofSize: 14), backgroundColor: .clear, state: .normal, radius: 15)
            $0.borderColor = .gray
            $0.borderWidth = 2
            $0.snp.makeConstraints {
                $0.height.equalTo(28)
                $0.width.equalTo(80)
                $0.top.equalTo(self.profileContainerView.snp.top).offset(-7)
                $0.trailing.equalTo(self.profileContainerView.snp.trailing)
            }
        }
    }
}
