//
//  MypageViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit
import Moya
import RxMoya
import RxSwift
import SnapKit
import SwiftKeychainWrapper
import Then

protocol PagingTabbarDelegate {
  func scrollToIndex(to index: Int)
}

// MARK: - MypageViewController
class MypageViewController: UIViewController {
  
  //MARK: - Components
  
  let backButton = UIButton()
  let profileImageView = UIImageView()
  let buttonContainerView = UIView()
  let nicknameLabel = UILabel()
  let cafeTILabel = UILabel()
  let cafeTITestButton = UIButton()
  let buttonIndicatorView = UIView()
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
  var cafetiJudgedata : Int = 1
  
  let disposeBag = DisposeBag()
  private let UserServiceProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  
  // MARK: - Variables
  
  let screenWidth = UIScreen.main.bounds.width
  let screenHeight = UIScreen.main.bounds.height
  var userName: String = ""
  var cafeTI: String = ""
  var trigger = true
  var profileImage: String = ""
  var plainImage: String = ""
  
  var reviewList: [Review]? /// 서버에서 리뷰 받아올 배열
  var cafeNameList: [String] = [] /// 서버에서 받아온 값 중에 카페 이름만 저장
  var ratingList: [Double] = [] /// 서버에서 별점 값만ㄴ 받아올 배열
  var cafeIdList: [String] = [] /// 서버에서 카페 어이디만 받아올 배열
  
  var categoryArray: [MyCategoryList] = [] /// 서버통신해서 카테고리 배열을 받아온다
  var categoryIdArray: [String] = [] /// 카테고리 아이디를 저장해놓는 배열 -> 카테고리 상세 페이지로 넘어갈 때 사용할 파라미터
  
  var loginVCFlag: Int = 2
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loadInfoData()
    bindMyData()
    getCategoryListService()
    getReviewListService()
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
    print(#function)
    loadInfoData()
    print(self.cafeTI)
    print(self.profileImage)
    bindMyData()
    getCategoryListService()
    getReviewListService()
  }
  
