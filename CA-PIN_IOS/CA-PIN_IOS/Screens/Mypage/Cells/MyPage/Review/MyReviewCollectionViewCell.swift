//
//  MyReviewCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/09.
//

import UIKit

class MyReviewCollectionViewCell: UICollectionViewCell {
  // MARK: - Components
  let headerView = UIView()
  let headerLabel = UILabel()
  let myReviewTableView = UITableView()
  var isEmpty: Bool = false /// 리뷰 존재하는지 체크하는 불
  var reviewNumber: Int = 10 /// 리뷰 개수
    
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    register()
    associate()
    layout()
    self.myReviewTableView.separatorStyle = .none
  }
}
extension MyReviewCollectionViewCell {
  func register() {
    /// 분기처리
    /// 리뷰가 0개일 때: EmptyReviewTableViewCell
    /// 리뷰가 1개 이상일 때: MyReviewTableViewCell
//    self.myReviewTableView.register(EmptyReviewTableViewCell.self, forCellReuseIdentifier: EmptyReviewTableViewCell.reuseIdentifier)
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
      $0.setupLabel(text: "총 \(self.reviewNumber)개의 리뷰", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
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
    tableView.estimatedRowHeight = 500
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 30
  }
  
}
extension MyReviewCollectionViewCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    /// 분기처리
    /// 리뷰가 0개면 1, 아니면 ReviewNumber
//    return 1
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /// 분기처리
    /// 리뷰가 0개일 때: EmptyReviewTableViewCell
    /// 리뷰가 1개 이상일 때: MyReviewTableViewCell
//    guard let emptycell = tableView.dequeueReusableCell(withIdentifier: EmptyReviewTableViewCell.reuseIdentifier, for: indexPath) as? EmptyReviewTableViewCell else { return UITableViewCell() }
//    emptycell.awakeFromNib()
//    return emptycell
    guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: MyReviewTableViewCell.reuseIdentifier, for: indexPath) as? MyReviewTableViewCell else { return UITableViewCell() }
    reviewCell.awakeFromNib()
    return reviewCell
  }
}
