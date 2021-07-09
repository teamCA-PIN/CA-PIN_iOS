//
//  CategoryDetailTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/08.
//

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
    layout.minimumInteritemSpacing = 3
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let separatorView = UIView()
  
  // MARK: - Variables
  var checkDeleteNotification: Bool = false
  var tagArray: [String] = ["맛있겠지", "태그태그", "냥냠냥", "물선배", "커피커피커피커피커피커피", "지수선배", "선배", "뿡"] /// 서버 연결한 후 tagcollectionview에 사용

  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    register()
    attribute()
    layout()
    notificationCenter()
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
    if checkDeleteNotification == false {
      self.checkButton.isHidden = true
    }
    else {
      self.checkButton.isHidden = false
    }
    layoutNameLabel()
    layoutStarImageView()
    layoutScoreLabel()
    layoutExplainLabel()
    layoutCheckButton()
    layoutTagCollectoinView()
    layoutSeparatorView()
  }
  func layoutNameLabel() {
    self.contentView.add(self.nameLabel) {
      $0.setupLabel(text: "후엘고", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.sizeToFit()
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(20)
        $0.leading.equalTo(self.contentView.snp.leading).offset(30)
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
      $0.numberOfLines = 0
      $0.lineBreakMode = .byCharWrapping
      $0.sizeToFit()
      $0.setupLabel(text: "서울 마포구 마포대로11길 118 1층 (염리동) 주소가 길어지면 여기까지 내려올 수 있다~서울 마포구 마포대로11길 118 1층 (염리동) 주소가 길...", color: .gray4
                    , font: UIFont.notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(13)
        $0.leading.equalToSuperview().offset(30)
        $0.trailing.equalToSuperview().offset(-30)
      }
    }
  }
  func layoutCheckButton() {
    self.contentView.add(self.checkButton) {
      $0.setImage(UIImage(named: "logo"), for: .normal)
      $0.addTarget(self, action: #selector(self.checkButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(24)
        $0.height.equalTo(24)
        $0.top.equalTo(self.contentView.snp.top).offset(63)
        $0.trailing.equalTo(self.contentView.snp.trailing).offset(-24)
      }
    }
  }
  func layoutTagCollectoinView() {
    self.contentView.add(self.tagCollectionView) {
      $0.showsHorizontalScrollIndicator = false
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.greaterThanOrEqualTo(self.explainLabel.snp.bottom).offset(14)
        $0.height.equalTo(23)
        $0.leading.equalTo(self.contentView.snp.leading).offset(30)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  func layoutSeparatorView() {
    self.contentView.add(self.separatorView) {
      $0.backgroundColor = .gray2
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.top.equalTo(self.tagCollectionView.snp.bottom).offset(15)
        $0.bottom.equalTo(self.contentView.snp.bottom)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  func notificationCenter() {
    NotificationCenter.default.addObserver(self, selector: #selector(layoutDelete), name: Notification.Name("DeleteButton"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(layoutReturn), name: Notification.Name("returnCategoryView"), object: nil)
  }
  @objc func layoutDelete() {
    self.checkButton.isHidden = false
    self.checkDeleteNotification = true
    self.explainLabel.snp.remakeConstraints {
      $0.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(13)
      $0.leading.equalTo(self.contentView.snp.leading).offset(30)
      $0.trailing.equalTo(self.checkButton.snp.leading).offset(-24)
    }
  }
  @objc func layoutReturn() {
    self.checkButton.isHidden = true
    self.checkDeleteNotification = false
    self.explainLabel.snp.remakeConstraints {
      $0.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(13)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
    }
  }
  @objc func checkButtonClicked() {
    self.checkButton.isSelected.toggle()
    NotificationCenter.default.post(name: NSNotification.Name("CheckButtonClicked"), object: checkButton.isSelected)
  }
  func setRealData(name: String, score: String, address: String) {
    ///서버에서 받아온 값으로 라벨값 업데이트
    ///별점 스트링?
    self.nameLabel.text = name
    self.scoreLabel.text = score
    self.explainLabel.text = address
  }
}

// MARK: - CollectionView Delegate
/// tag CollectionView
extension CategoryCafeListTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    /// 사용하려는 라벨 크기 받아서 동적으로 셀 크기 맞춰줄거임
    let label = UILabel().then {
      $0.font = .notoSansKRMediumFont(fontSize: 12)
      $0.text = tagArray[indexPath.row]
      $0.sizeToFit()
    }
    let size = label.frame.size
    return CGSize(width: size.width + 20, height: 23)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 3
  }
}

// MARK: - CollectionView DataSource
extension CategoryCafeListTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    /// 서버 연결 후, 태그 개수만큼으로 바꾸기
    return tagArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
    tagCell.awakeFromNib()
    /// 서버 연결 후, TagCollectionViewCell에 라벨 텍스트 바꾸는 함수 만들어서 여기서 쓰기
    tagCell.setTagData(tag: tagArray[indexPath.row])
    return tagCell
  }
}
