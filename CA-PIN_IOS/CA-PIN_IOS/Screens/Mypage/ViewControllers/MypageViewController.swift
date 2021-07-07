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
    
    //MARK: - Components
    
    let backButton = UIButton()
    let profileContainerView = UIView()
    let profileImageView = UIImageView()
    let hiLabel = UILabel()
    let nicknameLabel = UILabel()
    let cafeTILabel = UILabel()
    let profileEditButton = UIButton()
    let tabbarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let pageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let indicatorView = UIView()
    let pinView = UITableView()
    let reviewView = UITableView()
    
    
    // MARK: - Variables and Properties
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        layout()
        self.tabbarCollectionView.delegate = self
        self.tabbarCollectionView.dataSource = self
        self.pageCollectionView.delegate = self
        self.pageCollectionView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        ///subview들이 자리 잡은 후 레이아웃 조정 필요할 때 (ex. radius 값)
        self.profileImageView.setRounded(radius: self.profileImageView.frame.width/2)
    }
  
}

// MARK: - Extensions
extension MypageViewController {
    // MARK: - Helper
    func register() {
        self.tabbarCollectionView.register(TabbarCollectionViewCell.self, forCellWithReuseIdentifier: TabbarCollectionViewCell.reuseIdentifier)
        self.pageCollectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.reuseIdentifier)
    }
    
    // MARK: - Layout Helper
    func layout() {
        layoutBackButton()
        layoutProfileContainerView()
        layoutProfileImageView()
        layoutHiLabel()
        layoutNicknameLabel()
        layoutCafeTILabel()
        layoutProfileEditButton()
        layoutTabbarCollectionView()
        layoutIndicatorView()
        layoutPageCollectionView()
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
    func layoutTabbarCollectionView() {
        self.view.add(self.tabbarCollectionView) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.profileContainerView.snp.bottom).offset(33)
                $0.leading.equalTo(self.view.snp.leading)
                $0.trailing.equalTo(self.view.snp.trailing)
                $0.width.equalTo(self.screenWidth)
                $0.height.equalTo(self.screenWidth * 33/375)
            }
        }
    }
    func layoutIndicatorView() {
        self.view.add(self.indicatorView) {
            $0.backgroundColor = .brown
            $0.snp.makeConstraints {
                $0.top.equalTo(self.tabbarCollectionView.snp.bottom)
                $0.leading.equalTo(self.view.snp.leading)
                $0.trailing.equalTo(self.view.snp.trailing)
                $0.width.equalTo(self.screenWidth/2)
                $0.height.equalTo(2)
            }
        }
    }
    func layoutPageCollectionView() {
        self.view.add(pageCollectionView) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.indicatorView.snp.bottom)
                $0.leading.equalTo(self.view.snp.leading)
                $0.trailing.equalTo(self.view.snp.trailing)
                $0.bottom.equalTo(self.view.snp.bottom)
            }
        }
    }
}

// MARK: - CollectionView DelegateFlowLayout

extension MypageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.tabbarCollectionView:
            return CGSize(width: self.screenWidth/2, height: collectionView.frame.height)
        case self.pageCollectionView:
            return CGSize(width: self.screenWidth, height: collectionView.frame.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

//MARK: - CollectionViewDataSource

extension MypageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.tabbarCollectionView:
            guard let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionViewCell.reuseIdentifier, for: indexPath) as? TabbarCollectionViewCell else { return UICollectionViewCell() }
            tabBarCell.awakeFromNib()
            return tabBarCell
        case self.pageCollectionView:
            guard let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.reuseIdentifier, for: indexPath) as? PageCollectionViewCell else { return UICollectionViewCell() }
            pageCell.awakeFromNib()
            return pageCell
        default:
            return UICollectionViewCell()
        }
    }
}
