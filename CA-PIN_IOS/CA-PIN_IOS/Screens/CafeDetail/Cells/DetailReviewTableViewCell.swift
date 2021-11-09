//
//  DetailReviewTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/08.
//

import UIKit

import SnapKit
import Then

// MARK: - DetailReviewTableViewCell
class DetailReviewTableViewCell: UITableViewCell {
    
    // MARK: - Lazy Componets
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    // MARK: - Components
    private let containerView = UIView()
    private let profileImageView = UIImageView()
    private let titleContainerView = UIView()
    private let editButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: "iconEdit"), for: .normal)
    }
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let ratingImageView = UIImageView()
    private let ratingLabel = UILabel()
    
    let reviewContentLabel = UILabel()
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    var rootViewController: UIViewController?
    var reviewModel: ServerReview?
    var isReviewed: Bool?
    var tagCount: Int?
    
    // MARK: - LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        layout()
        register()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
}

// MARK: - Extensions
extension DetailReviewTableViewCell {
    
    // MARK: - Layout Helpers
    func layout() {
        layoutContainerView()
        layoutProfileImageView()
        layoutTitleContainerView()
        layoutEditButton()
        layoutTitleLabel()
        layoutDateLabel()
        layoutRatingImageView()
        layoutRatingLabel()
        layoutTagCollectionView()
        layoutReviewContentLabel()
        layoutPhotoCollectionView()
    }
    func layoutContainerView() {
        contentView.add(containerView) {
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.top.equalTo(self.contentView.snp.top).offset(23)
                $0.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
    func layoutProfileImageView() {
        containerView.add(profileImageView) {
            $0.setRounded(radius: 22.5)
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.containerView.snp.leading)
                $0.top.equalToSuperview().offset(5)
                $0.width.height.equalTo(45)
            }
        }
    }
    func layoutTitleContainerView() {
        containerView.add(titleContainerView) {
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.profileImageView.snp.trailing).offset(13)
                $0.top.equalTo(self.profileImageView.snp.top)
                $0.trailing.equalTo(self.containerView.snp.trailing)
                $0.height.equalTo(17)
            }
        }
    }
    
    func layoutEditButton() {
        containerView.add(editButton) {
            $0.snp.makeConstraints {
                $0.top.trailing.equalToSuperview()
                $0.height.width.equalTo(28)
            }
        }
    }
    
    func layoutTitleLabel() {
        titleContainerView.add(titleLabel) {
            $0.snp.makeConstraints {
                $0.bottom.leading.equalToSuperview()
            }
        }
    }
    func layoutDateLabel() {
        titleContainerView.add(dateLabel) {
            $0.snp.makeConstraints {
                $0.bottom.equalTo(self.titleLabel)
                $0.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
            }
        }
    }
    func layoutRatingImageView() {
        containerView.add(ratingImageView) {
            $0.image = UIImage(named: "starRateUnactive")
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.titleContainerView)
                $0.top.equalTo(self.titleContainerView.snp.bottom).offset(12)
                $0.height.width.equalTo(14)
            }
        }
    }
    
    func layoutRatingLabel() {
        containerView.add(ratingLabel) {
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.ratingImageView.snp.trailing).offset(2)
                $0.centerY.equalTo(self.ratingImageView)
            }
        }
    }
    
    func layoutTagCollectionView() {
        containerView.add(tagCollectionView) {
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.ratingImageView)
                $0.leading.equalTo(self.ratingLabel.snp.trailing).offset(6)
                $0.height.equalTo(22)
                $0.width.equalTo(160)
            }
        }
    }
    func layoutReviewContentLabel() {
        containerView.add(reviewContentLabel) {
            $0.numberOfLines = 3
            $0.snp.makeConstraints {
                $0.leading.equalTo(self.titleContainerView)
                $0.top.equalTo(self.tagCollectionView.snp.bottom).offset(10)
                $0.trailing.equalTo(self.containerView.snp.trailing).offset(-17)
            }
        }
    }
    func layoutPhotoCollectionView() {
        containerView.add(photoCollectionView) {
            $0.backgroundColor = .clear
            if self.reviewModel?.imgs == nil {
                $0.snp.makeConstraints {
                    $0.top.equalTo(self.reviewContentLabel.snp.bottom).offset(10)
                    $0.leading.equalTo(self.titleContainerView)
                    $0.trailing.equalTo(self.containerView.snp.trailing)
                    $0.height.equalTo(0)
                }
            }
            else {
                $0.snp.makeConstraints {
                    $0.top.equalTo(self.reviewContentLabel.snp.bottom).offset(10)
                    $0.leading.equalTo(self.titleContainerView)
                    $0.trailing.equalTo(self.containerView.snp.trailing)
                    $0.bottom.equalTo(self.containerView.snp.bottom)
                    $0.height.equalTo(80)
                }
            }
            
        }
    }
    
    // MARK: - General Helpers
    func register() {
        tagCollectionView.register(
            RecommendTagCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendTagCollectionViewCell.reuseIdentifier)
        photoCollectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
    }
    
    func reviewDataBind(nickName: String, date: String, rating: Float, content: String, profileImg: String) {
        titleLabel.setupLabel(text: nickName, color: .black, font: .notoSansKRMediumFont(fontSize: 12))
        dateLabel.setupLabel(text: date, color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
        ratingLabel.setupLabel(text: "\(rating)",
                               color: .pointcolorYellow,
                               font: .notoSansKRRegularFont(fontSize: 12))
        reviewContentLabel.setupLabel(text: content,
                                      color: .black,
                                      font: .notoSansKRRegularFont(fontSize: 12))
        profileImageView.imageFromUrl(profileImg, defaultImgPath: "")
    }
    
    func updateLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

// MARK: - UICollectionView DelegateFlowLayout
extension DetailReviewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat?
        var height: CGFloat?
        if collectionView == tagCollectionView && reviewModel?.recommend == [0] && indexPath.item == 0 {
            width = 65
            height = 22
        }
        if collectionView == tagCollectionView && reviewModel?.recommend == [1] && indexPath.item == 0 {
            width = 86
            height = 22
        }
        if collectionView == tagCollectionView && reviewModel?.recommend == [0, 1] && indexPath.item == 0 {
            width = 65
            height = 22
        }
        if collectionView == tagCollectionView && reviewModel?.recommend == [0, 1] && indexPath.item == 1 {
            width = 86
            height = 22
        }
        if collectionView == tagCollectionView && reviewModel?.recommend?.isEmpty == true {
            width = 65
            height = 0
            self.tagCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        }
        if collectionView == photoCollectionView && self.reviewModel?.imgs?.isEmpty == false {
            width = 80
            height = 80
        }
        if collectionView == photoCollectionView && self.reviewModel?.imgs?.isEmpty == true {
            width = 80
            height = 0
            self.photoCollectionView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
        }
        return CGSize(width: width!, height: height!)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        var space: CGFloat = 0
        if collectionView == tagCollectionView {
            space = 6
        }
        if collectionView == photoCollectionView {
            space = 5
        }
        return space
    }
}

