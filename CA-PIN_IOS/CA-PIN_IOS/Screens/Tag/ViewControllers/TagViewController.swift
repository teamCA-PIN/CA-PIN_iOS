//
//  TagViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/06.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - TagViewController
class TagViewController: UIViewController {
  
  // MARK: - Components
  let topView = UIView()
  let titleLabel = UILabel()
  let closeButton = UIButton()
  let descriptionLabel = UILabel()
  let tagTableView = UITableView()
  let resultButton = UIButton()
  
  var resultCount: Int?
  var buttonTitles = ["커피 맛집",
                      "디저트 맛집",
                      "브런치 카페",
                      "작업하기 좋은",
                      "산미없는 커피",
                      "산미있는 커피"]
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    register()
    self.tagTableView.delegate = self
    self.tagTableView.dataSource = self
    NotificationCenter.default.addObserver(self, selector: #selector(self.pop), name: NSNotification.Name("pop"), object: nil)
  }
}

// MARK: - Extensions
extension TagViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    layoutTopView()
    layoutTitleLabel()
    layoutCloseButton()
    layoutDescriptionLabel()
    layoutResultButton()
    layoutTagTableView()
  }
  func layoutTopView() {
    view.add(topView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(self.view.safeAreaInsets.top + 50)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(30)
      }
    }
  }
  func layoutTitleLabel() {
    topView.add(titleLabel) {
      $0.setupLabel(text: "어떤 카페를 찾고 계신가요?",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalToSuperview()
      }
    }
  }
  func layoutCloseButton() {
    topView.add(closeButton) {
      $0.setBackgroundImage(UIImage(named: "iconCloseBlack"), for: .normal)
      $0.addTarget(self,
                   action: #selector(self.clickedCloseButton),
                   for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.topView.snp.trailing).offset(-20)
        $0.top.equalToSuperview()
        $0.width.height.equalTo(30)
      }
    }
  }
  func layoutDescriptionLabel() {
    view.add(descriptionLabel) {
      $0.setupLabel(text: "원하시는 카페 태그를 선택해주세요.",
                    color: .gray4,
                    font: .notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalTo(self.titleLabel.snp.bottom).offset(65)
      }
    }
  }
  func layoutResultButton() {
    view.add(resultButton) {
      $0.setupButton(title: "\(self.resultCount ?? 0)건의 검색결과 보기",
                     color: .gray4,
                     font: .notoSansKRMediumFont(fontSize: 20),
                     backgroundColor: .gray1,
                     state: .normal,
                     radius: 0)
      $0.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(self.view.snp.bottom).offset(-self.view.safeAreaInsets.bottom-50)
        $0.height.equalTo(83)
      }
    }
  }
  func layoutTagTableView() {
    view.add(tagTableView) {
      $0.separatorStyle = .none
      $0.allowsMultipleSelection = true
      $0.backgroundColor = .white
      $0.isScrollEnabled = false
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.leading.equalTo(self.view.snp.leading).offset(77)
        $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(57)
        $0.bottom.equalTo(self.resultButton.snp.top).offset(-52)
      }
    }
  }
  
  // MARK: - General Helpers
  func register() {
    self.tagTableView.register(TagTableViewCell.self, forCellReuseIdentifier: TagTableViewCell.reuseIdentifier)
  }
  @objc func pop() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func clickedCloseButton() {
    let exitVC = ExitViewController()
    exitVC.modalPresentationStyle = .overFullScreen
    self.present(exitVC, animated: false, completion: nil)
  }
}

// MARK: - TagTableView Delegate
extension TagViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 68
  }
}

// MARK: - TagTableView DataSources
extension TagViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tagCell = tableView.dequeueReusableCell(
            withIdentifier: TagTableViewCell.reuseIdentifier,
            for: indexPath) as? TagTableViewCell else {
      return UITableViewCell()
    }
    tagCell.awakeFromNib()
    tagCell.tagButton.setTitle(self.buttonTitles[indexPath.row], for: .normal)
    tagCell.tagButton.setTitleColor(.pointcolor1, for: .normal)
    tagCell.tagButton.setBorder(borderColor: .pointcolor1, borderWidth: 2)
    return tagCell
  }
}