  override func viewDidLayoutSubviews() {
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
  func loadInfoData() {
    UserServiceProvider.rx.request(.myInfo)
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(MyInfoResponseType<MyInfo>.self,
                                          from: response.data)
            self.userName = data.myInfo?.nickname ?? ""
            self.profileImage = data.myInfo?.profileImg ?? ""
            self.plainImage = data.myInfo?.cafeti.plainImg ?? ""
            self.nicknameLabel.text = self.userName
            self.cafeTILabel.text = data.myInfo?.cafeti.type ?? ""
            self.profileImageView.imageFromUrl(self.profileImage, defaultImgPath: "")
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  func bindMyData() {
    self.nicknameLabel.text = userName
    self.profileImageView.imageFromUrl(profileImage, defaultImgPath: "")
  }
  func getCategoryListService() {
    UserServiceProvider.rx.request(.categoryList(cafeID: nil))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(CategoryResponseArrayType<MyCategoryList>.self,
                                          from: response.data)
            self.categoryArray = data.myCategoryList!
            self.categoryIdArray = []
            for i in 0...self.categoryArray.count-1 {
              self.categoryIdArray.append(self.categoryArray[i].id)
            }
            self.pageCollectionView.reloadData()
            
          } catch {
            print(error)
          }
        }
        else {
          
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
  }
  func getReviewListService() {
    UserServiceProvider.rx.request(.reviews)
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ReviewResponseArrayType<Review>.self,
                                          from: response.data)
            self.reviewList = data.reviews!
            self.cafeNameList = []
            self.ratingList = []
            self.cafeIdList = []
            if let reviewList = self.reviewList {
              for i in 0..<reviewList.count {
                self.cafeNameList.append(reviewList[i].cafeName)
                self.ratingList.append(reviewList[i].rating)
                self.cafeIdList.append(reviewList[i].cafeID)
              }
            }
            self.pageCollectionView.reloadData()
          } catch {
            print(error)
          }
        }
        else if response.statusCode == 204 {
          self.reviewList = []
          self.pageCollectionView.reloadData()
        }
        else {
          
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
  }
  // MARK: - Layout Helper
  func layout() {
    layoutBackButton()
    layoutProfileImageView()
    layoutNicknameLabel()
    layoutCafeTILabel()
    layoutButtonContainerView()
    layoutCafeTITestButton()
    layoutButtonIndicatorView()
    layoutProfileEditButton()
    layoutTabbarCollectionView()
    layoutIndicatorView()
    layoutPageCollectionView()
  }
  func layoutBackButton() {
    view.add(backButton) {
      $0.setImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(51)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.width.height.equalTo(28)
      }
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
    }
  }
  func layoutProfileImageView() {
    self.view.add(self.profileImageView) {
      print("profileimage")
      print(self.profileImage)
        $0.imageFromUrl(self.profileImage, defaultImgPath: "colorchip7")
        $0.snp_makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(54)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }
  }
  func layoutNicknameLabel() {
    self.view.add(self.nicknameLabel) {
      print("nickname")
      print(self.userName)
      $0.setupLabel(text: self.userName, color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.height.equalTo(29)
        $0.top.equalTo(self.profileImageView.snp.bottom).offset(9)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCafeTILabel() {
    self.view.add(self.cafeTILabel) {
      $0.setupLabel(text: self.cafeTI, color: .maincolor1, font: UIFont.notoSansKRRegularFont(fontSize: 12), align: .center)
      $0.letterSpacing = -0.3
      $0.snp.makeConstraints {
        $0.height.equalTo(14)
        $0.top.equalTo(self.nicknameLabel.snp.bottom).offset(3)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutButtonContainerView() {
    self.view.add(self.buttonContainerView) {
      $0.borderWidth = 1
      $0.borderColor = .gray3
      $0.setRounded(radius: 15)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.cafeTILabel.snp.bottom).offset(19)
        $0.height.equalTo(32)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(58)
      }
    }
  }
  func layoutCafeTITestButton() {
    self.buttonContainerView.add(self.cafeTITestButton) {
      $0.setupButton(title: "카페TI 검사", color: .black, font: UIFont.notoSansKRRegularFont(fontSize: 12), backgroundColor: .clear, state: .normal, radius: 0)
      $0.titleLabel?.letterSpacing = -0.6
      let leading = (self.screenWidth - 58*4 - 3) / 4
      $0.snp.makeConstraints {
        $0.width.equalTo(58)
        $0.height.equalTo(21)
        $0.centerY.equalToSuperview()
        $0.leading.equalToSuperview().offset(leading)
      }
      $0.addTarget(self, action: #selector(self.cafeTITestButtonClicked), for: .touchUpInside)
    }
  }
  func layoutButtonIndicatorView() {
    self.buttonContainerView.add(self.buttonIndicatorView) {
      $0.backgroundColor = .gray3
      $0.snp.makeConstraints {
        $0.centerX.centerY.equalToSuperview()
        $0.width.equalTo(1)
        $0.height.equalTo(15)
      }
    }
  }
  func layoutProfileEditButton() {
    self.buttonContainerView.add(self.profileEditButton) {
      $0.setupButton(title: "프로필 편집", color: .black, font: UIFont.notoSansKRRegularFont(fontSize: 12), backgroundColor: .clear, state: .normal, radius: 0)
      $0.titleLabel?.letterSpacing = -0.6
        let trailing = (self.screenWidth - 58*4 - 3) / 4
      $0.snp.makeConstraints {
        $0.height.equalTo(21)
        $0.width.equalTo(58)
        $0.centerY.equalToSuperview()
        $0.trailing.equalToSuperview().offset(-trailing)
      }
      $0.addTarget(self, action: #selector(self.profileEditButtonClicked), for: .touchUpInside)
    }
  }
  func layoutTabbarCollectionView() {
    self.view.add(self.tabbarCollectionView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.bottom).offset(32)
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
    var mapVC = self.navigationController?.children[1] as? MapViewController

    loginVCFlag = KeychainWrapper.standard.integer(forKey: "loginVCFlag") ?? 2
    
    if loginVCFlag == 0 {
      if let vc = mapVC {
        self.navigationController?.popToViewController(vc, animated: true)
      }
    } else {
      mapVC = self.navigationController?.children[2] as? MapViewController
      if let vc = mapVC {
        self.navigationController?.popToViewController(vc, animated: true)
      }
    }
  }
  @objc func cafeTITestButtonClicked() {
    let cafetiVC = CafeTIViewController()
    cafetiVC.cafetiJudgeData = self.cafetiJudgedata
    self.navigationController?.pushViewController(cafetiVC, animated: true)
  }
  @objc func profileEditButtonClicked() {
    let vc = EditProfileViewController()
    vc.profileImage = self.profileImage
    vc.userName = self.userName
    vc.plainImage = self.plainImage
    self.navigationController?.pushViewController(vc, animated: true)
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
          tabBarCell.setImage(name: "mapActiveFrame")
        }
        else { /// 리뷰 아이콘 회색
          tabBarCell.setImage(name: "reviewInactiveFrame")
        }
      }
      else { /// 리뷰 탭 선택됐을 때
        if indexPath.item == 0 { /// 카테고리 아이콘 회색
          tabBarCell.tabImageView.image = UIImage(named: "mapInactiveFrame")
        }
        else { /// 리뷰 아이콘 갈색
          tabBarCell.tabImageView.image = UIImage(named: "reviewActiveFrame")
        }
      }
      return tabBarCell
    /// 페이지 컬렉션뷰일 때
    case self.pageCollectionView:
      if indexPath.section == 0 {
        guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCategoryCollectionViewCell else { return UICollectionViewCell() }
        categoryCell.rootViewController = self
      
        categoryCell.backgroundColor = .white
        categoryCell.categoryArray = self.categoryArray
        categoryCell.categoryIdArray = self.categoryIdArray
        categoryCell.awakeFromNib()
        return categoryCell
      } else {
        guard let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyReviewCollectionViewCell.reuseIdentifier, for: indexPath) as? MyReviewCollectionViewCell else { return UICollectionViewCell() }
        reviewCell.rootViewController = self
        if let reviewList = reviewList {
          reviewCell.reviewList = reviewList
        }
        reviewCell.cafeIdLIst = self.cafeIdList
        reviewCell.backgroundColor = .white
        reviewCell.awakeFromNib()
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
