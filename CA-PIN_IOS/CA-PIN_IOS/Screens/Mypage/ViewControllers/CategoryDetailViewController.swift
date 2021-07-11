//
//  CategoryDetailViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/07.
//

import UIKit

import SnapKit
import Then

// MARK: - CategoryDetailViewController
class CategoryDetailViewController: UIViewController {
  
  // MARK: - Components
  let navigationContainerView = UIView()
  let backButton = UIButton()
  let categoryNameLabel = UILabel()
  let deleteButton = UIButton()
  let pinNumberLabel = UILabel()
  let cafeListTableView = UITableView().then {
    $0.estimatedRowHeight = 600
    $0.rowHeight = UITableView.automaticDimension
  }
  
  // MARK: - Variables
  let screenWidth = UIScreen.main.bounds.width
  let screenHeight = UIScreen.main.bounds.height
  var pinNumber = 0 ///해당 카테고리 속 핀 개수
  var countedPinNumber = 0 /// 삭제하려고 누른 핀의 수
  var enableDelete: Bool = false ///삭제 팝업 띄울겨 말겨
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    register()
    attribute()
    layout()
    notificationCenter()
  }
}

// MARK: Extensions
extension CategoryDetailViewController {
  // MARK: - Helpers
  func register() {
    /// 분기처리
    /// 카테고리 내의 핀이 0개일 때: EmptyCategoryTableViewCell
    /// 핀이 1개 이상일 때: CategoryCafeListTableViewCell
    self.cafeListTableView.register(CategoryCafeListTableViewCell.self, forCellReuseIdentifier: CategoryCafeListTableViewCell.reuseIdentifier)
  }
  func attribute() {
    self.cafeListTableView.delegate = self
    self.cafeListTableView.dataSource = self
  }
  
  //MARK: - Layout Helpers
  func layout() {
    layoutNavigationContainerView()
    layoutBackButton()
    layoutCategoryNameLabel()
    layoutDeleteButton()
    layoutPinNumberLabel()
    layoutCafeListTableView()
    self.cafeListTableView.separatorStyle = .none
    self.cafeListTableView.showsVerticalScrollIndicator = false
  }
  func layoutNavigationContainerView() {
    self.view.add(self.navigationContainerView) {
      $0.snp.makeConstraints {
        $0.width.equalTo(self.screenWidth)
        $0.height.equalTo(29)
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.leading.equalTo(self.view.snp.leading)
        $0.trailing.equalTo(self.view.snp.trailing)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutBackButton() {
    self.navigationContainerView.add(self.backButton) {
      $0.setImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.bottom.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(20)
      }
    }
  }
  func layoutCategoryNameLabel() {
    self.navigationContainerView.add(self.categoryNameLabel) {
      $0.setupLabel(text: "기본 카테고리", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20), align: .center)
      $0.snp.makeConstraints {
        $0.width.equalTo(160)
        $0.height.equalTo(29)
        $0.top.equalTo(self.navigationContainerView.snp.top)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutDeleteButton() {
    self.navigationContainerView.add(self.deleteButton) {
      $0.setImage(UIImage(named: "iconDeleteVer2"), for: .normal)
      $0.addTarget(self, action: #selector(self.deleteButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.top.equalTo(self.navigationContainerView.snp.top).offset(1)
        $0.trailing.equalTo(self.navigationContainerView.snp.trailing).offset(-20)
      }
    }
  }
  func layoutPinNumberLabel() {
    self.view.add(self.pinNumberLabel) {
      $0.setupLabel(text: "총 \(self.pinNumber)개의 핀", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.height.equalTo(16)
        $0.width.equalTo(80)
        $0.top.equalTo(self.navigationContainerView.snp.bottom).offset(27)
        $0.leading.equalTo(self.view.snp.leading).offset(30)
      }
    }
  }
  func layoutCafeListTableView() {
    self.view.add(self.cafeListTableView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.pinNumberLabel.snp.bottom).offset(8)
        $0.leading.equalTo(self.view.snp.leading)
        $0.trailing.equalTo(self.view.snp.trailing)
        $0.bottom.equalTo(self.view.snp.bottom)
      }
    }
  }
  func notificationCenter() {
    NotificationCenter.default.addObserver(self, selector: #selector(checkButtonClicked), name: Notification.Name("CheckButtonClicked"), object: nil)
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func deleteButtonClicked() {
    if self.categoryNameLabel.text == "기본 카테고리" {
      NotificationCenter.default.post(name: NSNotification.Name("DeleteButton"), object: nil)
    } else {
      /// 삭제 팝업 띄우기
      
    }
  }
  @objc func checkButtonClicked(notification: Notification) {
    if let check = notification.object as? Bool {
      changeNavigationTitle(check: check)
    }
  }
  func changeNavigationTitle(check: Bool) {
    if check == true {
      print("버튼 선택")
      countedPinNumber += 1
      self.categoryNameLabel.text = "\(countedPinNumber)개 선택됨"
      self.deleteButton.setImage(UIImage(named: "iconDeleteRed"), for: .normal)
      self.enableDelete = true
    } else {
      print("버튼 선택 해제")
      countedPinNumber -= 1
      if countedPinNumber == 0 {
        self.categoryNameLabel.text = "기본 카테고리"
        self.deleteButton.setImage(UIImage(named: "iconDeleteVer2"), for: .normal)
        /// 노티 post
        NotificationCenter.default.post(name: NSNotification.Name("returnCategoryView"), object: nil)
        print("다시 돌아가거라")
      }
      else {
        self.categoryNameLabel.text = "\(countedPinNumber)개 선택됨"
      }
    }
  }
}

extension CategoryDetailViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 500
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }
}

extension CategoryDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /// 분기처리
    /// 카테고리 내의 핀이 0개일 때: EmptyCategoryTableViewCell
    /// 핀이 1개 이상일 때: CategoryCafeListTableViewCell
    guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryCafeListTableViewCell.reuseIdentifier, for: indexPath) as? CategoryCafeListTableViewCell else {return UITableViewCell() }
    categoryCell.awakeFromNib()
    categoryCell.selectionStyle = .none
    /// categoryCell에 정보 뿌리는 함수 사용: setRealData()
    return categoryCell
  }
}
