//
//  MypageViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import SnapKit
import Then

protocol PagingTabbarDelegate {
  func scrollToIndex(to index: Int)
}

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
    collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
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
  
  
  // MARK: - Variables
  
  let screenWidth = UIScreen.main.bounds.width
  let screenHeight = UIScreen.main.bounds.height
  var userName: String = "김카핀"
  var cafeTI: String = "WBFJ"
  
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
    self.pageCollectionView.register(MyCategoryCollectionViewCell.self, forCellWithReuseIdentifier: MyCategoryCollectionViewCell.reuseIdentifier)
    self.pageCollectionView.register(MyReviewCollectionViewCell.self, forCellWithReuseIdentifier: MyReviewCollectionViewCell.reuseIdentifier)
  }
  func scroll(to index: Int) {
      tabbarCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: [])
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
      $0.setImage(UIImage(named: "iconCloseBlack"), for: .normal)
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
      $0.setupLabel(text: "안녕하세요", color: .gray3, font: UIFont.notoSansKRRegularFont(fontSize: 16))
      $0.snp.makeConstraints {
        $0.height.equalTo(23)
        $0.top.equalTo(self.profileContainerView.snp.top).offset(7)
        $0.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
      }
    }
  }
  func layoutNicknameLabel() {
    self.profileContainerView.add(self.nicknameLabel) {
      var nickname = self.userName + "님"
      $0.setupLabel(text: nickname, color: .subcolorBrown4, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      let fontSize = UIFont.notoSansKRRegularFont(fontSize: 20)
      let attributedString = NSMutableAttributedString(string: $0.text ?? "")
      attributedString.addAttribute(.font, value: fontSize, range: (nickname as NSString).range(of: "님"))
      attributedString.addAttribute(.foregroundColor, value: UIColor.gray3, range: (nickname as NSString).range(of: "님"))
      $0.attributedText = attributedString
      $0.snp.makeConstraints {
        $0.height.equalTo(27)
        $0.top.equalTo(self.hiLabel.snp.bottom)
        $0.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
      }
    }
  }
  func layoutCafeTILabel() {
    self.profileContainerView.add(self.cafeTILabel) {
      $0.setupLabel(text: self.cafeTI, color: .white, font: UIFont.notoSansKRRegularFont(fontSize: 12), align: .center)
      $0.backgroundColor = .pointcolor1
      $0.setRounded(radius: 9)
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
      $0.setupButton(title: "프로필 편집", color: .gray3, font: UIFont.notoSansKRRegularFont(fontSize: 12), backgroundColor: .clear, state: .normal, radius: 14)
      $0.borderColor = .gray3
      $0.borderWidth = 1
      $0.snp.makeConstraints {
        $0.height.equalTo(28)
        $0.width.equalTo(80)
        $0.top.equalTo(self.profileContainerView.snp.top).offset(7)
        $0.trailing.equalTo(self.profileContainerView.snp.trailing)
      }
    }
  }
  func layoutTabbarCollectionView() {
    self.view.add(self.tabbarCollectionView) {
      $0.backgroundColor = .white
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
      $0.backgroundColor = .white
      $0.isPagingEnabled = true
      $0.showsHorizontalScrollIndicator = false
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
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
  }
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let page = Int(targetContentOffset.pointee.x / scrollView.frame.width)
    
    print(page)
//    categoryTabbarView.scroll(to: page)
  }
}

//MARK: - CollectionViewDataSource

extension MypageViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    switch collectionView {
    case self.tabbarCollectionView: return 1
    case self.pageCollectionView: return 2
    default: return 0
    }
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    /// 탭바컬렉션뷰일 때
    case self.tabbarCollectionView:
      guard let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionViewCell.reuseIdentifier, for: indexPath) as? TabbarCollectionViewCell else { return UICollectionViewCell() }
      tabBarCell.awakeFromNib()
      return tabBarCell
    /// 페이지 컬렉션뷰일 때
    case self.pageCollectionView:
      guard let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.reuseIdentifier, for: indexPath) as? PageCollectionViewCell else { return UICollectionViewCell() }
      if indexPath.section == 0 {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCategoryCollectionViewCell else { return UICollectionViewCell() }
        categoryCell.awakeFromNib()
        categoryCell.backgroundColor = .red
        return categoryCell
      } else {
        guard let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyReviewCollectionViewCell.reuseIdentifier, for: indexPath) as? MyReviewCollectionViewCell else { return UICollectionViewCell() }
        reviewCell.awakeFromNib()
        reviewCell.backgroundColor = .brown
        return reviewCell
      }
//      return pageCell
    default: return UICollectionViewCell()
    }
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == tabbarCollectionView {
      scrollToIndex(to: indexPath.row)
    }
  }
}

extension MypageViewController: PagingTabbarDelegate {
  func scrollToIndex(to index: Int) {
      pageCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
  }
}
