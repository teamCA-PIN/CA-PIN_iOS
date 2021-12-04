//
//  TermsViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/06.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - TermsViewController
class TermsViewController: UIViewController {
  
  // MARK: - Components
  let topView = UIView()
  let backButton = UIButton()
  let titleLabel = UILabel()
  let termsTableView = UITableView()
  let termsCellTitles = ["이용 약관",
                         "개인정보처리방침",
                         "오픈소스 라이센스",
                         "회원 탈퇴하기"
                        ]
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
    register()
    self.termsTableView.delegate = self
    self.termsTableView.dataSource = self
  }
}

// MARK: - Extensions
extension TermsViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    layoutTopView()
    layoutBackButton()
    layoutTitleLabel()
    layoutTermsTableView()
  }
  func layoutTopView() {
    view.add(topView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(self.view.safeAreaInsets.top + 50)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(28)
      }
    }
  }
  func layoutBackButton() {
    topView.add(backButton) {
      $0.setBackgroundImage(UIImage(named: "iconBackBlack"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedBackButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.bottom.equalTo(self.topView.snp.bottom)
        $0.leading.equalTo(self.topView.snp.leading).offset(20)
        $0.width.height.equalTo(28)
      }
    }
  }
  func layoutTitleLabel() {
    topView.add(titleLabel) {
      $0.setupLabel(text: "약관 및 정책",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20),
                    align: .center)
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.backButton.snp.centerY)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutTermsTableView() {
    view.add(termsTableView) {
      $0.backgroundColor = .clear
      $0.separatorStyle = .singleLine
      $0.separatorColor = 0xededed.color
      $0.isScrollEnabled = false
      $0.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
        $0.top.equalTo(self.topView.snp.bottom).offset(7)
        $0.bottom.equalToSuperview().offset(-20)
      }
    }
  }
  
  // MARK: - General Helpers
  func register() {
    self.termsTableView.register(TermsGeneralTableViewCell.self,
                                 forCellReuseIdentifier: TermsGeneralTableViewCell.reuseIdentifier)
    self.termsTableView.register(TermsVersionTableViewCell.self,
                                 forCellReuseIdentifier: TermsVersionTableViewCell.reuseIdentifier)
  }
  @objc func clickedBackButton() {
    self.navigationController?.popViewController(animated: false)
  }
}

// MARK: - termsTableView Delegate
extension TermsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 58
  }
}

// MARK: - termsTableView DataSource
extension TermsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 4 || indexPath.row == 5 {
      guard let versionCell = tableView.dequeueReusableCell(
              withIdentifier: TermsVersionTableViewCell.reuseIdentifier,
              for: indexPath) as? TermsVersionTableViewCell else {
        return UITableViewCell()
      }
      versionCell.awakeFromNib()
      if indexPath.row == 4 {
        versionCell.titleLabel.text = "문의하기"
        versionCell.versionLabel.text = "teamcapin@gmail.com"
      }
      return versionCell
    }
    else {
      guard let generalCell = tableView.dequeueReusableCell(withIdentifier: TermsGeneralTableViewCell.reuseIdentifier, for: indexPath) as? TermsGeneralTableViewCell else {
        return UITableViewCell()
      }
      if indexPath.row != 6 {
        generalCell.titleText = self.termsCellTitles[indexPath.row]
      }
      generalCell.awakeFromNib()
      if indexPath.row == 6 {
        generalCell.titleLabel.text = "회원 탈퇴하기"
        generalCell.titleLabel.textColor = .pointcolor1
      }
      return generalCell
    }
  }
}
