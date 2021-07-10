//
//  ReviewTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let nameLabel = UILabel()
  let starImageView = UIImageView()
  let scoreLabel = UILabel()
  let moreButton = UIButton()
  let editButton = UIButton()
  let reviewText = UILabel()
  let tagCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let imageCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  // MARK: - Variables
  var cafeName: String = "후엘고"
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    let parentViewController: UIViewController = self.parentViewController!
    register()
    attribute()
    layout()
    // Configure the view for the selected state
  }
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
}
extension MyReviewTableViewCell {
  // MARK: - Helpers
  func register() {
    self.tagCollectionView.register(MyTagCollectionViewCell.self, forCellWithReuseIdentifier: MyTagCollectionViewCell.reuseIdentifier)
  }
  func attribute() {
    self.tagCollectionView.delegate = self
    self.tagCollectionView.dataSource = self
    self.imageCollectionView.delegate = self
    self.imageCollectionView.dataSource = self
  }
  @objc func moreButtonClicked() {
    /// 리뷰 상세보기로 이동
    let dvc = WriteReviewViewController()
    parentViewController?.navigationController?.pushViewController(dvc, animated: false)
  }
  @objc func editButtonClicked() {
    /// 리뷰 수정으로 이동
    let dvc = WriteReviewViewController()
    parentViewController?.navigationController?.pushViewController(dvc, animated: false)
  }
  
  // MARK: - layoutHelpers
  func layout() {
    layoutNameLabel()
    layoutStarImageView()
    layoutScoreLabel()
    layoutMoreButton()
    layoutEditButton()
    layoutReviewText()
    layoutTagCollectionView()
    layoutImageCollectionView()
  }
  func layoutNameLabel() {
    self.contentView.add(self.nameLabel) {
      $0.setupLabel(text: self.cafeName, color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.sizeToFit()
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(6)
        $0.leading.equalTo(self.contentView.snp.leading)
      }
    }
  }
  func layoutStarImageView() {
    self.contentView.add(self.starImageView) {
      $0.image = UIImage(named: "star")
      $0.snp.makeConstraints {
        $0.width.equalTo(14)
        $0.height.equalTo(14)
        $0.top.equalTo(self.contentView.snp.top).offset(7)
        $0.leading.equalTo(self.nameLabel.snp.trailing).offset(2)
      }
    }
  }
  func layoutScoreLabel() {
    self.contentView.add(self.scoreLabel) {
      $0.setupLabel(text: "3.5", color: .pointcolorYellow, font: UIFont.notoSansKRRegularFont(fontSize: 12), align: .center)
      $0.snp.makeConstraints {
        $0.height.equalTo(16)
        $0.top.equalTo(self.contentView.snp.top).offset(6)
        $0.leading.equalTo(self.scoreLabel.snp.trailing).offset(3)
      }
    }
  }
  func layoutMoreButton() {
    self.contentView.add(self.moreButton) {
      $0.setImage(UIImage(named: "iconSeemore"), for: .normal)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.scoreLabel.snp.trailing).offset(3)
      }
    }
  }
  func layoutEditButton() {
    self.contentView.add(self.editButton) {
      $0.setImage(UIImage(named: "iconEdit"), for: .normal)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.top.equalTo(self.contentView.snp.top).offset(1)
        $0.trailing.equalTo(self.contentView.snp.trailing).offset(-3)
      }
    }
  }
  func layoutReviewText() {
    self.contentView.add(self.reviewText) {
      $0.numberOfLines = 0
      $0.lineBreakMode = .byCharWrapping
      $0.sizeToFit()
      $0.setupLabel(text: "무엇보다 커피가 정말 맛있고, 디저트로 준비돼 있던 쿠키와 휘낭시에도 맛있었습니다.  브라운크림은 꼭 드세요 ! 무엇보다 커피가 정말 맛있고, 디저트로 준비돼 있던 쿠키와 휘낭시에도 맛있었습니다.  브라운크림은 꼭 드세요 !무엇보다 커피가 정말 맛있고, 디저트로 준비돼", color: .black
                    , font: UIFont.notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(13)
        $0.leading.equalToSuperview()
        $0.trailing.equalToSuperview()
      }
    }
  }
  func layoutTagCollectionView() {
    self.contentView.add(self.tagCollectionView) {
      $0.showsHorizontalScrollIndicator = false
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.greaterThanOrEqualTo(self.reviewText.snp.bottom).offset(14)
        $0.height.equalTo(23)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  func layoutImageCollectionView() {
    self.contentView.add(self.imageCollectionView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.height.equalTo(80)
        $0.top.equalTo(self.tagCollectionView.snp.bottom).offset(15)
        $0.bottom.equalTo(self.contentView.snp.bottom)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
}
extension MyReviewTableViewCell: UICollectionViewDelegateFlowLayout {
  
}
extension MyReviewTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case tagCollectionView: return 2
    case imageCollectionView: return 3
    default: return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case tagCollectionView:
      guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTagCollectionViewCell.reuseIdentifier, for: indexPath) as? MyTagCollectionViewCell else { return UICollectionViewCell()}
      tagCell.awakeFromNib()
      return tagCell
    case imageCollectionView: return UICollectionViewCell()
    default: return UICollectionViewCell()
    }
  }
}
