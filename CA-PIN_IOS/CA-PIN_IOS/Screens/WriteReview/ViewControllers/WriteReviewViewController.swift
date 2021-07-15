//
//  WriteReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/09.
//

import Cosmos
import Photos
import PhotosUI
import UIKit

import SnapKit
import SwiftyColor
import Then

import YPImagePicker

// MARK: - WriteReviewViewController

class WriteReviewViewController: UIViewController {
  
  // MARK: - Components
  var config : YPImagePickerConfiguration {
    var temp = YPImagePickerConfiguration()
    temp.usesFrontCamera = false
    temp.screens = [.library, .photo]
    temp.library.maxNumberOfItems = 10
    temp.library.defaultMultipleSelection = false
    temp.showsPhotoFilters = false
    temp.onlySquareImagesFromCamera = false
    temp.hidesBottomBar = false
    temp.hidesCancelButton = false
    temp.library.skipSelectionsGallery = true
    return temp
  }
  let writeScrollView = UIScrollView()
  let writeScrollContainerView = UIView()
  let topcontainerview = UIView()
  let contentcontainerview = UIView()
  let backButton = UIButton()
  let writereviewtitleLabel = UILabel()
  let photoLabel = UILabel()
  let explainphotoLabel = UILabel()
  let reviewphotoCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.isScrollEnabled = true
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let tasteLabel = UILabel()
  let explaintasteLabel = UILabel()
  let buttonContainerView = UIView()
  let tasteButton = UIButton()
  let feelButton = UIButton()
  let reviewLabel = UILabel()
  let reviewessentialImageView = UIImageView()
  let explainreviewLabel = UILabel()
  var reviewTextView = UITextView()
  let reviewwordcountLabel = UILabel()
  let starLabel = UILabel()
  let staressentialImageView = UIImageView()
  let explainstarLabel = UILabel()
  //star rating
  let ratingView = CosmosView().then {
    $0.settings.fillMode = .half
    $0.settings.filledImage = UIImage(named: "vector")
    $0.settings.emptyImage = UIImage(named: "starInactive")
    $0.settings.starSize = 34
    $0.settings.starMargin = 14.7
    $0.settings.starPoints = [CGPoint(x: 100, y: 91.176)]
  }
  let writereviewButton = UIButton()
  let ratingContentLabel = UILabel()
  let ratingMaxLabel = UILabel()
  
  final let maxLength = 150
  var nameCount = 0
  
  var ratingValue = 2.5
  
  var fetchResult: PHFetchResult<PHAsset>?
  var canAccessImages: [UIImage] = []
  
  var changetiming = 0
  
  let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    self.view.backgroundColor = .white
    super.viewDidLoad()
    layout()
    register()
    self.reviewphotoCollectionView.delegate = self
    self.reviewphotoCollectionView.dataSource = self
    self.ratingView.didFinishTouchingCosmos = didFinishTouchRatingView
    self.navigationController?.navigationBar.isHidden = true
    self.reviewTextView.delegate = self
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.textDidChange(_:)),
                                           name: UITextView.textDidChangeNotification,
                                           object: self.reviewTextView)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(DataDelete),
                                           name: NSNotification.Name("delete"),
                                           object: nil)
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
    tapRecognizer.numberOfTapsRequired = 1
    tapRecognizer.isEnabled = true
    tapRecognizer.cancelsTouchesInView = false
    self.writeScrollView.addGestureRecognizer(tapRecognizer)
  }
}

// MARK: - Extension

extension WriteReviewViewController {
  
  // MARK: - Helpers
  
