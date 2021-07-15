//
//  CafeDetailViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/07.
//

import UIKit

import CollectionViewCenteredFlowLayout
import Moya
import RxMoya
import RxSwift
import SnapKit
import Then

// MARK: - CafeDetailViewController
class CafeDetailViewController: UIViewController {
  
  // MARK: - Components
  let cafeScrollView = UIScrollView()
  let cafeScrollContainerView = UIView()
  let navigationView = UIView()
  let backButton = UIButton()
  let titleLabel = UILabel()
  let bannerImageView = UIImageView()
  let titleContainerView = UIView()
  let cafeTitleLabel = UILabel()
  let starImageView = UIImageView()
  let starRatingLabel = UILabel()
  let addressLabel = UILabel()
  let tagCollectionView: UICollectionView = {
    let layout = CollectionViewCenteredFlowLayout()
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
  
  let gradationBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
  let gradationWhiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
  
  var rating: Float?
  var isSaved: Bool?
  var threshold = true
  
  let disposeBag = DisposeBag()
  let reviewProvider = MoyaProvider<ReviewService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  //  var cafeModel: CafeDetail = CafeDetail(tags: [Tag(id: "a", name: "커피맛집"),
  //                                                Tag(id: "b", name: "디저트맛집"),
  //                                                Tag(id: "c", name: "그루비"),
  //                                                Tag(id: "d", name: "작업하기좋은"),
  //                                                Tag(id: "e", name: "조용한"),
  //                                                Tag(id: "f", name: "친절한"),
  //                                                Tag(id: "g", name: "채광좋은"),],
  //                                         offday: [0],
  //                                         id: "1",
  //                                         name: "후엘고",
  //                                         cafeImg: "adsf",
  //                                         address: "서울 마포구 마포대로11길 118 1층 (염리동)",
  //                                         latitude: 123,
  //                                         longitude: 213,
  //                                         insta: "@huelgocoffee",
  //                                         opentime: "11:00",
  //                                         closetime: "22:00",
  //                                         isSaved: true,
  //                                         rating: 4.5)
  var cafeModel: CafeServerDetail?
  var reviewModel: [ServerReview]?
  var isReviewed: Bool?
  var offdays = ["일요일 휴무",
                 "월요일 휴무",
                 "화요일 휴무",
                 "수요일 휴무",
                 "목요일 휴무",
                 "금요일 휴무",
                 "토요일 휴무"]
  
  var count138 = 0
  var count160 = 0
  var count218 = 0
  var count240 = 0
  
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.setupReviewData(cafeId: self.cafeModel!.id)
    dataBind()
    register()
    layout()
    self.tagCollectionView.delegate = self
    self.tagCollectionView.dataSource = self
    self.reviewTableView.delegate = self
    self.reviewTableView.dataSource = self
    self.cafeScrollView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  
  }
  
  override func viewWillLayoutSubviews() {
    super.updateViewConstraints()
    self.reviewTableView.heightConstraint?.constant = self.reviewTableView.contentSize.height
  }
}

