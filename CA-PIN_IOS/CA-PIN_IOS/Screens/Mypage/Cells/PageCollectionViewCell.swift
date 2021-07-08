//
//  PageCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

import SnapKit
import Then

class PageCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  let categoryTableView = UITableView()
  let reviewTableView = UITableView()
  let reviewHeaderView = UITableViewHeaderFooterView()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    attribute()
    layout()
    register()
  }
}

extension PageCollectionViewCell {
  func register() {
    print("여기야여기")
    self.categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
    self.reviewTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.reuseIdentifier)
  }
  func attribute() {
    categoryTableView.delegate = self
    categoryTableView.dataSource = self
    reviewTableView.delegate = self
    reviewTableView.dataSource = self
    reviewTableView.tableHeaderView = reviewHeaderView
  }
  func layout() {
    layoutCategoryTableView()
    layoutReviewTableView()
  }
  func layoutCategoryTableView() {
    self.contentView.add(categoryTableView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
  func layoutReviewTableView() {
    self.contentView.add(reviewTableView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
}

extension PageCollectionViewCell: UITableViewDelegate {
  
}

extension PageCollectionViewCell: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    switch tableView {
    case categoryTableView:
      return 1
    case reviewTableView:
      return 2
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case categoryTableView:
      return 4
    case reviewTableView:
      return 5
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == categoryTableView {
      guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else {
        return UITableViewCell()
      }
      categoryCell.awakeFromNib()
      return categoryCell
    } else {
//      if indexPath.section == 0 {
//
//      }
      guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.reuseIdentifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
      reviewCell.awakeFromNib()
      return reviewCell
    }
  }
}

