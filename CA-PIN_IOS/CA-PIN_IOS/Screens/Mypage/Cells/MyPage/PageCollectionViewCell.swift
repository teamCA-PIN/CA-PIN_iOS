//
//  PageCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    let categoryTableView = UITableView()
    let reviewTableView = UITableView()
    let reviewHeaderView = UITableViewHeaderFooterView()
    
    // MARK: - LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
//        register()
//        attribute()
//        layout()
    }
}

extension PageCollectionViewCell {
    func register() {
        self.categoryTableView.register(MyCategoryTableViewCell.self, forCellReuseIdentifier: MyCategoryTableViewCell.reuseIdentifier)
        self.reviewTableView.register(MyReviewTableViewCell.self, forCellReuseIdentifier: MyReviewTableViewCell.reuseIdentifier)
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
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch tableView {
    case categoryTableView:
      return 61
    case reviewTableView:
      return 215
    default:
      return 0
    }
  }
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
        if indexPath.item == 0 {
            guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyCategoryTableViewCell else { return UITableViewCell() }
            categoryCell.awakeFromNib()
            return categoryCell
//            return UITableViewCell()
        } else {
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: MyReviewTableViewCell.reuseIdentifier, for: indexPath) as? MyReviewTableViewCell else { return UITableViewCell() }
            reviewCell.awakeFromNib()
            return reviewCell
//          return UITableViewCell()
        }
    }
}

