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
    layout.minimumInteritemSpacing = 6
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let imageCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
//    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 5
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  let bottomView = UIView()
  
  // MARK: - Variables
  var cafeName: String = "후엘고"
  var tagArray: [String] = [] /// 서버 연결한 후 tagcollectionview에 사용 -> 여기가 아니라 reviewcollectionViewcell에 있어야함
  var imageArray: [String] = ["hihi"] /// 서버 연결한 후 reviewImageCollectionview에 사용 -> 여기가 아니라 reviewcollectionViewcell에 있어야함
  var recommendList: [Int] = []
  var imageList: [String] = []
  var reviewList: [Review] = []
  var reviewModel: Review?
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
//    let parentViewController: UIViewController = self.parentViewController!
    register()
    attribute()
    layout()
    self.recommendList = self.reviewModel?.recommend ?? [10]
    self.imageList = self.reviewModel?.imgs ?? ["hi"]
//    bindTagList(tag: recommendList)
  }
}
extension MyReviewTableViewCell {
  // MARK: - Helpers
  func register() {
    self.tagCollectionView.register(MyTagCollectionViewCell.self, forCellWithReuseIdentifier: MyTagCollectionViewCell.reuseIdentifier)
    self.imageCollectionView.register(ReviewImageCollectionViewCell.self, forCellWithReuseIdentifier: ReviewImageCollectionViewCell.reuseIdentifier)
  }
  func attribute() {
    self.tagCollectionView.delegate = self
    self.tagCollectionView.dataSource = self
    self.imageCollectionView.delegate = self
    self.imageCollectionView.dataSource = self
  }
  @objc func moreButtonClicked() {
    /// TODO: - 카페 상세보기로 이동
    let cafeDetailVC = CafeDetailViewController()
    parentViewController?.navigationController?.pushViewController(cafeDetailVC, animated: false)
    
  }
//  @objc func editButtonClicked() {
//    /// TODO: - 리뷰 수정으로 이동
//    print("짭")
//    let dvc = WriteReviewViewController()
//
//
//    parentViewController?.navigationController?.pushViewController(dvc, animated: false)
//  }
  func bindTagList(tag: [Int]) {
    if tag.count != 0 {
      for i in 0...tag.count-1 {
        print(tag[i])
        tagArray.append(tag[i] == 0 ? "맛 추천" : "분위기 추천")
        print(tagArray)
      }
    }
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
    layoutBottomView()
  }
  func layoutNameLabel() {
    self.contentView.add(self.nameLabel) {
      $0.setupLabel(text: self.cafeName, color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 16))
      $0.letterSpacing = -0.8
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
        $0.centerY.equalTo(self.nameLabel.snp.centerY)
        $0.leading.equalTo(self.nameLabel.snp.trailing).offset(8)
      }
    }
  }
  func layoutScoreLabel() {
    self.contentView.add(self.scoreLabel) {
      $0.setupLabel(text: "3.5", color: .pointcolorYellow, font: UIFont.notoSansKRRegularFont(fontSize: 12), align: .center)
      $0.snp.makeConstraints {
        $0.width.equalTo(25)
        $0.height.equalTo(16)
        $0.centerY.equalTo(self.nameLabel.snp.centerY)
        $0.leading.equalTo(self.starImageView.snp.trailing).offset(1)
      }
    }
  }
  func layoutMoreButton() {
    self.contentView.add(self.moreButton) {
      $0.setImage(UIImage(named: "iconSeemore"), for: .normal)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.centerY.equalTo(self.nameLabel.snp.centerY)
        $0.leading.equalTo(self.scoreLabel.snp.trailing).offset(4)
      }
    }
  }
  func layoutEditButton() {
    self.contentView.add(self.editButton) {
      $0.setImage(UIImage(named: "iconEdit"), for: .normal)
      $0.addTarget(self, action: #selector(self.editButtonClicekd), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.centerY.equalTo(self.nameLabel.snp.centerY)
        $0.trailing.equalTo(self.contentView.snp.trailing).offset(-3)
      }
    }
  }
  func layoutReviewText() {
    self.contentView.add(self.reviewText) {
      $0.numberOfLines = 0
      $0.lineBreakMode = .byCharWrapping
      $0.sizeToFit()
      $0.setupLabel(text: "무엇보다 커피가 정말 맛있고, 디저트로 준비돼 있던 쿠키와 휘낭시에도 맛있었습니다.  브라운크림은 꼭 드세요 !",
                    color: .black,
                    font: UIFont.notoSansKRRegularFont(fontSize: 12))
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
        $0.top.greaterThanOrEqualTo(self.tagCollectionView.snp.bottom).offset(15)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
      }
    }
  }
  func layoutBottomView() {
    self.contentView.add(self.bottomView) {
      $0.snp.makeConstraints {
        $0.height.equalTo(24)
        $0.leading.equalToSuperview()
        $0.trailing.equalToSuperview()
        $0.top.greaterThanOrEqualTo(self.imageCollectionView.snp.bottom)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
  @objc func editButtonClicekd() {
    /// 액션시트
    let alertController: UIAlertController
    alertController = UIAlertController(title: "리뷰 편집", message: nil, preferredStyle: .actionSheet)

    let editAction: UIAlertAction
    editAction = UIAlertAction(title: "리뷰 수정", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
      /// 리뷰 수정 뷰로 이동
    })
    let deleteAction: UIAlertAction
    deleteAction = UIAlertAction(title: "리뷰 삭제", style: .destructive, handler: { (action: UIAlertAction) in
      /// 삭제 팝업 띄우기
      let deleteReviewVC = DeleteReviewViewController()
      deleteReviewVC.modalPresentationStyle = .overCurrentContext
      deleteReviewVC.reviewId = self.reviewModel?.id ?? ""
      self.parentViewController?.present(deleteReviewVC, animated: false, completion: nil)
    })

    let cancelAction: UIAlertAction
    // nil은 사용자가 누르면 아무 액션없이 alert이 dismiss된다
    cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)

    // action을 추가해줘야 실행된다.
    // 액션 순서에 상관없이 어떻게 넣어주더라도 위치는 UIAlertController가 알아서 지정해준다
    alertController.addAction(editAction)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    
    alertController.view.tintColor = .maincolor1

    // 모달로 올려줌! completion은 모달이 올라오는 애니메이션이 끝나고 직후에 호출될 블럭
    parentViewController?.present(alertController, animated: true, completion: nil)
  }
}
extension MyReviewTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var width: CGFloat?
    var height: CGFloat?
    
    if collectionView == tagCollectionView {
      /// 사용하려는 라벨 크기 받아서 동적으로 셀 크기 맞춰줄거임
      bindTagList(tag: recommendList)

      let label = UILabel().then {
        $0.font = .notoSansKRMediumFont(fontSize: 12)
        $0.text = tagArray[indexPath.row]
        $0.sizeToFit()
      }
      let size = label.frame.size
      return CGSize(width: size.width + 28, height: 22)
    }
    else {
      if self.reviewModel?.imgs?.isEmpty == false {
        width = (self.contentView.frame.width-22)/4
        height = (self.contentView.frame.width-22)/4
      }
      else {
        width = (self.contentView.frame.width-22)/4
        height = 0
        self.imageCollectionView.snp.remakeConstraints {
          $0.height.equalTo(0)
        }
        return CGSize(width: width!, height: height!)
      }
    }
    return CGSize(width: width!, height: height!)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case tagCollectionView: return 6
    case imageCollectionView: return 10
    default: return 5
    }
  }
}
extension MyReviewTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case tagCollectionView: return reviewModel?.recommend?.count ?? 0
    case imageCollectionView:
      let count = reviewModel?.imgs?.count ?? 0
      if count < 3 {return count}
      return 3
    default: return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case tagCollectionView:
      guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyTagCollectionViewCell.reuseIdentifier, for: indexPath) as? MyTagCollectionViewCell else { return UICollectionViewCell()}
      tagCell.awakeFromNib()
      tagCell.setTagData(tag: tagArray[indexPath.row])
      return tagCell
    case imageCollectionView:
      guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewImageCollectionViewCell.reuseIdentifier, for: indexPath) as? ReviewImageCollectionViewCell else { return UICollectionViewCell() }
      imageCell.awakeFromNib()
      // cell에서 이미지 넣는 함수 만들어서 쓰기
      let count = reviewModel?.imgs?.count ?? 0
      if count >= 4 { /// TODO: - 웅엥.count >= 4
        if indexPath.row == 2 {
          imageCell.overlayButton.isHidden = false
          imageCell.overlayButton.isEnabled = true
          imageCell.overlayButton.setTitle("+\(count-2)", for: .normal)
        }
      }
      return imageCell
    default: return UICollectionViewCell()
    }
  }
}