  func register() {
    self.reviewphotoCollectionView.register(ReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: ReviewPhotoCollectionViewCell.reuseIdentifier)
    self.reviewphotoCollectionView.register(NewReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: NewReviewPhotoCollectionViewCell.reuseIdentifier)
  }
  func layout() {
    layoutWriteScrollView()
    layoutWriteScrollContainerView()
    layoutTopContainerView()
    layoutContentContainerView()
    layoutBackButton()
    layoutWritereviewtitleLabel()
    layoutPhotoLabel()
    layoutExplainphotoLabel()
    layoutReviewPhotoCollectionView()
    layoutTasteLabel()
    layoutExplaintasteLabel()
    layoutButtonContainerView()
    layoutTasteButton()
    layoutFeelButton()
    layoutReviewLabel()
    layoutReviewessentialImageView()
    layoutExplainreviewLabel()
    layoutReviewTextView()
    layoutReviewwordcountLabel()
    layoutStarLabel()
    layoutStaressentialImageView()
    layoutExplainstarLabel()
    layoutRatingView()
    layoutRatingMaxLabel()
    layoutRatingContentLabel()
    layoutWriteReviewButton()
    
  }
  func layoutWriteScrollView() {
    self.view.add(writeScrollView) {
      $0.backgroundColor = .white
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.center.top.leading.trailing.bottom.equalToSuperview()
      }
    }
  }
  func layoutWriteScrollContainerView() {
    self.writeScrollView.add(writeScrollContainerView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .clear
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints {
        $0.centerX.top.leading.equalToSuperview()
        $0.bottom.equalTo(self.writeScrollView.snp.bottom)
      }
    }
  }
  func layoutTopContainerView() {
    self.view.add(self.topcontainerview) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top)
        $0.leading.equalTo(self.view.snp.leading)
        $0.trailing.equalTo(self.view.snp.trailing)
        $0.height.equalTo(88)
      }
    }
  }
  func layoutContentContainerView() {
    self.topcontainerview.add(self.contentcontainerview) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.topcontainerview.snp.top).offset(52)
        $0.leading.equalTo(self.topcontainerview.snp.leading)
        $0.trailing.equalTo(self.topcontainerview.snp.trailing)
        $0.centerX.equalTo(self.topcontainerview)
        $0.bottom.equalTo(self.topcontainerview.snp.bottom).offset(-9)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutBackButton() {
    self.contentcontainerview.add(self.backButton) {
      $0.setImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentcontainerview.snp.top).offset(1)
        $0.leading.equalTo(self.contentcontainerview.snp.leading).offset(20)
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.bottom.equalTo(self.contentcontainerview.snp.bottom)
      }
    }
  }
  func layoutWritereviewtitleLabel() {
    self.contentcontainerview.add(self.writereviewtitleLabel) {
      $0.setupLabel(text: "리뷰 작성하기", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentcontainerview.snp.top)
        $0.centerX.equalTo(self.contentcontainerview)
        $0.bottom.equalTo(self.contentcontainerview.snp.bottom)
      }
    }
  }
  func layoutPhotoLabel() {
    self.writeScrollContainerView.add(self.photoLabel) {
      $0.setupLabel(text: "사진", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.writeScrollContainerView.snp.top).offset(71)
        $0.leading.equalTo(self.writeScrollContainerView).offset(20)
      }
    }
  }
  func layoutExplainphotoLabel() {
    self.writeScrollContainerView.add(self.explainphotoLabel) {
      $0.setupLabel(text: "방문한 카페와 관련된 사진을 공유해주세요.", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.photoLabel.snp.bottom).offset(10)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutReviewPhotoCollectionView() {
    self.writeScrollContainerView.add(self.reviewphotoCollectionView) {
      $0.backgroundColor = .clear
      $0.isUserInteractionEnabled = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainphotoLabel.snp.bottom).offset(15)
        $0.leading.equalTo(self.photoLabel.snp.leading)
        $0.trailing.equalTo(self.writeScrollContainerView.snp.trailing)
        $0.height.equalTo(80)
      }
    }
  }
  func layoutTasteLabel() {
    self.writeScrollContainerView.add(self.tasteLabel) {
      $0.setupLabel(text: "맛과 분위기 추천", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewphotoCollectionView.snp.bottom).offset(40)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutExplaintasteLabel() {
    self.writeScrollContainerView.add(self.explaintasteLabel) {
      $0.setupLabel(text: "방문한 카페의 분위기와 음식 맛은 어떠셨나요?", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.tasteLabel.snp.bottom).offset(10)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutButtonContainerView() {
    self.writeScrollContainerView.add(self.buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explaintasteLabel.snp.bottom).offset(19)
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
        $0.trailing.equalTo(self.writeScrollContainerView.snp.trailing).offset(-20)
        $0.height.equalTo(50)
      }
    }
  }
  func layoutTasteButton() {
    self.buttonContainerView.add(self.tasteButton) {
      $0.isMultipleTouchEnabled = true
      $0.setTitle("맛 추천", for: .normal)
      $0.setTitleColor(.gray4, for: .normal)
      $0.backgroundColor = .gray1
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.tasteButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 25)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.leading.equalTo(self.buttonContainerView.snp.leading)
        $0.trailing.equalTo(self.buttonContainerView.snp.centerX).offset(-5.5)
      }
    }
  }
  func layoutFeelButton() {
    self.buttonContainerView.add(self.feelButton) {
      $0.isSelected.toggle()
      $0.isMultipleTouchEnabled = true
      $0.setTitle("분위기 추천", for: .normal)
      $0.setTitleColor(.gray4, for: .normal)
      $0.backgroundColor = .gray1
      $0.titleLabel?.font = UIFont.notoSansKRRegularFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.feelButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 25)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.top)
        $0.bottom.equalTo(self.buttonContainerView.snp.bottom)
        $0.leading.equalTo(self.buttonContainerView.snp.centerX).offset(5.5)
        $0.trailing.equalTo(self.buttonContainerView.snp.trailing)
      }
    }
  }
  func layoutReviewLabel() {
    self.writeScrollContainerView.add(self.reviewLabel) {
      $0.setupLabel(text: "리뷰", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.buttonContainerView.snp.bottom).offset(41)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutReviewessentialImageView() {
    self.writeScrollContainerView.add(self.reviewessentialImageView) {
      $0.image = UIImage(named: "mustStar")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewLabel.snp.top)
        $0.leading.equalTo(self.reviewLabel.snp.trailing)
        $0.width.equalTo(8)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutExplainreviewLabel() {
    self.writeScrollContainerView.add(self.explainreviewLabel) {
      $0.setupLabel(text: "방문한 카페와 메뉴에 대해 리뷰를 작성해주세요.", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewLabel.snp.bottom).offset(8)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutReviewTextView() {
    self.writeScrollContainerView.add(self.reviewTextView) {
      $0.autocorrectionType = .no
      $0.autocapitalizationType = .none
      $0.setBorder(borderColor: .gray3, borderWidth: 1)
      $0.setRounded(radius: 5)
      $0.text = "리뷰를 작성하세요."
      $0.font = .notoSansKRRegularFont(fontSize: 14)
      $0.textColor = .gray3
      $0.tintColor = .black
      $0.backgroundColor = .clear
      $0.textContainerInset = UIEdgeInsets(top: 15, left: 18, bottom: 20, right: 18)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainreviewLabel.snp.bottom).offset(20)
        $0.centerX.equalTo(self.writeScrollContainerView)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
        $0.trailing.equalTo(self.writeScrollContainerView.snp.trailing).offset(-20)
        $0.height.equalTo(161)
      }
    }
  }
  func layoutReviewwordcountLabel() {
    self.writeScrollContainerView.add(self.reviewwordcountLabel) {
      self.nameCount = self.reviewTextView.text?.count ?? 0
      $0.setupLabel(text: "0/150",
                    color: .gray3,
                    font: .notoSansKRRegularFont(fontSize: 14))
      
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.reviewTextView.snp.trailing).offset(-13)
        $0.bottom.equalTo(self.reviewTextView.snp.bottom).offset(-10)
      }
    }
  }
  func layoutStarLabel() {
    self.writeScrollContainerView.add(self.starLabel) {
      $0.setupLabel(text: "별점", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewTextView.snp.bottom).offset(40)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
      }
    }
  }
  func layoutStaressentialImageView() {
    self.writeScrollContainerView.add(self.staressentialImageView) {
      $0.image = UIImage(named: "mustStar")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.starLabel.snp.top)
        $0.leading.equalTo(self.starLabel.snp.trailing)
        $0.width.equalTo(8)
        $0.height.equalTo(29)
      }
    }
  }
  func layoutExplainstarLabel() {
    self.writeScrollContainerView.add(self.explainstarLabel) {
      $0.setupLabel(text: "방문한 카페의 별점은 몇점인가요?", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.starLabel.snp.bottom).offset(4)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
        //        $0.bottom.equalTo(self.writeScrollContainerView.snp.bottom).offset(-550)
      }
    }
  }
  ///별점
  func layoutRatingView() {
    self.writeScrollContainerView.add(self.ratingView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainstarLabel.snp.bottom).offset(30)
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(27)
      }
    }
  }
  func layoutRatingMaxLabel() {
    self.writeScrollContainerView.add(self.ratingMaxLabel) {
      $0.setupLabel(text: "/5점", color: .gray3, font: .notoSansKRMediumFont(fontSize: 16))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.ratingView.snp.centerY)
        $0.trailing.equalTo(self.writeScrollContainerView.snp.trailing).offset(-20)
      }
    }
  }
  func layoutRatingContentLabel() {
    self.writeScrollContainerView.add(self.ratingContentLabel) {
      $0.setupLabel(text: "\(self.ratingValue)점", color: .black, font: .notoSansKRMediumFont(fontSize: 16))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.ratingMaxLabel.snp.centerY)
        $0.trailing.equalTo(self.ratingMaxLabel.snp.leading).offset(-5)
      }
    }
  }
  func layoutWriteReviewButton() {
    self.writeScrollContainerView.add(self.writereviewButton) {
      $0.setTitle("리뷰등록하기", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.backgroundColor = .pointcolor1
      $0.titleLabel?.font = UIFont.notoSansKRMediumFont(fontSize: 16)
      $0.addTarget(self, action: #selector(self.writereviewButtonClicked), for: .touchUpInside)
      $0.setRounded(radius: 24.5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.ratingView.snp.bottom).offset(38)
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading).offset(20)
        $0.trailing.equalTo(self.writeScrollContainerView.snp.trailing).offset(-20)
        $0.bottom.equalTo(self.writeScrollContainerView.snp.bottom).offset(-34)
        $0.height.equalTo(49)
      }
    }
  }
  
  // MARK: - General Helpers
  
  @objc func tasteButtonClicked() {
    tasteButton.isSelected.toggle()
    if tasteButton.isSelected == true {
      tasteButton.backgroundColor = .pointcolor1
      tasteButton.setTitleColor(.white, for: .normal)
    }
    else {
      tasteButton.backgroundColor = .gray1
      tasteButton.setTitleColor(.gray4, for: .normal)
    }
  }
  
  @objc func feelButtonClicked() {
    feelButton.isSelected.toggle()
    if feelButton.isSelected == true {
      feelButton.backgroundColor = .pointcolor1
      feelButton.setTitleColor(.white, for: .normal)
    }
    else {
      feelButton.backgroundColor = .gray1
      feelButton.setTitleColor(.gray4, for: .normal)
    }
  }
  @objc func handleTap() {
    reviewTextView.resignFirstResponder() // dismiss keyoard
  }
  
  ///back button 누르면 돌아가게
  @objc func backButtonClicked() {}
  
  @objc func textDidChange(_ notification: Notification) {
    if let textview = notification.object as? UITextView {
      if let text = textview.text {
        if text.isEmpty == false {
          self.reviewwordcountLabel.text = "\(text.count)/150"
        }
        if text.count > self.maxLength {
          textview.resignFirstResponder()
        }
        if text.count >= maxLength {
          let index = text.index(text.startIndex, offsetBy: maxLength)
          let newString = text[text.startIndex..<index]
          textview.text = String(newString)
        }
      }
    }
  }
  @objc func writereviewButtonClicked() {
    if reviewwordcountLabel.text == "0/150" {
      self.showGrayToast(message: "리뷰와 별점을 등록해주세요")
    } else {
      /// 다음 화면으로 넘어가게
    }
    /// 별점 없을시 토스트 띄워주기
  }
  
  
  /// 선택한 사진 삭제
  @objc func DataDelete(Notification: NSNotification) {
    if let index = Notification.object as? Int {
      canAccessImages.remove(at: index-1)
      self.changetiming = 0
      reviewphotoCollectionView.reloadData()
    }
  }
  
  
  func cameraWork() {
    let picker = YPImagePicker(configuration: self.config)
    picker.didFinishPicking{ [unowned picker] items, _ in
      if let photo = items.singlePhoto {
        self.canAccessImages.append(photo.image)
      }
      self.reviewphotoCollectionView.reloadData()
      picker.dismiss(animated: true, completion: nil)
      
    }
    present(picker, animated: true, completion: nil)
  }
  
  func photoLibraryWork() {
    let picker = YPImagePicker(configuration: config)
    picker.didFinishPicking{ [unowned picker] items, cancelled in
      for item in items {
        switch item {
        case .photo(let photo):
          print(photo.image)
          if !self.canAccessImages.contains(photo.image){
            self.canAccessImages.append(photo.image)
            if self.canAccessImages.count == 5 {
              self.changetiming = 1
            }
          }
        case .video(v: _):
          print("비디오")
        }
      }
      self.reviewphotoCollectionView.reloadData()
      picker.dismiss(animated: true, completion: nil)
    }
    picker.modalPresentationStyle = .overCurrentContext
    self.present(picker, animated: true, completion: nil)
  }
  
  func didFinishTouchRatingView(_ rating: Double) {
    self.ratingContentLabel.text = "\(rating)점"
  }
}


