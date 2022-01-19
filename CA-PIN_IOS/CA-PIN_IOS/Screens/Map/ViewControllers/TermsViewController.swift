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
import SafariServices

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
                         "문의하기",
                         "버전"
                        ]
  var url = NSURL(string: "https://www.notion.so/21f17ec3a90a44779ee1ab7dae8c1110")
  
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
          $0.top.equalTo(self.view.snp.top).offset(51)
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
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 58
  }
}

// MARK: - termsTableView DataSource
extension TermsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 5
    }
    else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
        guard let generalCell = tableView.dequeueReusableCell(
          withIdentifier: TermsGeneralTableViewCell.reuseIdentifier,
          for: indexPath) as? TermsGeneralTableViewCell else { return UITableViewCell() }
        generalCell.awakeFromNib()
        generalCell.selectionStyle = .none
        generalCell.titleLabel.text = termsCellTitles[indexPath.row]
        return generalCell
      }
      else {
        guard let versionCell = tableView.dequeueReusableCell(
                withIdentifier: TermsVersionTableViewCell.reuseIdentifier,
                for: indexPath) as? TermsVersionTableViewCell else { return UITableViewCell() }
        versionCell.awakeFromNib()
        versionCell.selectionStyle = .none
        versionCell.titleLabel.text = termsCellTitles[indexPath.row]
        if indexPath.row == 3 {
          versionCell.versionLabel.text = "teamcapin@gmail.com"
        }
        return versionCell
      }
        
    case 1:
      guard let generalCell = tableView.dequeueReusableCell(
        withIdentifier: TermsGeneralTableViewCell.reuseIdentifier,
        for: indexPath) as? TermsGeneralTableViewCell else { return UITableViewCell() }
      generalCell.awakeFromNib()
      generalCell.selectionStyle = .none
      generalCell.titleLabel.text = "회원탈퇴"
      generalCell.titleLabel.textColor = .pointcolor1
      return generalCell
    default:
      return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      if indexPath.row == 0 { // 이용약관
        url = NSURL(string: "https://www.notion.so/21f17ec3a90a44779ee1ab7dae8c1110")
        let safariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(safariView, animated: true, completion: nil)
      }
      else if indexPath.row == 1 { // 개인정보처리방침
        url = NSURL(string: "https://www.notion.so/b977d86415c54446bb8fdb42fd7bed48")
        let safariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(safariView, animated: true, completion: nil)
      }
      else if indexPath.row == 2 { // 오픈소스 라이선스
    
      }
    }
    else {
      // 회원탈퇴
      let withdrawVC = WithdrawViewController()
      self.navigationController?.pushViewController(withdrawVC, animated: true)
    }
  }
}
