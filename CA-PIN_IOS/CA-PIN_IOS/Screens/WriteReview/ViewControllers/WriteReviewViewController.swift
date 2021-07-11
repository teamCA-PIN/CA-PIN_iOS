//
//  WriteReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/09.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - WriteReviewViewController

class WriteReviewViewController: UIViewController {
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
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
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
  var reviewTextField = fourInsetTextField(insets: UIEdgeInsets(top: 15, left: 18, bottom: 20, right: 18))
  let reviewwordcountLabel = UILabel()
  let starLabel = UILabel()
  let staressentialImageView = UIImageView()
  let explainstarLabel = UILabel()
  
  final let maxLength = 150
  var nameCount = 0
  
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    self.navigationController?.navigationBar.isHidden = true
    self.reviewTextField.delegate = self
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.textDidChange(_:)),
                                           name: UITextField.textDidChangeNotification,
                                           object: self.reviewTextField)
  }
}

// MARK: - Extension

extension WriteReviewViewController {
  
  // MARK: - Helpers
  
  func register() {
    self.reviewphotoCollectionView.register(ReviewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: ReviewPhotoCollectionViewCell.reuseIdentifier)
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
    layoutReviewTextField()
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
        $0.leading.equalTo(self.writeScrollContainerView.snp.leading)
        $0.width.equalTo(545)
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
  func layoutReviewTextField() {
    self.writeScrollContainerView.add(self.reviewTextField) {
      $0.configureTextField(textColor: .black, font: .notoSansKRRegularFont(fontSize: 14))
      $0.attributedPlaceholder =
        NSAttributedString(string: "리뷰를 입력하세요.",
                           attributes:
                            [NSAttributedString.Key.font:
                              UIFont.notoSansKRRegularFont(fontSize: 14),
                             NSAttributedString.Key.foregroundColor:
                              UIColor.gray3])
      $0.autocorrectionType = .no
      $0.autocapitalizationType = .none
      $0.setBorder(borderColor: .gray3, borderWidth: 1)
      $0.setRounded(radius: 5)
      $0.backgroundColor = .pointcolor1
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
    self.reviewTextField.add(self.reviewwordcountLabel) {
      self.nameCount = self.reviewTextField.text?.count ?? 0
      $0.setupLabel(text: "\(self.nameCount)/150",
                    color: .gray3,
                    font: .notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.reviewTextField.snp.trailing).offset(-13)
        $0.bottom.equalTo(self.reviewTextField.snp.bottom).offset(-10)
      }
    }
  }
  func layoutStarLabel() {
    self.writeScrollContainerView.add(self.starLabel) {
      $0.setupLabel(text: "별점", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.reviewTextField.snp.bottom).offset(40)
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
    if let textField = notification.object as? UITextField {
      if let text = textField.text {
        self.reviewwordcountLabel.text = "\(text.count)/150"
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
}

// MARK: - ReviewTextField Delegate

extension WriteReviewViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else {return false}
    if text.count >= self.maxLength &&
        range.length == 0 &&
        range.location < self.maxLength {
      return false
    }
    return true
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: CGFloat
    switch indexPath.item {
    case 1:
      width = 80
    case 2:
      width = 80
    default:
      width = 80
    }
    return CGSize(width: 80, height: 80)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
  }
}

// MARK: - UICollectionViewDataSource