// MARK: - UICollectionView DataSource
extension DetailReviewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var number = 0
        if collectionView == tagCollectionView {
            number = reviewModel?.recommend?.count ?? 0
        }
        if collectionView == photoCollectionView {
            number = reviewModel?.imgs?.count ?? 0
            if number > 3 {
                number = 3
            }
        }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendTagCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommendTagCollectionViewCell else {
                return UICollectionViewCell()
            }
            tagCell.dataBind(tagNumber: reviewModel?.recommend?[indexPath.item])
            tagCell.awakeFromNib()
            return tagCell
        }
        else {
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            var moreNumber = (reviewModel?.imgs?.count ?? 2) - 2
            if moreNumber < 0 {
                moreNumber = 0
            }
            photoCell.dataBind(imageName: reviewModel?.imgs?[indexPath.item], moreNumber: moreNumber)
            photoCell.awakeFromNib()
            if indexPath.item == 2 && moreNumber > 0 {
                photoCell.photoImageView.isHidden = true
                photoCell.moreLabel.isHidden = false
            }
            return photoCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == photoCollectionView {
            let photoPreviewVC = PhotoPreviewViewController()
            photoPreviewVC.modalPresentationStyle = .overFullScreen
            photoPreviewVC.images = (self.reviewModel?.imgs)!
            rootViewController?.present(photoPreviewVC, animated: false, completion: nil)
        }
    }
}
