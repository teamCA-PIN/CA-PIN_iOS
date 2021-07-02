//
//  PinPopupViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/02.
//

import UIKit

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
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
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
    // TODO: Server Connection
  }
}

// MARK: - categoryTableView Datasource
extension PinPopupViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let categoryCell = tableView.dequeueReusableCell(
            withIdentifier: PinPopupTableViewCell.reuseIdentifier,
            for: indexPath) as? PinPopupTableViewCell else {
      return UITableViewCell()
    }
    if indexPath.row == 0 {
      categoryCell.textLabel?.text = "새 카테고리"
      categoryCell.selectbutton.isHidden = true
    }
    else {
      categoryCell.textLabel?.text = "카테고리\(indexPath.row)"
    }
    categoryCell.awakeFromNib()
    return categoryCell
  }
}

// MARK: - categoryTableView Delegate
extension PinPopupViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 58
  }
}
