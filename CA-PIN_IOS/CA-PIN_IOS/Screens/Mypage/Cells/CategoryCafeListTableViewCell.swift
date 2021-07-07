//
//  CategoryDetailTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/08.
//

/// 휴지통 버튼 누른 노티 받기?

import UIKit

// MARK: - CategoryCafeListTableViewCell
class CategoryCafeListTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let nameLabel = UILabel()
  let starImageView = UIImageView()
  let scoreLabel = UILabel()
  let explainLabel = UILabel()
  let checkButton = UIButton()
  let tagCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let separatorView = UIView()

  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    register()
    attribute()
    layout()
    NotificationCenter.default.addObserver(self, selector: #selector(layoutDelete), name: Notification.Name("DeleteButton"), object: nil)
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}

extension CategoryCafeListTableViewCell {
  func register() {
    self.tagCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
  }
  func attribute() {
    self.tagCollectionView.delegate = self
    self.tagCollectionView.dataSource = self
  }
  func layout() {
    layoutNameLabel()
    layoutStarImageView()
    layoutScoreLabel()
    layoutExplainLabel()
    layoutCheckButton()
    layoutTagCollectoinView()
    layoutSeparatorView()
    self.checkButton.isHidden = true
  }
  func layoutNameLabel() {
    self.contentView.add(self.nameLabel) {
      $0.setupLabel(text: "내겐사랑이었음을", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.sizeToFit()
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(20)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.height.equalTo(18)
      }
    }
  }
  func layoutStarImageView() {
    self.contentView.add(self.starImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.height.equalTo(11)
        $0.width.equalTo(11)
        $0.leading.equalTo(self.nameLabel.snp.trailing).offset(6)
        $0.bottom.equalTo(self.nameLabel.snp.bottom)
      }
    }
  }
  func layoutScoreLabel() {
    self.contentView.add(self.scoreLabel) {
      $0.setupLabel(text: "3.5", color: .pointcolorYellow, font: UIFont.notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.height.equalTo(18)
        $0.width.equalTo(18)
        $0.top.equalTo(self.contentView.snp.top).offset(20)
        $0.leading.equalTo(self.starImageView.snp.trailing).offset(4)
      }
    }
  }
  func layoutExplainLabel() {
    self.contentView.add(self.explainLabel) {

//      $0.lineBreakMode = .byWordWrapping
      $0.lineBreakMode = .byClipping
      $0.numberOfLines = 3
      $0.sizeToFit()
      $0.setupLabel(text: "서울 마포구 마포대로11길 118 1층 (염리동) 주소가 길어지면 여기까지 내려올 수 있다~서울 마포구 마포대로11길 118 1층 (염리동) 주소가 길...", color: .gray4
                    , font: UIFont.notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.height.equalTo(24)
        $0.top.equalTo(self.nameLabel.snp.bottom).offset(13)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  func layoutCheckButton() {
    self.contentView.add(self.checkButton) {
      $0.setImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.width.equalTo(24)
        $0.height.equalTo(24)
        $0.top.equalTo(self.contentView.snp.top).offset(63)
        $0.trailing.equalTo(self.contentView.snp.trailing).offset(-4)
      }
    }
  }
  func layoutTagCollectoinView() {
    self.contentView.add(self.tagCollectionView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainLabel.snp.bottom).offset(15)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  func layoutSeparatorView() {
    self.contentView.add(self.separatorView) {
      $0.backgroundColor = .gray2
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.bottom.equalTo(self.contentView.snp.bottom)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  @objc func layoutDelete() {
    self.explainLabel.snp.remakeConstraints {
      $0.height.equalTo(24)
      $0.top.equalTo(self.nameLabel.snp.bottom).offset(13)
      $0.leading.equalTo(self.contentView.snp.leading)
      $0.trailing.equalTo(self.checkButton.snp.leading).offset(-24)
    }
    self.checkButton.isHidden = false
  }
}

// MARK: - CollectionView Delegate
/// tag CollectionView
extension CategoryCafeListTableViewCell: UICollectionViewDelegateFlowLayout {
  
}

// MARK: - CollectionView DataSource
extension CategoryCafeListTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    /// 서버 연결 후, 태그 개수만큼으로 바꾸기
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
    tagCell.awakeFromNib()
    /// 서버 연결 후, TagCollectionViewCell에 라벨 텍스트 바꾸는 함수 만들어서 여기서 쓰기
    return tagCell
  }
}
