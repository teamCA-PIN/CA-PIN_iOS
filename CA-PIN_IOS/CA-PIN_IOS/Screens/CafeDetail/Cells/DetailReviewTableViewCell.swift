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
  
  // MARK: - Components
  let containerView = UIView()
  let profileImageView = UIImageView()
  let titleContainerView = UIView()
  let titleLabel = UILabel()
  let dateLabel = UILabel()
  let ratingImageView = UIImageView()
  let ratingLabel = UILabel()
  let tagCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
    return collectionView
  }()
  let reviewContentLabel = UILabel()
  let photoCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
    return collectionView
  }()
  
  var rootViewController: UIViewController?
  var reviewModel = Review(id: "1",
                            nickname: "쿼카",
                            date: "2021-01-20",
                            rating: 4.0,
                            recommend: [0,1],
                            content: "무엇보다 커피가 정말 맛있고, 디저트로 준비돼 있던 쿠키와 휘낭시에도 맛있었습니다.  브라운크림은 꼭 드세요 !",
                            imgs: ["1","1","1","1","1"])
                    
  
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
}

// MARK: - Extensions
extension DetailReviewTableViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    layoutContainerView()
    layoutProfileImageView()
    layoutTitleContainerView()
    layoutTitleLabel()
    layoutDateLabel()
    layoutRatingLabel()
    layoutRatingImageView()
    layoutTagCollectionView()
    layoutReviewContentLabel()
    layoutPhotoCollectionView()
  }
  func layoutContainerView() {
    contentView.add(containerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(16)
        $0.bottom.equalTo(self.contentView.snp.bottom).offset(-16)
        $0.leading.trailing.equalToSuperview()
      }
    }
  }
  func layoutProfileImageView() {
    containerView.add(profileImageView) {
      $0.image = UIImage(named: "profile")
      $0.setRounded(radius: 22.5)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.containerView.snp.leading).offset(3)
        $0.top.equalToSuperview()
        $0.width.height.equalTo(45)
      }
    }
  }
  func layoutTitleContainerView() {
    containerView.add(titleContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.profileImageView.snp.trailing).offset(10)
        $0.top.equalTo(self.profileImageView.snp.top)
        $0.trailing.equalTo(self.containerView.snp.trailing)
        $0.height.equalTo(17)
      }
    }
  }
  func layoutTitleLabel() {
    titleContainerView.add(titleLabel) {
      $0.snp.makeConstraints {
        $0.top.leading.equalToSuperview()
      }
    }
  }
  func layoutDateLabel() {
    titleContainerView.add(dateLabel) {
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.titleLabel.snp.centerY)
        $0.leading.equalTo(self.titleLabel.snp.trailing).offset(11)
      }
    }
  }
  func layoutRatingLabel() {
    titleContainerView.add(ratingLabel) {
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.titleContainerView.snp.trailing).offset(-15)
        $0.centerY.equalTo(self.titleLabel.snp.centerY)
      }
    }
  }
  func layoutRatingImageView() {
    titleContainerView.add(ratingImageView) {
      $0.image = UIImage(named: "starRateUnactive")
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.ratingLabel.snp.leading).offset(-2)
        $0.centerY.equalTo(self.ratingLabel.snp.centerY)
        $0.height.width.equalTo(14)
      }
    }
  }
  func layoutTagCollectionView() {
    containerView.add(tagCollectionView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(11)
        $0.leading.equalTo(self.titleLabel.snp.leading)
        $0.height.equalTo(22)
        $0.trailing.equalTo(self.containerView.snp.trailing)
      }
    }
  }
  func layoutReviewContentLabel() {
    containerView.add(reviewContentLabel) {
      $0.numberOfLines = 3
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.tagCollectionView.snp.leading)
        $0.top.equalTo(self.tagCollectionView.snp.bottom).offset(8)
        $0.trailing.equalTo(self.containerView.snp.trailing).offset(-27)
      }
    }
  }
  func layoutPhotoCollectionView() {
    containerView.add(photoCollectionView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewContentLabel.snp.bottom).offset(21)
        $0.leading.equalTo(self.profileImageView.snp.leading)
        $0.trailing.equalTo(self.containerView.snp.trailing)
        $0.bottom.equalTo(self.containerView.snp.bottom)
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
  
  func dataBind(nickName: String, date: String, rating: Float, content: String) {
    titleLabel.setupLabel(text: nickName, color: .black, font: .notoSansKRMediumFont(fontSize: 12))
    dateLabel.setupLabel(text: date, color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
    ratingLabel.setupLabel(text: "\(rating)",
                           color: .pointcolorYellow,
                           font: .notoSansKRRegularFont(fontSize: 12))
    reviewContentLabel.setupLabel(text: "\(content) 더 보기",
                                  color: .black,
                                  font: .notoSansKRRegularFont(fontSize: 12))
  }
}

// MARK: - UICollectionView DelegateFlowLayout
extension DetailReviewTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var width: CGFloat?
    var height: CGFloat?
    if collectionView == tagCollectionView && reviewModel.recommend == [0] && indexPath.item == 0 {
      width = 65
      height = 22
    }
    if collectionView == tagCollectionView && reviewModel.recommend == [1] && indexPath.item == 0 {
      width = 86
      height = 22
    }
    if collectionView == tagCollectionView && reviewModel.recommend == [0, 1] && indexPath.item == 0 {
      width = 65
      height = 22
    }
    if collectionView == tagCollectionView && reviewModel.recommend == [0, 1] && indexPath.item == 1 {
      width = 86
      height = 22
    }
    if collectionView == photoCollectionView {
      width = (self.contentView.frame.width-22)/4
      height = 80
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
      number = reviewModel.recommend?.count ?? 0
    }
    if collectionView == photoCollectionView {
      number = reviewModel.imgs?.count ?? 0
      if number > 4 {
        number = 4
      }
    }
    return number
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == tagCollectionView {
      guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendTagCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommendTagCollectionViewCell else {
        return UICollectionViewCell()
      }
      tagCell.dataBind(tagNumber: reviewModel.recommend?[indexPath.item])
      tagCell.awakeFromNib()
      return tagCell
    }
    else {
      guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
        return UICollectionViewCell()
      }
      var moreNumber = (reviewModel.imgs?.count ?? 3) - 3
      if moreNumber < 0 {
        moreNumber = 0
      }
      photoCell.dataBind(imageName: reviewModel.imgs?[indexPath.item], moreNumber: moreNumber)
      photoCell.awakeFromNib()
      if indexPath.item == 3 && moreNumber > 0 {
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
      rootViewController?.present(photoPreviewVC, animated: false, completion: nil)
    }
  }
}

