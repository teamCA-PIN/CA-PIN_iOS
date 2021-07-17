//
//  PinPopupViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/02.
//

import UIKit

import Moya
import RxMoya
import RxSwift
import SnapKit
import SwiftyColor
import Then

// MARK: - PinPopupViewController
class PinPopupViewController: UIViewController {
  
  // MARK: - Components
  let popupView = UIView()
  let headerView = UIView()
  let barView = UIView()
  let titleLabel = UILabel()
  let categoryTableView = UITableView()
  let cancelButton = UIButton()
  let confirmButton = UIButton()
  
  var categoryArray: [MyCategoryList] = []
  var selectedIndex: Int?
  var cafeId = ""
  
  let categoryProvier = MoyaProvider<CategoryService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  let disposeBag = DisposeBag()
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.isHidden = true
    layout()
    register()
    self.categoryTableView.delegate = self
    self.categoryTableView.dataSource = self
    panDownToDismiss()
  }
}

// MARK: - Extensions
extension PinPopupViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    self.view.backgroundColor = .clear
    layoutPopupView()
    layoutHeaderView()
    layoutBarView()
    layoutTitleLabel()
    layoutCancelButton()
    layoutConfirmButton()
    layoutCategoryTableView()
  }
  func layoutPopupView() {
    view.add(popupView) {
      $0.backgroundColor = .white
      $0.setRounded(radius: 20)
      $0.snp.makeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(263)
      }
    }
  }
  func layoutHeaderView() {
    popupView.add(headerView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.leading.trailing.equalToSuperview()
        $0.height.equalTo(78)
      }
    }
  }
  func layoutBarView() {
    headerView.add(barView) {
      $0.backgroundColor = 0xC4C4C4.color
      $0.setRounded(radius: 3)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.headerView.snp.top).offset(16)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(68)
        $0.height.equalTo(6)
      }
    }
  }
  func layoutTitleLabel() {
    headerView.add(titleLabel) {
      $0.setupLabel(text: "후엘고",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20))
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.headerView.snp.leading).offset(16)
        $0.top.equalTo(self.headerView.snp.top).offset(44)
      }
    }
  }
  func layoutCancelButton() {
    popupView.add(cancelButton) {
      $0.setupButton(title: "취소",
                     color: 0x929292.color,
                     font: .notoSansKRMediumFont(fontSize: 16),
                     backgroundColor: 0xEDEDED.color,
                     state: .normal,
                     radius: 24)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.titleLabel.snp.leading)
        $0.trailing.equalTo(self.popupView.snp.centerX).offset(-5)
        $0.bottom.equalTo(self.popupView.snp.bottom).offset(-34)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutConfirmButton() {
    popupView.add(confirmButton) {
      $0.setupButton(title: "완료",
                     color: .white,
                     font: .notoSansKRMediumFont(fontSize: 16),
                     backgroundColor: 0xA98E7A.color,
                     state: .normal,
                     radius: 24)
      $0.addTarget(self,
                   action: #selector(self.clickedConfirmButton),
                   for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.popupView.snp.centerX).offset(5)
        $0.trailing.equalTo(self.popupView.snp.trailing).offset(-26)
        $0.bottom.equalTo(self.popupView.snp.bottom).offset(-34)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutCategoryTableView() {
    popupView.add(categoryTableView) {
      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.equalTo(self.headerView.snp.bottom)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(self.cancelButton.snp.top).offset(-37)
      }
    }
  }
  
  // MARK: - General Helpers
  func register() {
    self.categoryTableView.register(
      PinPopupTableViewCell.self,
      forCellReuseIdentifier: PinPopupTableViewCell.reuseIdentifier)
  }
  func panDownToDismiss() {
    let panAction = UIPanGestureRecognizer(target: self, action: #selector(self.swipeDown))
    self.popupView.addGestureRecognizer(panAction)
  }
  @objc func swipeDown(_ sender: UIPanGestureRecognizer) {
    let speedThreshold: CGFloat = 400
    let velocity = sender.velocity(in: self.popupView)
    let location = sender.translation(in: self.popupView)
    let firstLocation = CGPoint(x: self.popupView.frame.origin.x,
                                y: self.popupView.frame.origin.y)
    let interval = location.y - firstLocation.y
    if velocity.y.magnitude > speedThreshold {
      self.dismiss(animated: true, completion: nil)
    }
    if velocity.y.magnitude <= speedThreshold &&
        sender.state == .changed &&
        interval > 0 {
      self.popupView.frame = CGRect(x: 0,
                                    y: interval,
                                    width: self.popupView.frame.width,
                                    height: self.popupView.frame.height)
    }
    if velocity.y.magnitude <= speedThreshold &&
        sender.state == .ended &&
        interval > popupView.frame.height/3 {
      self.dismiss(animated: true, completion: nil)
    }
    if velocity.y.magnitude <= speedThreshold &&
        sender.state == .ended &&
        interval <= popupView.frame.height/3 {
      UIView.animate(withDuration: 0.2, animations: {
        self.popupView.frame = CGRect(x: self.popupView.frame.origin.x,
                                      y: self.popupView.frame.origin.y,
                                      width: self.popupView.frame.width,
                                      height: self.popupView.frame.height)
      })
    }
  }
  @objc func clickedConfirmButton() {
    var categoryId = ""
    
    if selectedIndex != 100 && selectedIndex != nil {
      categoryId = self.categoryArray[selectedIndex!-1].id
    }
    if selectedIndex == nil {
      self.showGrayToast(message: "카테고리를 선택해 주세요")
    }
    else {
      categoryProvier.rx.request(.addCafe(cafeId: self.cafeId, categoryId: categoryId))
        .asObservable()
        .subscribe(onNext: { response in
          if response.statusCode == 200 {
            do {
              let mapVC = self.navigationController?.presentingViewController?.children[2] as? MapViewController
              self.dismiss(animated: false) {
                mapVC?.showGreenToast(message: "카테고리에 저장되었습니다.")
              }
            } catch {
              print(error)
            }
          }
        }, onError: { error in
          print(error)
        }, onCompleted: {
        }).disposed(by: disposeBag)
    }
  }
  func colorViewImage(colorCode: String) -> String {
    switch colorCode {
    case "6492F5":
      return "colorchip1"
    case "6BBC9A":
      return "colorchip2"
    case "FFC24B":
      return "colorchip3"
    case "816F7C":
      return "colorchip4"
    case "FFC2D5":
      return "colorchip5"
    case "C9D776":
      return "colorchip6"
    case "B2B9E5":
      return "colorchip7"
    case "FF8E8E":
      return "colorchip8"
    case "EBEAEF":
      return "colorchip9"
    case "9DC5E8":
      return "colorchip10"
    default:
      return "colorchip1"
      
    }
  }
}

// MARK: - categoryTableView Datasource
extension PinPopupViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return self.categoryArray.count+1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let categoryCell = tableView.dequeueReusableCell(
            withIdentifier: PinPopupTableViewCell.reuseIdentifier,
            for: indexPath) as? PinPopupTableViewCell else {
      return UITableViewCell()
    }
    categoryCell.awakeFromNib()
    if indexPath.row == 0 {
      
      categoryCell.tagImageView.image = UIImage(named: "plusCategory")
      categoryCell.categoryTitleLabel.text = "새 카테고리"
      categoryCell.selectbutton.isHidden = true
    }
    else {
      categoryCell.rootViewController = self
      if (selectedIndex ?? 100) == indexPath.row {
        categoryCell.selectbutton.isSelected = true
      }
      else {
        categoryCell.selectbutton.isSelected = false
      }
      categoryCell.tagImageView.image = UIImage(named: self.colorViewImage(colorCode: self.categoryArray[indexPath.row-1].color))
      categoryCell.categoryTitleLabel.text = self.categoryArray[indexPath.row-1].name
    }
    return categoryCell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let categoryVC = CreateCategoryViewController()
      self.navigationController?.pushViewController(categoryVC, animated: true)
    }
  }
}

// MARK: - categoryTableView Delegate
extension PinPopupViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 58
  }
}