// MARK: - Extensions
extension CafeDetailViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    layoutCafeScrollView()
    layoutCafeScrollContainerView()
    layoutBannerImageView()
    layoutNavigationView()
    layoutTitleLabel()
    layoutBackButton()
    layoutTitleContainerView()
    layoutCafeTitleLabel()
    layoutStarRatingLabel()
    layoutStarImageView()
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
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.width.equalTo(self.view.frame.width)
        $0.top.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
  }
  func layoutCafeScrollContainerView() {
    cafeScrollView.add(cafeScrollContainerView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .clear
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints {
        $0.centerX.top.leading.equalToSuperview()
        $0.bottom.equalTo(self.cafeScrollView.contentLayoutGuide.snp.bottom)
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
  func layoutNavigationView() {
    view.add(navigationView) {
      $0.snp.makeConstraints {
        $0.top.leading.trailing.equalToSuperview()
        $0.height.equalTo(100)
      }
    }
  }
  func layoutTitleLabel() {
    navigationView.add(titleLabel) {
      $0.isHidden = true
      $0.snp.makeConstraints {
        $0.bottom.equalTo(self.navigationView.snp.bottom).offset(-9)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutBackButton() {
    navigationView.add(backButton) {
      $0.setBackgroundImage(UIImage(named: "iconBackWhite"), for: .normal)
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.addTarget(self, action: #selector(self.clickedBackButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.titleLabel.snp.centerY)
        $0.leading.equalTo(self.navigationView.snp.leading).offset(20)
        $0.width.height.equalTo(28)
      }
    }
  }
  func layoutTitleContainerView() {
    cafeScrollContainerView.add(titleContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.bannerImageView.snp.bottom)
        $0.leading.equalTo(self.cafeScrollContainerView.snp.leading)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(156)
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
      $0.image = UIImage(named: "star")
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.starRatingLabel.snp.leading).offset(-6)
        $0.centerY.equalTo(self.starRatingLabel.snp.centerY)
        $0.width.height.equalTo(16)
      }
    }
  }
  func layoutStarRatingLabel() {
    titleContainerView.add(starRatingLabel) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.cafeTitleLabel.snp.bottom).offset(15)
        $0.leading.equalTo(self.titleContainerView.snp.centerX).offset(-10)
      }
    }
  }
  func layoutAddressLabel() {
    titleContainerView.add(addressLabel) {
      $0.numberOfLines = 0
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.starImageView.snp.bottom).offset(13)
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
        $0.centerY.equalTo(self.instagramLogoImageView.snp.centerY)
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
      $0.image = UIImage(named: "iconCafeMenu")
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.instagramLogoImageView.snp.leading)
        $0.top.equalTo(self.clockImageView.snp.bottom).offset(18)
        $0.height.width.equalTo(24)
      }
    }
  }
  func layoutMenuButton() {
    informationView.add(menuButton) {
      $0.setupButton(title: "메뉴 상세보기",
                     color: .gray4,
                     font: .notoSansKRRegularFont(fontSize: 14),
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.clickedMenuButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.menuImageView.snp.centerY)
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
        $0.trailing.equalTo(self.cafeScrollContainerView.snp.trailing).offset(-15)
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
      $0.setupLabel(text: "전체 리뷰",
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
      $0.setBackgroundImage(UIImage(named: "iconNextbtn"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedEntireReviewButton), for: .touchUpInside)
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
        $0.centerY.equalTo(self.reviewEntireButton.snp.centerY)
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
      $0.setBackgroundImage(UIImage(named: "iconPinplusActive"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedAddPinButton), for: .touchUpInside)
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
      $0.addTarget(self, action: #selector(self.clickedWriteReviewButton), for: .touchUpInside)
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
      $0.estimatedRowHeight = 300
      $0.isScrollEnabled = false
      $0.rowHeight = UITableView.automaticDimension
      $0.separatorStyle = .singleLine
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.cafeScrollContainerView.snp.leading).offset(15)
        $0.trailing.equalTo(self .cafeScrollContainerView.snp.trailing).offset(-15)
        $0.top.equalTo(self.reviewHeaderView.snp.bottom)
        $0.bottom.equalTo(self.cafeScrollContainerView.snp.bottom).offset(-50)
        $0.height.equalTo((self.reviewModel?.count ?? 0) * 240)
      }
    }
  }
  
  // MARK: - General Helpers
  func dataBind() {
    self.titleLabel.setupLabel(text: self.cafeModel?.name ?? "", color: .black, font: .notoSansKRMediumFont(fontSize: 20))
    self.cafeTitleLabel.setupLabel(text: self.cafeModel?.name ?? "", color: .black, font: .notoSansKRMediumFont(fontSize: 26))
    self.starRatingLabel.setupLabel(text: "\(self.rating ?? 0)/5", color: .pointcolorYellow, font: .notoSansKRMediumFont(fontSize: 20))
    self.addressLabel.setupLabel(text: self.cafeModel?.address ?? "", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
    self.instagramLabel.setupLabel(text: "@\(self.cafeModel?.instagram ?? "")", color: .gray4, font: .notoSansKRRegularFont(fontSize: 14))
    self.clockLabel.setupLabel(
      text: "\(self.cafeModel?.opentime ?? "")-\(self.cafeModel?.closetime ?? "") (\(self.cafeModel?.offday?[0] ?? "") 휴무)",
      color: .gray4, font: .notoSansKRRegularFont(fontSize: 14))
  }
  func register() {
    tagCollectionView.register(TagCollectionViewCell.self,
                               forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
    reviewTableView.register(DetailReviewTableViewCell.self,
                             forCellReuseIdentifier: DetailReviewTableViewCell.reuseIdentifier)
    
  }
  @objc func clickedBackButton() {
    let mapVC = navigationController?.children[0] as? MapViewController
    mapVC?.informationRevealed = true
    self.navigationController?.popViewController(animated: false)
  }
  @objc func clickedMenuButton() {
    let menuNavigationController = UINavigationController()
    let menuVC = CafeMenuViewController()
    menuNavigationController.addChild(menuVC)
    menuNavigationController.view.backgroundColor = .clear
    menuNavigationController.modalPresentationStyle = .overFullScreen
    menuNavigationController.navigationBar.isHidden = true
    self.present(menuNavigationController, animated: false, completion: nil)
  }
  @objc func clickedEntireReviewButton() {
    let entireVC = EntireReviewViewController()
    entireVC.reviewModel = self.reviewModel!
    self.navigationController?.pushViewController(entireVC, animated: false)
  }
  @objc func clickedAddPinButton() {
    let pinNavigationController = UINavigationController()
    let pinPopupVC = PinPopupViewController()
    pinNavigationController.addChild(pinPopupVC)
    pinNavigationController.view.backgroundColor = .clear
    pinNavigationController.modalPresentationStyle = .overFullScreen
    self.present(pinNavigationController, animated: true, completion: nil)
  }
  @objc func clickedWriteReviewButton() {
    let writeReviewVC = WriteReviewViewController()
    self.navigationController?.pushViewController(writeReviewVC, animated: false)
  }
  func setupReviewData(cafeId: String) {
    reviewProvider.rx.request(.reviewList(cafeId: cafeId))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ReviewListResponseType<ServerReview>.self,
                                          from: response.data)
            self.reviewModel = data.reviews
            self.isReviewed = data.isReviewed
            self.layout()
            self.tagCollectionView.reloadData()
            self.reviewTableView.reloadData()
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
}

// MARK: - TagCollectionView Delegate
extension CafeDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var width: CGFloat = 0
    let height: CGFloat = 27
    switch cafeModel?.tags[indexPath.item].id {
    case "a":
      width = 69
    case "b":
      width = 80
    case "c", "e", "f":
      width = 58
    case "d":
      width = 91
    case "g":
      width = 69
    default:
      width = 91
    }
    return CGSize(width: width, height: height)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
}

