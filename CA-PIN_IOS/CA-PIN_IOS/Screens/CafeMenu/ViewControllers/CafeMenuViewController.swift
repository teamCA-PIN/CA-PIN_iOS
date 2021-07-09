//
//  CafeMenuViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/08.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - CafeMenuViewController

class CafeMenuViewController: UIViewController {
  
  // MARK: - Components
  
  let menuallLabel = UILabel()
  let closeButton = UIButton()
  let backview = UIView()
  private let cafemenuTableView = UITableView()
  var cafemenuList : [CafeMenuListDataModel] = []
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    register()
    setCafemenuList()
    self.cafemenuTableView.delegate = self
    self.cafemenuTableView.dataSource = self
    cafemenuTableView.separatorStyle = .none
  }
  
  func setCafemenuList() {
    cafemenuList.append(contentsOf : [
      CafeMenuListDataModel(menuName : "커피",
                            price : "this"),
      CafeMenuListDataModel(menuName : "커피ddd",
                            price : "thisdddd"),
      CafeMenuListDataModel(menuName : "커피asdf",
                            price : "thifafs"),
      CafeMenuListDataModel(menuName : "커피afaf",
                            price : "thiafafafs"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "afafafaf커피",
                            price : "thisasdfasdf"),
      CafeMenuListDataModel(menuName : "논커피",
                            price : "that"),
      CafeMenuListDataModel(menuName : "논커피",
                            price : "that")
    ])
  }
}

// MARK: - Extension

extension CafeMenuViewController {
  
  // MARK: - Helpers
  
  func register() {
    self.cafemenuTableView.register(CafeMenuTableViewCell.self, forCellReuseIdentifier: CafeMenuTableViewCell.reuseIdentifier)
  }
  func layout() {
    layoutMenuallLabel()
    layoutCloseButton()
    layoutBackView()
    layoutCafemenuTableView()
  }
  func layoutMenuallLabel() {
    self.view.add(self.menuallLabel) {
      $0.setupLabel(text: "메뉴 전체보기", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(29)
      }
    }
  }
  func layoutCloseButton() {
    self.view.add(self.closeButton) {
      $0.setImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(7)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.width.equalTo(30)
        $0.height.equalTo(30)
      }
    }
  }
  func layoutBackView() {
    self.view.add(self.backview) {
      $0.backgroundColor = .gray1
      $0.setRounded(radius: 10)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.menuallLabel.snp.bottom).offset(48)
        $0.centerX.equalToSuperview()
        $0.height.equalTo(650)
        $0.width.equalTo(335)
      }
    }
  }
  func layoutCafemenuTableView() {
    self.backview.add(cafemenuTableView) {
      $0.backgroundColor = .clear
      $0.estimatedRowHeight = 23
      $0.rowHeight = UITableView.automaticDimension
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.separatorStyle = .none
      $0.snp.makeConstraints {
        $0.top.equalTo(self.backview.snp.top).offset(25)
        $0.leading.equalTo(self.backview.snp.leading).offset(35)
        $0.trailing.equalTo(self.backview.snp.trailing).offset(-38)
        $0.bottom.equalTo(self.backview.snp.bottom).offset(-25)
      }
    }
  }
}

// MARK: - UIViewDelegate

extension CafeMenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 23
  }
}

// MARK: - UITableViewDataSource

extension CafeMenuViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if cafemenuList.count > 15 {
      tableView.isScrollEnabled = true
      tableView.showsVerticalScrollIndicator = false
    }
    else {
      tableView.isScrollEnabled = false
    }
    return cafemenuList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cafemenuCell = tableView.dequeueReusableCell(withIdentifier: CafeMenuTableViewCell.reuseIdentifier, for: indexPath) as? CafeMenuTableViewCell else {return UITableViewCell() }
    cafemenuCell.setData(menuName : cafemenuList[indexPath.row].menuName,
                         price : cafemenuList[indexPath.row].price)
    cafemenuCell.awakeFromNib()
    return cafemenuCell
  }
}

