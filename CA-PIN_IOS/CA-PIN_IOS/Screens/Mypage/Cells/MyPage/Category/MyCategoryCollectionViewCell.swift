//
//  MyCategoryCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/09.
//

import UIKit

class MyCategoryCollectionViewCell: UICollectionViewCell {
  // MARK: - Components
  let headerView = UIView()
  let plusButton = UIButton()
  let plusLabel = UILabel()
  let separatorView = UIView()
  let myCategoryTableView = UITableView()
  
  // MARK: - Variables
  var categoryNumber = 10 /// 카테고리 수 기준으로 section 1개 or 2개
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    register()
    associate()
    layout()
    self.myCategoryTableView.separatorStyle = .none
  }
}
extension MyCategoryCollectionViewCell {
  func register() {
    self.myCategoryTableView.register(MyCategoryTableViewCell.self, forCellReuseIdentifier: MyCategoryTableViewCell.reuseIdentifier)
    self.myCategoryTableView.register(MyEmptyCategoryTableViewCell.self, forCellReuseIdentifier: MyEmptyCategoryTableViewCell.reuseIdentifier)
  }
  func associate() {
    self.myCategoryTableView.delegate = self
    self.myCategoryTableView.dataSource = self
    self.myCategoryTableView.tableHeaderView = headerView
  }
  func layout() {
    layoutHeaderview()
    layoutPlusButton()
    layoutPlusLabel()
    layoutSeparatorView()
    layoutCategoryTableView()
  }
  func layoutHeaderview() {
    headerView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 70)
  }
  func layoutPlusButton() {
    self.headerView.add(self.plusButton) {
      $0.setImage(UIImage(named: "plusCategory"), for: .normal)
      $0.addTarget(self, action: #selector(self.plusButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(29)
        $0.height.equalTo(29)
        $0.top.equalTo(self.headerView.snp.top).offset(26)
        $0.leading.equalTo(self.headerView.snp.leading).offset(26)
      }
    }
  }
  func layoutPlusLabel() {
    self.headerView.add(self.plusLabel) {
      $0.setupLabel(text: "새 카테고리", color: .gray4, font: UIFont.notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.headerView.snp.top).offset(30)
        $0.leading.equalTo(self.plusButton.snp.trailing).offset(22)
      }
    }
  }
  func layoutSeparatorView() {
    self.headerView.add(self.separatorView) {
      $0.backgroundColor = .gray2
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.width.equalToSuperview()
        $0.leading.equalToSuperview()
        $0.trailing.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
  }
  func layoutCategoryTableView() {
    self.contentView.add(self.myCategoryTableView) {
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(17)
        $0.top.equalToSuperview()
        $0.leading.equalToSuperview()
        $0.trailing.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
  }
  @objc func plusButtonClicked() {
    let parentViewController: UIViewController = self.parentViewController!
    let dvc = CreateCategoryViewController()
    self.parentViewController?.navigationController?.pushViewController(dvc, animated: false)
  }
}
extension MyCategoryCollectionViewCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if self.categoryNumber == 1 {
      if indexPath.section == 0 {
        return 53
      } else {
        return 201
      }
    }
    return 53
  }
}
extension MyCategoryCollectionViewCell: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    if self.categoryNumber == 1{ /// 기본 카테고리만 있는거
      return 2
    }
    /// 내가 등록한 카테고리도 있는거
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.categoryNumber == 1{ /// 기본 카테고리만 있는거
      return 1
    }
    /// 내가 등록한 카테고리도 있는거
    return 9 /// 웅엥.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if self.categoryNumber == 1 { /// 기본 카테고리만 있을 때엔
      if indexPath.section == 0 {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyCategoryTableViewCell else { return UITableViewCell() }
        categoryCell.awakeFromNib()
        categoryCell.selectionStyle = .none
        categoryCell.backgroundColor = .white
        if indexPath.item == 0 {
          categoryCell.editButton.isHidden = true
        }
        return categoryCell
      } else {
        /// empty 웅엥
        guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: MyEmptyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyEmptyCategoryTableViewCell else { return UITableViewCell() }
        emptyCell.awakeFromNib()
        return emptyCell
      }
    }
    guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyCategoryTableViewCell else { return UITableViewCell() }
    categoryCell.awakeFromNib()
    categoryCell.selectionStyle = .none
    categoryCell.backgroundColor = .white
    if indexPath.item == 0 {
      categoryCell.editButton.isHidden = true
    }
    return categoryCell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let parentViewController: UIViewController = self.parentViewController!
    let dvc = CategoryDetailViewController()
    parentViewController.navigationController?.pushViewController(dvc, animated: false)
  }
}
