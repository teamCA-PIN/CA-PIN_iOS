//
//  MyReviewCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/09.
//

import UIKit
import Moya
import RxMoya
import RxSwift

class MyReviewCollectionViewCell: UICollectionViewCell {
  // MARK: - Components
  let headerView = UIView()
  let headerLabel = UILabel()
  let myReviewTableView = UITableView()
  var isEmpty: Bool = false /// 리뷰 존재하는지 체크하는 불
  var reviewNumber: Int = 0 /// 리뷰 개수
  
  var reviewList: [Review] = [Review(id: "", cafeName: "", cafeID: "", content: "", rating: 0, createAt: "", imgs: [], recommend: [])] /// 서버에서 리뷰 받아올 배열
  var cafeNameList: [String] = [] /// 서버에서 받아온 값 중에 카페 이름만 저장
  var ratingList: [Double] = [] /// 서버에서 별점 값만ㄴ 받아올 배열
  var reviewTextList: [String] = []
//  var imageURL:  /// 서버에서 받아온 값 중에 이미지 url만 저장
//  var recommendtTagList:  /// 서버에서 받아온 값 중에 태그 인트 값만 저장
  
  var rootViewController = UIViewController()
  
  let disposeBag = DisposeBag()
  private let UserServiceProvider = MoyaProvider<UserService>()
    
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    register()
    associate()
    myReviewTableView.reloadData()
    layout()
    self.myReviewTableView.separatorStyle = .none
  }
}
extension MyReviewCollectionViewCell {
  func register() {
    /// 분기처리
    /// 리뷰가 0개일 때: EmptyReviewTableViewCell
    /// 리뷰가 1개 이상일 때: MyReviewTableViewCell
    self.myReviewTableView.register(EmptyReviewTableViewCell.self, forCellReuseIdentifier: EmptyReviewTableViewCell.reuseIdentifier)
    self.myReviewTableView.register(MyReviewTableViewCell.self, forCellReuseIdentifier: MyReviewTableViewCell.reuseIdentifier)
  }
  func associate() {
    if reviewList.count > 0 { /// 리뷰가 1개 이상일 때에만 헤더뷰까지 등록
      self.myReviewTableView.tableHeaderView = headerView
      self.myReviewTableView.delegate = self
      self.myReviewTableView.dataSource = self
    } else { /// 리뷰가 0개일 때는 tableView만 등록
      self.myReviewTableView.delegate = self
      self.myReviewTableView.dataSource = self
    }
  }
  func layout() {
    layoutHeaderView()
    layoutHeaderLabel()
    layoutReviewTableView()
  }
  func layoutHeaderView() {
    headerView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 56)
  }
  func layoutHeaderLabel() {
    self.headerView.add(self.headerLabel) {
      $0.setupLabel(text: "총 \(self.reviewList.count)개의 리뷰", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.letterSpacing = -0.7
      $0.sizeToFit()
      $0.snp.makeConstraints {
        $0.height.equalTo(21)
        $0.top.equalTo(self.headerView.snp.top).offset(18)
        $0.leading.equalTo(self.headerView.snp.leading)
      }
    }
  }
  func layoutReviewTableView() {
    self.contentView.add(self.myReviewTableView) {
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.leading.equalToSuperview().offset(30)
        $0.trailing.equalToSuperview().offset(-30)
        $0.bottom.equalToSuperview()
      }
    }
  }
}
extension MyReviewCollectionViewCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if cafeNameList.count == 0 {
      return 257
    }
    
    tableView.estimatedRowHeight = 500
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension

    
//    if self.reviewList[indexPath.row].imgs == nil && self.reviewList[indexPath.row].recommend == nil{
//      return 110
//    }
//    else if self.reviewList[indexPath.row].imgs == nil {
//      return 140
//    }
//    else if self.reviewList[indexPath.row].recommend == nil {
//      return 198
//    }
//    else {
//      return 240
//    }
  }
}
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 30
  }
  
extension MyReviewCollectionViewCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if reviewList.count == 0{
      return 1
    }
    return reviewList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /// 분기처리
    /// 리뷰가 0개일 때: EmptyReviewTableViewCell
    /// 리뷰가 1개 이상일 때: MyReviewTableViewCell
    guard let emptycell = tableView.dequeueReusableCell(withIdentifier: EmptyReviewTableViewCell.reuseIdentifier, for: indexPath) as? EmptyReviewTableViewCell else { return UITableViewCell() }
    guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: MyReviewTableViewCell.reuseIdentifier, for: indexPath) as? MyReviewTableViewCell else { return UITableViewCell() }
    
    if reviewList.count == 0 {
      emptycell.awakeFromNib()
      return emptycell
    }
    reviewCell.reviewModel = reviewList[indexPath.row]
    reviewCell.nameLabel.setupLabel(text: reviewList[indexPath.row].cafeName, color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 16))
    reviewCell.nameLabel.letterSpacing = -0.8
    reviewCell.scoreLabel.setupLabel(text: "\(reviewList[indexPath.row].rating)", color: .pointcolorYellow, font: .notoSansKRRegularFont(fontSize: 12))
    reviewCell.reviewText.setupLabel(text: reviewList[indexPath.row].content, color: .black, font: .notoSansKRRegularFont(fontSize: 12))
    reviewCell.awakeFromNib()
    return reviewCell
  }
}
