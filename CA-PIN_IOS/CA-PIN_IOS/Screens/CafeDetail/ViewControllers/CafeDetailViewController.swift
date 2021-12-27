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
    let addressLabel = UILabel().then {
        $0.isUserInteractionEnabled = true
    }
    
    let tagCollectionView: UICollectionView = {
        let layout = CollectionViewCenteredFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let firstSeparatorView = UIView()
    private let secondSeparatorView = UIView()
    private let detailTitleLabel = UILabel().then {
        $0.setupLabel(
            text: "상세정보",
            color: .black,
            font: .notoSansKRMediumFont(fontSize: 16)
        )
    }
    
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
    let writeReviewButton = UIButton()
    private let savePinView = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.setRounded(radius: 8)
        $0.borderColor = .pointcolor1
        $0.borderWidth = 2
    }
    private let savePinImageView = UIImageView().then {
        $0.image = UIImage(named: "iconPinsaveSmall")
    }
    private let savePinLabel = UILabel().then {
        $0.setupLabel(
            text: "핀저장",
            color: .pointcolor1,
            font: .notoSansKRMediumFont(fontSize: 16)
        )
    }
    
    private let reviewView = UIView().then {
        $0.backgroundColor = .maincolor1
        $0.isUserInteractionEnabled = true
        $0.setRounded(radius: 8)
        $0.borderColor = .maincolor1
        $0.borderWidth = 2
    }
    private let reviewImageView = UIImageView().then {
        $0.image = UIImage(named: "iconPencil")
    }
    private let reviewLabel = UILabel().then {
        $0.setupLabel(
            text: "리뷰 작성하기",
            color: .white,
            font: .notoSansKRMediumFont(fontSize: 16)
        )
    }
    
    private let emptyLabel = UILabel().then {
        $0.setupLabel(
            text: "아직 등록된 리뷰가 없어요.\n가장 먼저 리뷰를 작성해보세요.",
            color: .gray4,
            font: .notoSansKRRegularFont(fontSize: 14)
        )
        $0.isHidden = true
        $0.numberOfLines = 2
    }
    
    let gradationBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    let gradationWhiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    
    var rating: Float?
    var isSaved: Bool?
    var threshold = true
    
    let disposeBag = DisposeBag()
    let reviewProvider = MoyaProvider<ReviewService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let userProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    var cafeModel: CafeServerDetail?
    var reviewModel: [ServerReview]?
    var categoryArray: [MyCategoryList] = []
    var isReviewed: Bool?
    var offdays = ["일요일 휴무",
                   "월요일 휴무",
                   "화요일 휴무",
                   "수요일 휴무",
                   "목요일 휴무",
                   "금요일 휴무",
                   "토요일 휴무"]
    var reviewIdArray: [String] = []
    var cafeId: String = "" /// 리뷰 신고하고 돌아올 때
    var count138 = 0
    var count160 = 0
    var count218 = 0
    var count240 = 0
    var isInit = true
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupReviewData(cafeId: self.cafeModel?.id ?? cafeId)
        dataBind()
        register()
        layout()
        addGesture()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isInit {
            bottomView.layer.applyShadow(color: 0xC5C5C5.color, alpha: 0.1, x: 0, y: -4, blur: 4)
            isInit = false
        }
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
        layoutFirstSeparatorView()
        layoutDetailTitleLabel()
        layoutInformationView()
        layoutSecondSeparatorView()
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
        layoutSavePinView()
        layoutSavePinLabel()
        layoutSavePinImageView()
        layoutReviewView()
        layoutReviewLabel()
        layoutReviewImageView()
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
            $0.letterSpacing = -1.3
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
            $0.letterSpacing = -1.3
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
            $0.letterSpacing = -1.0
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
    
    private func layoutFirstSeparatorView() {
        cafeScrollContainerView.add(firstSeparatorView) {
            $0.backgroundColor = .gray2
            $0.snp.makeConstraints {
                $0.top.equalTo(self.tagCollectionView.snp.bottom).offset(27)
                $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
                $0.height.equalTo(2)
            }
        }
    }
    
    private func layoutDetailTitleLabel() {
        cafeScrollContainerView.add(detailTitleLabel) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.firstSeparatorView.snp.bottom).offset(15)
                $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(28)
            }
        }
    }
    
    func layoutInformationView() {
        cafeScrollContainerView.add(informationView) {
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.top.equalTo(self.detailTitleLabel.snp.bottom).offset(5)
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
            $0.letterSpacing = -0.7
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
            $0.letterSpacing = -0.7
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
                $0.top.equalTo(self.clockLabel.snp.bottom).offset(15)
                $0.height.width.equalTo(24)
            }
        }
    }
    func layoutMenuButton() {
        informationView.add(menuButton) {
            let titleString = NSAttributedString(
                string: "메뉴 상세보기",
                attributes: [
                    .font: UIFont.notoSansKRRegularFont(fontSize: 14),
                    .foregroundColor: UIColor.gray4,
                    .underlineColor: UIColor.gray4,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
            )
            $0.setAttributedTitle(titleString, for: .normal)
            $0.addTarget(self, action: #selector(self.clickedMenuButton), for: .touchUpInside)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.menuImageView.snp.centerY)
                $0.leading.equalTo(self.instagramLabel.snp.leading)
            }
        }
    }
    
    func layoutSecondSeparatorView() {
        cafeScrollContainerView.add(secondSeparatorView) {
            $0.backgroundColor = .gray2
            $0.snp.makeConstraints {
                $0.top.equalTo(self.informationView.snp.bottom).offset(10)
                $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
                $0.height.equalTo(2)
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
            $0.letterSpacing = -1.0
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
                $0.bottom.equalTo(self.view.snp.bottom)
                $0.height.equalTo(117)
            }
        }
    }
    
    private func layoutSavePinView() {
        bottomView.add(savePinView) {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
                $0.top.equalToSuperview().offset(12)
                $0.height.equalTo(49)
                $0.width.equalTo(122)
            }
        }
    }
    
    private func layoutSavePinLabel() {
        savePinView.add(savePinLabel) {
            $0.snp.makeConstraints {
                $0.trailing.equalToSuperview().offset(-28)
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    private func layoutSavePinImageView() {
        savePinView.add(savePinImageView) {
            $0.snp.makeConstraints {
                $0.trailing.equalTo(self.savePinLabel.snp.leading).offset(-4)
                $0.width.height.equalTo(22)
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    private func layoutReviewView() {
        bottomView.add(reviewView) {
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(12)
                $0.trailing.equalToSuperview().offset(-20)
                $0.leading.equalTo(self.savePinView.snp.trailing).offset(11)
                $0.height.equalTo(49)
            }
        }
    }
    
    private func layoutReviewLabel() {
        reviewView.add(reviewLabel) {
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.centerX.equalToSuperview().offset(13)
            }
        }
    }
    
    private func layoutReviewImageView() {
        reviewView.add(reviewImageView) {
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(self.reviewLabel.snp.leading).offset(-8)
                $0.width.height.equalTo(18)
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
                $0.leading.equalTo(self.cafeScrollContainerView.snp.leading).offset(20)
                $0.trailing.equalTo(self .cafeScrollContainerView.snp.trailing).offset(-20)
                $0.top.equalTo(self.reviewHeaderView.snp.bottom)
                $0.bottom.equalTo(self.cafeScrollContainerView.snp.bottom).offset(-95)
                $0.height.equalTo((self.reviewModel?.count ?? 0) * 212)
            }
        }
    }
    
    func layoutEmptyLabel() {
        cafeScrollContainerView.add(emptyLabel) {
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.reviewTitleLabel.snp.bottom).offset(63)
            }
        }
    }
    
    // MARK: - General Helpers
    func dataBind() {
        if self.cafeModel?.img == nil {
            self.bannerImageView.image = UIImage(named: "bigDetailEmptyImage")
        }
        else {
            self.bannerImageView.imageFromUrl(self.cafeModel?.img, defaultImgPath: "")
        }
        self.titleLabel.setupLabel(text: self.cafeModel?.name ?? "", color: .black, font: .notoSansKRMediumFont(fontSize: 20))
        self.cafeTitleLabel.setupLabel(text: self.cafeModel?.name ?? "", color: .black, font: .notoSansKRMediumFont(fontSize: 26))
        self.starRatingLabel.setupLabel(text: "\(self.cafeModel?.rating ?? 0)", color: .pointcolorYellow, font: .notoSansKRMediumFont(fontSize: 20))
        self.addressLabel.setupLabel(text: self.cafeModel?.address ?? "", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
        self.instagramLabel.setupLabel(text: "\(self.cafeModel?.instagram ?? "")", color: .gray4, font: .notoSansKRRegularFont(fontSize: 14))
        if let model = cafeModel {
            var offdayString = ""
            if let offday = model.offday {
                for day in offday {
                    offdayString += "\(day), "
                }
                offdayString.removeLast(2)
            }
            
            if let opentime = model.opentime,
                let closetime = model.closetime,
                let holidayOpentime = model.opentimeHoliday,
                let holidayClosetime = model.closetimeHoliday {
                self.clockLabel.setupLabel(
                    text: "평일 \(opentime)~\(closetime) (\(offdayString) 휴무)\n공휴일 \(holidayOpentime)~\(holidayClosetime)",
                    color: .gray4,
                    font: .notoSansKRRegularFont(fontSize: 14)
                )
            }
            else if let opentime = model.opentime,
                         let closetime = model.closetime {
                self.clockLabel.setupLabel(
                    text: "\(opentime)~\(closetime) (\(offdayString) 휴무)",
                    color: .gray4,
                    font: .notoSansKRRegularFont(fontSize: 14)
                )
            }
        }
        validateIsSaved()
    }
    
    func validateIsSaved() {
        if let isSaved = isSaved {
            if isSaved {
                savePinView.backgroundColor = .pointcolor1
                savePinImageView.image = UIImage(named: "iconPinsaveWhite")
                savePinLabel.text = "저장됨"
                savePinLabel.textColor = .white
            }
            else {
                savePinView.backgroundColor = .white
                savePinImageView.image = UIImage(named: "iconPinsaveSmall")
                savePinLabel.text = "핀저장"
                savePinLabel.textColor = .pointcolor1
            }
        }
    }
    
    private func addGesture() {
        let pinGesture = UITapGestureRecognizer()
        pinGesture.addTarget(self, action: #selector(clickedAddPinButton))
        savePinView.addGestureRecognizer(pinGesture)
        
        let reviewGesutre = UITapGestureRecognizer()
        reviewGesutre.addTarget(self, action: #selector(clickedWriteReviewButton))
        reviewView.addGestureRecognizer(reviewGesutre)
        
        let addressGesture = UITapGestureRecognizer()
        addressGesture.addTarget(self, action: #selector(touchupAddressLabel))
        addressLabel.addGestureRecognizer(addressGesture)
    }
    
    func register() {
        tagCollectionView.register(TagCollectionViewCell.self,
                                   forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        reviewTableView.register(DetailReviewTableViewCell.self,
                                 forCellReuseIdentifier: DetailReviewTableViewCell.reuseIdentifier)
        reviewTableView.register(DetailEmptyTableViewCell.self,
                                 forCellReuseIdentifier: DetailEmptyTableViewCell.reuseIdentifier)
        
    }
    @objc func clickedBackButton() {
        let mapVC = navigationController?.children[0] as? MapViewController
        mapVC?.informationRevealed = true
        self.navigationController?.popViewController(animated: false)
    }
    @objc func clickedMenuButton() {
        let menuNavigationController = UINavigationController()
        let menuVC = CafeMenuViewController()
        menuVC.cafeID = cafeModel!.id
        menuNavigationController.addChild(menuVC)
        menuNavigationController.view.backgroundColor = .clear
        menuNavigationController.modalPresentationStyle = .overFullScreen
        menuNavigationController.navigationBar.isHidden = true
        self.present(menuNavigationController, animated: false, completion: nil)
    }
    @objc func clickedEntireReviewButton() {
        let entireVC = EntireReviewViewController()
        if let reviewModel = reviewModel {
            entireVC.reviewModel = self.reviewModel!
            self.navigationController?.pushViewController(entireVC, animated: false)
        }
        else {
            showGrayToast(message: "리뷰가 없습니다.")
        }
    }
    @objc func clickedAddPinButton() {
        if let isSaved = isSaved {
            if isSaved {
                setupCategory()
            }
            else {
                setupCategory()
            }
        }
    }
    @objc func clickedWriteReviewButton() {
        let writeReviewVC = WriteReviewViewController()
        writeReviewVC.cafeId = (self.cafeModel?.id)!
        self.navigationController?.pushViewController(writeReviewVC, animated: false)
    }
    
    @objc
    private func touchupAddressLabel() {
        if let text = addressLabel.text {
            UIPasteboard.general.string = text
            showGreenToast(message: "주소가 복사되었습니다.")
        }
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
                        self.reviewIdArray = []
                        for i in 0...self.reviewModel!.count-1 {
                            self.reviewIdArray.append(self.reviewModel![i].id)
                        }
                        self.layout()
                        if let review = data.reviews {
                            self.emptyLabel.isHidden = true
                            self.reviewTableView.separatorStyle = .singleLine
                        }
                        self.tagCollectionView.reloadData()
                        self.reviewTableView.reloadData()
                    } catch {
                        print(error)
                    }
                }
                if response.statusCode == 204 {
                    self.emptyLabel.isHidden = false
                    self.layoutEmptyLabel()
                    self.reviewTableView.separatorStyle = .none
                }
            }, onError: { error in
                print(error)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    func setupCategory() {
        userProvider.rx.request(.categoryList)
            .asObservable()
            .subscribe(onNext: { response in
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode(CategoryResponseArrayType<MyCategoryList>.self,
                                                      from: response.data)
                        self.categoryArray = data.myCategoryList!
                        let pinNavigationController = UINavigationController()
                        let pinPopupVC = PinPopupViewController()
                        pinPopupVC.cafeId = self.cafeModel!.id
                        pinPopupVC.categoryArray = self.categoryArray
                        pinNavigationController.addChild(pinPopupVC)
                        pinNavigationController.view.backgroundColor = .clear
                        pinNavigationController.modalPresentationStyle = .overCurrentContext
                        self.present(pinNavigationController, animated: true, completion: nil)
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
        if self.reviewModel?[indexPath.row].imgs == nil {
            return 122
        }
        else {
            return 212
        }
    }
    //  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //    tableView.estimatedRowHeight = 500
    //    tableView.rowHeight = UITableView.automaticDimension
    //    return UITableView.automaticDimension
    //  }
}

// MARK: - ReviewTableView DataSource {
extension CafeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewModel == nil {
            return 1
        }
        else {
            if (reviewModel?.count)! < 3{
                return reviewModel!.count
            }
            else {
                return 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if reviewModel != nil {
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailReviewTableViewCell.reuseIdentifier, for: indexPath) as? DetailReviewTableViewCell else {
                return UITableViewCell()
            }
            detailCell.reviewModel = reviewModel?[indexPath.row]
            detailCell.reviewDataBind(nickName: reviewModel![indexPath.row].writer.nickname,
                                      date: (reviewModel?[indexPath.row].createdAt)!,
                                      rating: Float(reviewModel![indexPath.row].rating),
                                      content: reviewModel![indexPath.row].content,
                                      profileImg: reviewModel![indexPath.row].writer.profileImg)
            detailCell.reviewId = reviewIdArray[indexPath.row]
            detailCell.rootViewController = self
            detailCell.awakeFromNib()
            return detailCell
        }
        else {
            guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: DetailEmptyTableViewCell.reuseIdentifier, for: indexPath) as? DetailEmptyTableViewCell else {
                return UITableViewCell()
            }
            emptyCell.awakeFromNib()
            return emptyCell
        }
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
