//
//  EntireReviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/10.
//

import UIKit

import SnapKit
import Then

// MARK: - EntireReviewViewController
class EntireReviewViewController: UIViewController {
  
  // MARK: - Componets
  let topView = UIView()
  let backButton = UIButton()
  let titleLabel = UILabel()
  let headerView = UIView()
  let entireReviewLabel = UILabel()
  let reviewNumberLabel = UILabel()
  let photoOptionButton = UIButton()
  let photoOptionLabel = UILabel()
  let filterLabel = UILabel()
  let filterButton = UIButton()
  let separatorView = UIView()
  let reviewTableView = UITableView()
  
  var reviewModel: [ServerReview] = [ServerReview(id: " ", cafeID: " ", writer: Writer(id: " ", nickname: " ", profileImg: " "), rating: 0, createdAt: " ", content: " ", recommend: [], imgs: [])]
  
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
    dataBind()
    register()
    self.reviewTableView.dataSource = self
    self.reviewTableView.delegate = self
  }
  
  override func viewWillLayoutSubviews() {
    super.updateViewConstraints()
    self.reviewTableView.heightConstraint?.constant = self.reviewTableView.contentSize.height
  }
}

// MARK: - Extensions
extension EntireReviewViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    layoutTopView()
    layoutBackButton()
    layoutTitleLabel()
    layoutEntireReviewLabel()
    layoutReviewNumberLabel()
    layoutPhotoOptionButton()
    layoutPhotoOptionLabel()
    layoutFilterButton()
    layoutFilterLabel()
    layoutSeparatorView()
    layoutReviewTableView()
  }
  func layoutTopView() {
    view.add(topView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(44)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(48)
      }
    }
  }
  func layoutBackButton() {
    topView.add(backButton) {
      $0.setBackgroundImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedBackButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.topView.snp.leading).offset(20)
        $0.top.equalTo(self.topView.snp.top).offset(7)
        $0.width.height.equalTo(28)
      }
    }
  }
  func layoutTitleLabel() {
    topView.add(titleLabel) {
      $0.setupLabel(text: "리뷰 전체보기",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.backButton.snp.centerY)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutEntireReviewLabel() {
    view.add(entireReviewLabel) {
      $0.setupLabel(text: "전체 리뷰", color: .black, font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.top.equalTo(self.topView.snp.bottom).offset(9)
      }
    }
  }
  func layoutReviewNumberLabel() {
    view.add(reviewNumberLabel) {
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.entireReviewLabel.snp.trailing).offset(4)
        $0.centerY.equalTo(self.entireReviewLabel.snp.centerY)
      }
    }
  }
  func layoutPhotoOptionButton() {
    view.add(photoOptionButton) {
      $0.setBackgroundImage(UIImage(named: "btnViewphotoActive"), for: .normal)
      $0.setBackgroundImage(UIImage(named: "btnViewphotoInactive"), for: .selected)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.snp.leading).offset(18)
        $0.top.equalTo(self.entireReviewLabel.snp.bottom).offset(6)
        $0.height.width.equalTo(28)
      }
    }
  }
  func layoutPhotoOptionLabel() {
    view.add(photoOptionLabel) {
      $0.setupLabel(text: "포토리뷰만 보기", color: .black, font: .notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.photoOptionButton.snp.centerY)
        $0.leading.equalTo(self.photoOptionButton.snp.trailing).offset(2)
      }
    }
  }
  func layoutFilterButton() {
    view.add(filterButton) {
      $0.setBackgroundImage(UIImage(named: "btnUp"), for: .normal)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.view.snp.trailing).offset(-31.3)
        $0.centerY.equalTo(self.photoOptionLabel.snp.bottom)
        $0.width.equalTo(8.9)
        $0.height.equalTo(4)
      }
    }
  }
  func layoutFilterLabel() {
    view.add(filterLabel) {
      $0.setupLabel(text: "전체 리뷰", color: .gray4, font: .notoSansKRRegularFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.filterButton.snp.leading).offset(-4.8)
        $0.centerY.equalTo(self.filterButton.snp.centerY)
      }
    }
  }
  func layoutSeparatorView() {
    view.add(separatorView) {
      $0.backgroundColor = .gray2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.photoOptionButton.snp.bottom).offset(12)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(1)
      }
    }
  }
  func layoutReviewTableView() {
    view.add(reviewTableView) {
      $0.backgroundColor = .clear
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.separatorView.snp.bottom)
        $0.leading.equalTo(self.view.snp.leading).offset(16)
        $0.centerX.equalToSuperview()
        $0.bottom.equalTo(self.view.snp.bottom).offset(-55)
        $0.height.equalTo((self.reviewModel.count)*240)
      }
    }
  }
  
  // MARK: - General Helpers
  func register() {
    self.reviewTableView.register(DetailReviewTableViewCell.self, forCellReuseIdentifier: DetailReviewTableViewCell.reuseIdentifier)
  }
  @objc func clickedBackButton() {
    self.navigationController?.popViewController(animated: false)
  }
  func dataBind() {
    self.reviewNumberLabel.setupLabel(text: "\(self.reviewModel.count)", color: .gray4, font: .notoSansKRRegularFont(fontSize: 14))
  }
}

// MARK: - Extensions

// MARK: - ReviewTableView Delegate
extension EntireReviewViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 500
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }
}

// MARK: - ReviewTableView DataSource {
extension EntireReviewViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviewModel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let detailCell = tableView.dequeueReusableCell(withIdentifier: DetailReviewTableViewCell.reuseIdentifier, for: indexPath) as? DetailReviewTableViewCell else {
      return UITableViewCell()
    }
    detailCell.reviewModel = self.reviewModel[indexPath.row]
    detailCell.reviewDataBind(nickName: reviewModel[indexPath.row].writer.nickname,
                        date: reviewModel[indexPath.row].createdAt,
                        rating: Float(reviewModel[indexPath.row].rating),
                        content: reviewModel[indexPath.row].content,
                        profileImg: reviewModel[indexPath.row].writer.profileImg)
    detailCell.rootViewController = self
    detailCell.awakeFromNib()
    return detailCell
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    self.viewWillLayoutSubviews()
  }
}
