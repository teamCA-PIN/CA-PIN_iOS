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
  var trigger = true
  var profileImage: String = ""
  var plainImage: String = ""
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    register()
    layout()
    self.tabbarCollectionView.delegate = self
    self.tabbarCollectionView.dataSource = self
    self.pageCollectionView.delegate = self
    self.pageCollectionView.dataSource = self
    self.navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    print("MyPageViewController")
    print(#function)
    self.pageCollectionView.reloadData()
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
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
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
      $0.backgroundColor = .white
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
      $0.image = UIImage(named: "colorchip7")
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
      $0.letterSpacing = -0.48
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
      $0.letterSpacing = -1.0
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
        $0.width.equalTo(62)
        $0.leading.equalTo(self.profileImageView.snp.trailing).offset(15)
        $0.bottom.equalTo(self.profileContainerView.snp.bottom).offset(-4)
      }
    }
  }
  func layoutProfileEditButton() {
    self.profileContainerView.add(self.profileEditButton) {
      $0.setupButton(title: "프로필 편집", color: .gray3, font: UIFont.notoSansKRRegularFont(fontSize: 14), backgroundColor: .clear, state: .normal, radius: 14)
      $0.borderColor = .gray3
      $0.borderWidth = 1
      $0.titleLabel?.letterSpacing = -0.6
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
      $0.backgroundColor = .pointcolor1
      $0.snp.makeConstraints {
        $0.width.equalTo(self.screenWidth/2)
        $0.height.equalTo(2)
        $0.top.equalTo(self.tabbarCollectionView.snp.bottom)
        $0.leading.equalTo(self.view.snp.leading)
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
  func categorySelected() {
    NotificationCenter.default.post(name: NSNotification.Name("categorySelect"), object: nil)
    self.pageCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
    self.indicatorView.snp.remakeConstraints {
      $0.width.equalTo(self.screenWidth/2)
      $0.height.equalTo(2)
      $0.top.equalTo(self.tabbarCollectionView.snp.bottom)
      $0.leading.equalTo(self.view.snp.leading)
    }
  }
  func reviewSelected() {
    NotificationCenter.default.post(name: NSNotification.Name("reviewSelect"), object: nil)
    self.pageCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 1) as IndexPath, at: .left, animated: true)
    self.indicatorView.snp.remakeConstraints {
      $0.width.equalTo(self.screenWidth/2)
      $0.height.equalTo(2)
      $0.top.equalTo(self.tabbarCollectionView.snp.bottom)
      $0.trailing.equalTo(self.view.snp.trailing)
    }
  }
  @objc func backButtonClicked() {
    self.dismiss(animated: true, completion: nil)
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
  
  /// 왼쪽 or 오른쪽으로 스와이프 하면
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
      
      switch currentIndex {
      case 0:
        self.trigger = true
        self.tabbarCollectionView.reloadData()
        self.categorySelected()
      case 1:
        self.trigger = false
        self.tabbarCollectionView.reloadData()
        self.reviewSelected()
      default: break
      }
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
    if collectionView == pageCollectionView {
      return 1
    }
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    /// 탭바컬렉션뷰일 때
    case self.tabbarCollectionView:
      guard let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionViewCell.reuseIdentifier, for: indexPath) as? TabbarCollectionViewCell else { return UICollectionViewCell() }
      tabBarCell.awakeFromNib()
      if trigger == true { /// 카테고리 탭 선택됐을 때
        if indexPath.item == 0 { /// 카테고리 아이콘 갈색
          tabBarCell.setImage(name: "iconPinActive")
        }
        else { /// 리뷰 아이콘 회색
          tabBarCell.setImage(name: "iconError2")
        }
      }
      else { /// 리뷰 탭 선택됐을 때
        if indexPath.item == 0 { /// 카테고리 아이콘 회색
          tabBarCell.tabImageView.image = UIImage(named: "iconPin")
        }
        else { /// 리뷰 아이콘 갈색
          tabBarCell.tabImageView.image = UIImage(named: "iconReviewActive")
        }
      }
      
      return tabBarCell
    /// 페이지 컬렉션뷰일 때
    case self.pageCollectionView:
      if indexPath.section == 0 {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCategoryCollectionViewCell else { return UICollectionViewCell() }
        categoryCell.awakeFromNib()
        categoryCell.backgroundColor = .white
        return categoryCell
      } else {
        guard let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyReviewCollectionViewCell.reuseIdentifier, for: indexPath) as? MyReviewCollectionViewCell else { return UICollectionViewCell() }
        reviewCell.awakeFromNib()
        reviewCell.backgroundColor = .white
        return reviewCell
      }
    default: return UICollectionViewCell()
    }
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let tabBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionViewCell.reuseIdentifier, for: indexPath) as? TabbarCollectionViewCell else { return }
    tabBarCell.awakeFromNib()
    if collectionView == tabbarCollectionView {
      if indexPath.item == 0 {
        trigger = true
        tabbarCollectionView.reloadData()
        categorySelected()
      }
      if indexPath.item == 1 {
        trigger = false
        tabbarCollectionView.reloadData()
        reviewSelected()
      }
    }
  }
}

extension MypageViewController: PagingTabbarDelegate {
  func scrollToIndex(to index: Int) {
    pageCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
  }
}
