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
  var checkDeleteNotification: Bool = false /// 휴지통 버튼을 눌렀으면 트루, 휴지통 버튼을 누르지 않았으면 false
  var isSet: Bool = false /// 맨 처음에만 버튼 unselect로 지정하기 위한 불값
  
  var cafeName: String? = ""
  var cafeRating: Float? = 0.0
  var cafeAddress: String? = ""
  var cafeTagArray: [Tag] = [] /// 서버 연결한 후 tagcollectionview에 사용

  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    print(#function)
    register()
    attribute()
    layout()
    notificationCenter()
    reloadInputViews()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}

extension CategoryCafeListTableViewCell {
  func register() {
    self.tagCollectionView.register(MyTagCollectionViewCell.self, forCellWithReuseIdentifier: MyTagCollectionViewCell.reuseIdentifier)
  }
  func attribute() {
    self.tagCollectionView.delegate = self
    self.tagCollectionView.dataSource = self
  }
  func layout() { /// 휴지통 버튼 눌리지 않았으면
    if checkDeleteNotification == false { /// 체크 버튼 숨기기
      self.checkButton.isHidden = true
    }
    else { /// 휴지통 버튼 눌렀으면
      self.checkButton.isHidden = false /// 체크 버튼 보이게하고
      layoutDelete() /// 주소 라벨 레이아웃 조정
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
      $0.setupLabel(text: self.cafeName ?? "", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.sizeToFit()
      $0.letterSpacing = -0.8
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(20)
        $0.leading.equalTo(self.contentView.snp.leading).offset(30)
        $0.height.equalTo(18)
      }
    }
  }
  func layoutStarImageView() {
    self.contentView.add(self.starImageView) {
      $0.image = UIImage(named: "star")
      $0.snp.makeConstraints {
        $0.height.equalTo(11)
        $0.width.equalTo(11)
        $0.leading.equalTo(self.nameLabel.snp.trailing).offset(6)
        $0.centerY.equalTo(self.nameLabel.snp.centerY)
      }
    }
  }
  func layoutScoreLabel() {
    self.contentView.add(self.scoreLabel) {
      $0.setupLabel(text: "\(self.cafeRating)", color: .pointcolorYellow, font: UIFont.notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.height.equalTo(18)
        $0.width.equalTo(18)
        $0.leading.equalTo(self.starImageView.snp.trailing).offset(4)
        $0.centerY.equalTo(self.nameLabel.snp.centerY)
      }
    }
  }
  func layoutExplainLabel() {
    self.contentView.add(self.explainLabel) {
      $0.numberOfLines = 0
      $0.lineBreakMode = .byCharWrapping
      $0.sizeToFit()
      $0.setupLabel(text: self.cafeAddress ?? "", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 12))
      if self.checkDeleteNotification == true {
        self.layoutDelete()
      }
      else {
        $0.snp.makeConstraints {
          $0.top.greaterThanOrEqualTo(self.nameLabel.snp.bottom).offset(13)
          $0.leading.equalToSuperview().offset(30)
          $0.trailing.equalToSuperview().offset(-30)
        }
      }
    }
  }
  func layoutCheckButton() {
    self.contentView.add(self.checkButton) {
      if self.isSet == false {
        $0.setImage(UIImage(named: "checkboxInactive"), for: .normal)
        self.isSet = true
      }
      $0.addTarget(self, action: #selector(self.checkButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(24)
        $0.height.equalTo(24)
        $0.centerY.equalTo(self.explainLabel.snp.centerY)
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
    setCheckButtonImage(bool: self.checkButton.isSelected)
    if checkButton.isSelected == true {
      /// 노티
      let indexPath = self.getTableCellIndexPath()
      NotificationCenter.default.post(name: NSNotification.Name("AppendToDeleteArray"), object: indexPath)
    }
    else {
      let indexPath = self.getTableCellIndexPath()
      NotificationCenter.default.post(name: NSNotification.Name("RemoveDeleteArray"), object: indexPath)
    }
    NotificationCenter.default.post(name: NSNotification.Name("CheckButtonClicked"), object: checkButton.isSelected)
  }
  func setCheckButtonImage(bool: Bool) {
    switch self.checkButton.isSelected {
    case true: self.checkButton.setImageByName("checkboxActive")
    case false: self.checkButton.setImageByName("checkboxInactive")
    }
  }
  func setCafeData(name: String, rating: Float, address: String, tagArray: [Tag]) {
    self.nameLabel.text = name
    self.scoreLabel.text = "\(rating)"
    self.explainLabel.text = address
    self.cafeTagArray = tagArray
  }
}

// MARK: - CollectionView Delegate
/// tag CollectionView
extension CategoryCafeListTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    /// 사용하려는 라벨 크기 받아서 동적으로 셀 크기 맞춰줄거임
    let label = UILabel().then {
      $0.font = .notoSansKRMediumFont(fontSize: 12)
      $0.text = cafeTagArray[indexPath.row].name
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
    return cafeTagArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTagCollectionViewCell.reuseIdentifier, for: indexPath) as? MyTagCollectionViewCell else { return UICollectionViewCell() }
    tagCell.awakeFromNib()
    /// 서버 연결 후, TagCollectionViewCell에 라벨 텍스트 바꾸는 함수 만들어서 여기서 쓰기
    tagCell.setTagData(tag: cafeTagArray[indexPath.row].name)
    return tagCell
  }
}
