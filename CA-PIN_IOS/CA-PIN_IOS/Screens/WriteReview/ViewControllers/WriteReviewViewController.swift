//
//  WriteReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/09.
//

import Photos
import PhotosUI
import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - WriteReviewViewController

class WriteReviewViewController: UIViewController, PHPhotoLibraryChangeObserver {
  
  
  // MARK: - Components
  
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
  
  final let maxLength = 150
  var nameCount = 0
  
  //  var photoList : [ReviewPhotoModel] = []
  
  var fetchResult: PHFetchResult<PHAsset>?
  var canAccessImages: [UIImage] = []
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    PHPhotoLibrary.shared().register(self)
    layout()
    register()
    //    setPhotoList()
    self.reviewphotoCollectionView.delegate = self
    self.reviewphotoCollectionView.dataSource = self
    self.navigationController?.navigationBar.isHidden = true
    self.reviewTextView.delegate = self
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.textDidChange(_:)),
                                           name: UITextView.textDidChangeNotification,
                                           object: self.reviewTextView)
    
    //    let requiredAccessLevel: PHAccessLevel = .readWrite
    //    PHPhotoLibrary.requestAuthorization(for: requiredAccessLevel) { authorizationStatus in
    //      switch authorizationStatus {
    //      case .limited:
    //        print("limited authorization granted")
    //      case .authorized:
    //        print("authorization granted")
    //      default:
    //        //FIXME: Implement handling for all authorizationStatus
    //        print("Unimplemented")
    //      }
    //    }
  }
  
  
  //  func setPhotoList()
  //  {
  //    photoList.append(contentsOf: [
  //      ReviewPhotoModel(PhotoImageView: "group637"),
  //      ReviewPhotoModel(PhotoImageView: "group637"),
  //      ReviewPhotoModel(PhotoImageView: "group637"),
  //      ReviewPhotoModel(PhotoImageView: "group637"),
  //      ReviewPhotoModel(PhotoImageView: "group637")
  //
  //    ])
  //  }
  //
  
}


// MARK: - Extension

extension WriteReviewViewController {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
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
        $0.bottom.equalTo(self.writeScrollContainerView.snp.bottom).offset(-550)
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
  
  @objc func textDidChange(_ notification: Notification) {
    if let textField = notification.object as? UITextView {
      if let text = textField.text {
        if text.isEmpty == false {
          self.reviewwordcountLabel.text = "\(text.count)/150"
        }
        if text.count > self.maxLength {
          textField.resignFirstResponder()
        }
        if text.count >= maxLength {
          let index = text.index(text.startIndex, offsetBy: maxLength)
          let newString = text[text.startIndex..<index]
          textField.text = String(newString)
        }
      }
    }
  }
  func addPhotoTab() {
    self.requestPHPhotoLibraryAuthorization {
      self.getCanAccessImages()
    }
  }
  func requestPHPhotoLibraryAuthorization(completion: @escaping () -> Void) {
    PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
      switch status {
      case .limited:
        completion()
        PHPhotoLibrary.shared().register(self)
      default:
        completion()
        PHPhotoLibrary.shared().register(self)
        break
      }
    }
  }
  func getCanAccessImages() {
    self.canAccessImages = []
    let requestOptions = PHImageRequestOptions()
    requestOptions.isSynchronous = true
    let fetchOptions = PHFetchOptions()
    self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
    self.fetchResult?.enumerateObjects { (asset, _, _) in
      PHImageManager().requestImage(for: asset,
                                    targetSize: CGSize(width: 80, height: 80),
                                    contentMode: .aspectFill,
                                    options: requestOptions) { (image, info) in
        guard let image = image
        else { return };
        self.canAccessImages.append(image); DispatchQueue.main.async {
          //          self.reviewphotoCollectionView.insertItems(at: [IndexPath(item: self.canAccessImages.count - 1, section: 0)])
          self.reviewphotoCollectionView.reloadData()
          
          
        }
      }
      
    }
  }
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    self.getCanAccessImages()
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
      photocell.reviewPhotoImageView.image = self.canAccessImages[indexPath.item-1]
      photocell.awakeFromNib()
      return photocell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if indexPath.item == 0 {
      self.addPhotoTab()
    }
    
  }
}

extension WriteReviewViewController : UICollectionViewDelegateFlowLayout
{
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

