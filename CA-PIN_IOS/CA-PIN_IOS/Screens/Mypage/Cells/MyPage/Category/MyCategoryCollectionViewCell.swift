//
//  MyCategoryCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/09.
//

import UIKit

import Moya
import RxMoya
import RxSwift
import SwiftyColor

class MyCategoryCollectionViewCell: UICollectionViewCell {
  // MARK: - Components
  let headerView = UIView()
  let plusButton = UIButton()
  let plusLabel = UILabel()
  let separatorView = UIView()
  let myCategoryTableView = UITableView()
  
  let disposeBag = DisposeBag()
  private let UserProvider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  private let CategoryProvider = MoyaProvider<CategoryService>()
  
  // MARK: - Variables
  var categoryArray: [MyCategoryList] = [] /// 서버 통신해서 받아올 배열을 저장할거임
  var categoryNumber = 10 /// 카테고리 수 기준으로 section 1개 or 2개
                          /// cateogoryArray.count
  var categoryIdArray: [String] = [] /// 카테고리 아이디를 저장해놓는 배열 -> 카테고리 상세 페이지로 넘어갈 때 사용할 파라미터
  var selectedCategoryIndex: Int = 100
  var customizedCategoryTitle: String = ""
  
  var rootViewController = UIViewController()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    register()
    associate()
    getCategoryData()
    layout()
    myCategoryTableView.reloadData()
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
  
  // MARK: - Server
  func getCategoryData() {
    UserProvider.rx.request(.categoryList)
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(CategoryResponseArrayType<MyCategoryList>.self,
                                          from: response.data)
            self.categoryArray = data.myCategoryList!
            self.myCategoryTableView.reloadData()
            for i in 0...self.categoryArray.count-1 {
              self.categoryIdArray.append(self.categoryArray[i].id)
            }
            self.myCategoryTableView.reloadData()
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
  
  func getCafeDataInCategory(index: Int) {
    CategoryProvider.rx.request(.cafeListInCategory(categoryId: self.categoryIdArray[index]))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(CafeInCategoryResponseArrayType<CafeDetail>.self,
                                          from: response.data)
            let parentViewController: UIViewController = self.parentViewController!
            let dvc = CategoryDetailViewController()
            dvc.categoryTitle = self.customizedCategoryTitle /// 디테일뷰 타이틀을 바꿔준다
            dvc.pinNumber = data.cafeDetail?.count ?? 100 /// 디테일뷰 핀 개수를 바꿔준다
            dvc.cafeDetailArray = data.cafeDetail ?? []
            dvc.categoryId = self.categoryIdArray[index]
            
            if data.cafeDetail?.count != 0 {
              for i in 0...data.cafeDetail!.count-1 {
                let indexCategoryId = data.cafeDetail![i].id
                dvc.cafeIdArray.append(indexCategoryId)
              }
            }
            if data.cafeDetail?.count == 0 {
              
            }
            
            parentViewController.navigationController?.pushViewController(dvc, animated: false)
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
  
  @objc func plusButtonClicked() {
    let parentViewController: UIViewController = self.parentViewController!
    let dvc = CreateCategoryViewController()
    self.parentViewController?.navigationController?.pushViewController(dvc, animated: false)
  }
}
extension MyCategoryCollectionViewCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if categoryArray.count == 1 {
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
    if categoryArray.count == 1{ /// 기본 카테고리만 있는거
      return 2
    }
    /// 내가 등록한 카테고리도 있는거
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    categoryArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if categoryArray.count == 1 { /// 기본 카테고리만 있을 때엔
      if indexPath.section == 0 {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyCategoryTableViewCell else { return UITableViewCell() }
        categoryCell.awakeFromNib()
        categoryCell.selectionStyle = .none
        categoryCell.backgroundColor = .white
        if indexPath.item == 0 {
          categoryCell.editButton.isHidden = true
        }
        categoryCell.setCategoryData(colorCode: categoryArray[indexPath.row].color, name: categoryArray[indexPath.row].name, number: categoryArray[indexPath.row].cafes.count)
        return categoryCell
      } else {
        guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: MyEmptyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyEmptyCategoryTableViewCell else { return UITableViewCell() }
        emptyCell.awakeFromNib()
        return emptyCell
      }
    }
    guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: MyCategoryTableViewCell.reuseIdentifier, for: indexPath) as? MyCategoryTableViewCell else { return UITableViewCell() }
    categoryCell.awakeFromNib()
    categoryCell.selectionStyle = .none
    categoryCell.backgroundColor = .white
    
    categoryCell.setCategoryData(colorCode: categoryArray[indexPath.row].color, name: categoryArray[indexPath.row].name, number: categoryArray[indexPath.row].cafes.count)
    categoryCell.categoryID = categoryArray[indexPath.row].id
    
    if indexPath.item == 0 {
      categoryCell.editButton.isHidden = true
    }
    return categoryCell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedCategoryIndex = indexPath.row
    self.customizedCategoryTitle = self.categoryArray[indexPath.row].name
    self.getCafeDataInCategory(index: selectedCategoryIndex)
  }
}