// MARK: - ReviewTextView Delegate

extension WriteReviewViewController: UITextViewDelegate {
  private func textview(_ textview: UITextView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textview.text else {return false}
    if text.count >= self.maxLength &&
        range.length == 0 &&
        range.location < self.maxLength {
      return false
    }
    return true
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.gray3 {
      textView.text = nil
      
      textView.textColor = UIColor.black
    }
    
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "리뷰를 입력하세요."
      textView.textColor = UIColor.gray3
    }
    
  }
}


// MARK: - UICollectionViewDataSource

extension WriteReviewViewController : UICollectionViewDataSource
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    reviewphotoCollectionView.showsHorizontalScrollIndicator = false
    return self.canAccessImages.count+1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReviewPhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? NewReviewPhotoCollectionViewCell else {
      return UICollectionViewCell()
    }
    guard let photocell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewPhotoCollectionViewCell.reuseIdentifier, for: indexPath)
            as? ReviewPhotoCollectionViewCell
    else {return UICollectionViewCell() }
    
    if indexPath.item == 0 {
      emptyCell.awakeFromNib()
      return emptyCell
    } else {
      print(canAccessImages)
      photocell.reviewPhotoImageView.image = self.canAccessImages[indexPath.item-1]
      photocell.setRounded(radius: 5)
      photocell.awakeFromNib()
      return photocell
    }
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(#function)
    if indexPath.item == 0 {
      if changetiming == 0 { /// 올린 사진이 5장 미만일 때
        self.photoLibraryWork()
      } else { /// 올린 사진이 5장일 때
        
        self.showGrayToast(message: "사진은 최대 5장까지 등록가능합니다.")
        self.reviewphotoCollectionView.allowsSelection = false
      }
      self.reviewphotoCollectionView.allowsSelection = true
    }
  }
}


extension WriteReviewViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //    let width = UIScreen.main.bounds.width
    let cellWidth = 80
    let cellHeight = cellWidth
    
    return CGSize(width: cellWidth, height: cellHeight)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 3
  }
}


