//
//  CategoryDetailViewController.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/07.
//

import UIKit

import Moya
import RxMoya
import RxSwift
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
  var categoryTitle: String = ""
  
  let disposeBag = DisposeBag()
  private let CategoryService = MoyaProvider<CategoryService>()
  
  var cafeDetailArray: [CafeDetail] = [] /// 서버에서 받아온 카페 디테일 배열
  var cafeIdArray: [String] = [] /// 카페 id 값을 모두 저장할 배열 -> 삭제할 때 써야됨
  var cafeIdArrayToDelete: [String] = [] /// 삭제할 카페 id값만 넣어놓은 배열
  var categoryId: String = "" /// 선택된 카테고리 아이디 -> 삭제할 때 쓸거임
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    print(#function)
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    register()
    attribute()
    layout()
    notificationCenter()
  }
  override func viewWillAppear(_ animated: Bool) {
    print("카테고리 디테일 뷰컨 viewwillappear")
    print(#function)
    cafeListTableView.reloadData()
  }
}

// MARK: Extensions
extension CategoryDetailViewController {
  // MARK: - Helpers
  func register() {
    /// 분기처리
    /// 카테고리 내의 핀이 0개일 때: EmptyCategoryTableViewCell
    if pinNumber == 0{
      self.cafeListTableView.register(EmptyCategoryTableViewCell.self, forCellReuseIdentifier: EmptyCategoryTableViewCell.reuseIdentifier)
    }
    /// 핀이 1개 이상일 때: CategoryCafeListTableViewCell
    else {
      self.cafeListTableView.register(CategoryCafeListTableViewCell.self, forCellReuseIdentifier: CategoryCafeListTableViewCell.reuseIdentifier)
    }
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
      $0.setupLabel(text: self.categoryTitle, color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20), align: .center)
      $0.letterSpacing = -1.0
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
      $0.letterSpacing = -0.7
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
    NotificationCenter.default.addObserver(self, selector: #selector(appendDeleteArray), name: Notification.Name("AppendToDeleteArray"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(removeDeleteArray), name: Notification.Name("RemoveDeleteArray"), object: nil)
  }
  @objc func appendDeleteArray(notification: Notification) {
    if let index = notification.object as? Int {
      self.cafeIdArrayToDelete.append(self.cafeIdArray[index])
    }
    print("추가")
    print(cafeIdArrayToDelete)
  }
  @objc func removeDeleteArray(notification: Notification) {
    if let index = notification.object as? Int {
      if let firstIndex = cafeIdArrayToDelete.firstIndex(of: cafeIdArray[index]) {
          cafeIdArrayToDelete.remove(at: firstIndex)
      }
    }
    print("제거")
    print(cafeIdArrayToDelete)
  }
  @objc func backButtonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func deleteButtonClicked() {
    if self.categoryNameLabel.text == categoryTitle {
      NotificationCenter.default.post(name: NSNotification.Name("DeleteButton"), object: nil)
    } else {
      /// 삭제 팝업 띄우기
      let dvc = DeletePinViewController()
      dvc.categoryId = self.categoryId
      dvc.cafeIdArrayToDelete = self.cafeIdArrayToDelete
//      dvc.modalPresentationStyle = .overFullScreen
//      self.present(dvc, animated: false, completion: nil)
      self.navigationController?.pushViewController(dvc, animated: false)
    }
  }
  /// 체크버튼 check, uncheck 상태에 따라서 네비게이션 타이틀 바꿈
  @objc func checkButtonClicked(notification: Notification) {
    if let check = notification.object as? Bool {
      changeNavigationTitle(check: check)
    }
  }
  func changeNavigationTitle(check: Bool) {
    /// 체크 버튼 선택 액션이면  타이틀 "n개 선택됨"으로
    if check == true {
      countedPinNumber += 1
      self.categoryNameLabel.text = "\(countedPinNumber)개 선택됨"
      self.deleteButton.setImage(UIImage(named: "iconDeleteRed"), for: .normal)
      self.enableDelete = true
    } else { /// 체크 버튼 해제 액션이면 개수에 따라서 타이틀 바꿔준다
      countedPinNumber -= 1
      if countedPinNumber == 0 { /// 선택된 체크 버튼이 0개면 타이틀 바꾸고 레이아웃 다시 잡을 수 있도록 노티 Post
        self.categoryNameLabel.text = "기본 카테고리"
        self.deleteButton.setImage(UIImage(named: "iconDeleteVer2"), for: .normal)
        NotificationCenter.default.post(name: NSNotification.Name("returnCategoryView"), object: nil)
      }
      else { /// 1개 이상이면 타이틀만 바꿔준다
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
    return pinNumber
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /// 분기처리
    /// 카테고리 내의 핀이 0개일 때: EmptyCategoryTableViewCell
    /// 핀이 1개 이상일 때: CategoryCafeListTableViewCell
    if pinNumber == 0 {
      guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: EmptyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? EmptyCategoryTableViewCell else { return UITableViewCell() }
      return emptyCell
    }
    guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryCafeListTableViewCell.reuseIdentifier, for: indexPath) as? CategoryCafeListTableViewCell else {return UITableViewCell() }
    categoryCell.awakeFromNib()
    /// categoryCell에 정보 뿌리는 함수 사용:
    categoryCell.setCafeData(name: self.cafeDetailArray[indexPath.row].name, rating: 0.0, address: self.cafeDetailArray[indexPath.row].address, tagArray: self.cafeDetailArray[indexPath.row].tags)
    categoryCell.selectionStyle = .none
    return categoryCell
  }
}