// MARK: - TagCollectionView DataSource
extension CafeDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cafeModel?.tags.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell else {
      return UICollectionViewCell()
    }
    tagCell.dataBind(tagName: cafeModel?.tags[indexPath.item].name ?? "")
    tagCell.awakeFromNib()
    return tagCell
  }
}

// MARK: - ReviewTableView Delegate
extension CafeDetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if self.reviewModel?[indexPath.row].imgs == nil && self.reviewModel?[indexPath.row].recommend == nil{
      return 110
    }
    else if self.reviewModel?[indexPath.row].imgs == nil {
      return 140
    }
    else if self.reviewModel?[indexPath.row].recommend == nil {
      return 198
    }
    else {
      return 240
    }
  }
}

// MARK: - ReviewTableView DataSource {
extension CafeDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviewModel?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailReviewTableViewCell.reuseIdentifier, for: indexPath) as? DetailReviewTableViewCell else {
      return UITableViewCell()
    }
    detailCell.reviewModel = reviewModel?[indexPath.row]
    detailCell.reviewDataBind(nickName: reviewModel![indexPath.row].writer.nickname,
                              date: (reviewModel?[indexPath.row].createdAt)!,
                              rating: Float(reviewModel![indexPath.row].rating),
                              content: reviewModel![indexPath.row].content,
                              profileImg: reviewModel![indexPath.row].writer.profileImg)
    detailCell.rootViewController = self
    detailCell.awakeFromNib()
    return detailCell
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    self.viewWillLayoutSubviews()
  }
}

// MARK: cafeScroll Delegate
extension CafeDetailViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    var offset = scrollView.contentOffset.y / (titleContainerView.frame.minY - cafeTitleLabel.frame.minY)
    if offset > 1 {
      offset = 1
      let color = UIColor(red: 1, green: 1, blue: 1, alpha: offset)
      navigationView.backgroundColor = color
      titleLabel.isHidden = false
      backButton.setBackgroundImage(UIImage(named: "iconBackBlack"), for: .normal)
      threshold = true
    }
    else {
      navigationView.backgroundColor = .clear
      titleLabel.isHidden = true
      backButton.setBackgroundImage(UIImage(named: "iconBackWhite"), for: .normal)
    }
  }
}

struct ReviewListResponseType<T: Codable>: Codable {
  var status: Int?
  var success: Bool?
  var message: String?
  var reviews: [T]?
  var isReviewed: Bool?
}
