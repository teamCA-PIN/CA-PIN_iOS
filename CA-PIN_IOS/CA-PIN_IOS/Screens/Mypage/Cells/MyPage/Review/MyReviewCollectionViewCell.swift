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
    getReviewListService()
    self.myReviewTableView.separatorStyle = .none
  }
}
extension MyReviewCollectionViewCell {
  func getReviewListService() {
    UserServiceProvider.rx.request(.reviews)
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ReviewResponseArrayType<Review>.self,
                                          from: response.data)
            self.reviewList = data.reviews!
            self.reviewNumber = data.reviews!.count
            self.headerLabel.text = "총 \(self.reviewList.count)개의 리뷰"
            for i in 0..<self.reviewList.count {
              self.cafeNameList.append(self.reviewList[i].cafeName)
              self.ratingList.append(self.reviewList[i].rating)
            }
            self.myReviewTableView.reloadData()
            let mypageVC = self.rootViewController as? MypageViewController
            mypageVC?.pageCollectionView.reloadData()
          } catch {
            print(error)
          }
        }
        else {
          
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
  }
  func register() {
    /// 분기처리
    /// 리뷰가 0개일 때: EmptyReviewTableViewCell
    /// 리뷰가 1개 이상일 때: MyReviewTableViewCell
    
    self.myReviewTableView.register(EmptyReviewTableViewCell.self, forCellReuseIdentifier: EmptyReviewTableViewCell.reuseIdentifier)
    self.myReviewTableView.register(MyReviewTableViewCell.self, forCellReuseIdentifier: MyReviewTableViewCell.reuseIdentifier)
    
    self.myReviewTableView.register(MyReviewTableViewCell.self, forCellReuseIdentifier: MyReviewTableViewCell.reuseIdentifier)
  }
  func associate() {
    self.myReviewTableView.delegate = self
    self.myReviewTableView.dataSource = self
    if isEmpty == false { /// 리뷰가 1개 이상일 때에만 헤더뷰 등록
      self.myReviewTableView.tableHeaderView = headerView
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
    //    tableView.estimatedRowHeight = 500
    //    tableView.rowHeight = UITableView.automaticDimension
    //    return UITableView.automaticDimension
    if self.reviewList[indexPath.row].imgs == nil && self.reviewList[indexPath.row].recommend == nil{
      return 110
    }
    else if self.reviewList[indexPath.row].imgs == nil {
      return 140
    }
    else if self.reviewList[indexPath.row].recommend == nil {
      return 198
    }
    else {
      return 240
    }
  }
}
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 30
  }
  
extension MyReviewCollectionViewCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    reviewCell.awakeFromNib()
    reviewCell.reviewModel = reviewList[indexPath.row]
    reviewCell.nameLabel.text = reviewList[indexPath.row].cafeName
    reviewCell.scoreLabel.text = "\(reviewList[indexPath.row].rating)"
    reviewCell.reviewText.text = reviewList[indexPath.row].content
    
    return reviewCell
  }
}
