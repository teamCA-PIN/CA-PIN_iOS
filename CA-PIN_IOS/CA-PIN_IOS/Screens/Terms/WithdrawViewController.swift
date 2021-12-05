//
//  WithdrawViewController.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/12/05.
//

import UIKit

import SnapKit
import Then

//MARK: - WithdrawViewController
class WithdrawViewController: UIViewController {
  
  //MARK: - Components
  let backbutton = UIButton()
  let withdrawTitleLabel = UILabel()
  let withdrawImageView = UIImageView()
  let withdrawExplainLabel = UILabel()
  let checkbutton = UIButton()
  let checkLabel = UILabel()
  let withdrawbutton = UIButton()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
  }
}

//MARK: - Extensions
extension WithdrawViewController {
  
  //MARK: - Layout Helper
  func layout() {
    layoutBackButton()
    layoutWithdrawTitleLabel()
    layoutWithdrawImageView()
    layoutWithdrawExplainLabel()
    layoutCheckButton()
    layoutCheckLabel()
    layoutWithdrawButton()
  }
  func layoutBackButton() {
    self.view.add(backbutton) {
      $0.setImageByName("iconBackBlack")
      $0.addTarget(self, action: #selector(self.backbuttonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(51)
        $0.leading.equalToSuperview().offset(20)
        $0.height.equalTo(28)
        $0.width.equalTo(28)
      }
    }
  }
  func layoutWithdrawTitleLabel() {
    self.view.add(withdrawTitleLabel) {
      $0.setupLabel(text: "회원탈퇴", color: .black, font: .notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.centerY.equalTo(self.backbutton.snp.centerY)
      }
    }
  }
  func layoutWithdrawImageView() {
    self.view.add(withdrawImageView) {
      $0.image = UIImage(named: "iconBackBlack")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.withdrawTitleLabel.snp.bottom).offset(99)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(236)
        $0.height.equalTo(236)
      }
    }
  }
  func layoutWithdrawExplainLabel() {
    self.view.add(withdrawExplainLabel) {
      $0.setupLabel(text: "회원탈퇴 시 현재 회원님의 계정에 저장된\n모든 정보는 영구적으로 삭제되며,\n다시 복구할 수 없습니다.", color: .gray4, font: .notoSansKRMediumFont(fontSize: 16), align: .center)
      let attributedStr = NSMutableAttributedString(string: self.withdrawExplainLabel.text ?? "")
      attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (self.withdrawExplainLabel.text! as NSString).range(of: "영구적으로 삭제"))
      attributedStr.addAttribute(.underlineColor, value: UIColor.black, range: (self.withdrawExplainLabel.text! as NSString).range(of: "영구적으로 삭제"))
      attributedStr.addAttribute(.underlineStyle, value: 1, range: (self.withdrawExplainLabel.text! as NSString).range(of: "영구적으로 삭제"))
      self.withdrawExplainLabel.attributedText = attributedStr
      $0.numberOfLines = 3
      $0.textAlignment = .center
      $0.snp.makeConstraints {
        $0.top.equalTo(self.withdrawImageView.snp.bottom).offset(53)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCheckButton() {
    self.view.add(checkbutton) {
      $0.setImageByName("newcheckboxInctive")
      $0.addTarget(self, action: #selector(self.checkbuttonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.withdrawExplainLabel.snp.bottom).offset(125)
        $0.leading.equalToSuperview().offset(73)
        $0.width.equalTo(24)
        $0.height.equalTo(24)
      }
    }
  }
  func layoutCheckLabel() {
    self.view.add(checkLabel) {
      $0.setupLabel(text: "위 내용을 숙지하였으며, 동의합니다.", color: .black, font: .notoSansKRRegularFont(fontSize: 14), align: .left)
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.checkbutton.snp.centerY)
        $0.leading.equalTo(self.checkbutton.snp.trailing).offset(8)
      }
    }
  }
  func layoutWithdrawButton() {
    self.view.add(withdrawbutton) {
      $0.setupButton(title: "탈퇴하기", color: .white, font: .notoSansKRRegularFont(fontSize: 16), backgroundColor: .gray3, state: .normal, radius: 25)
      $0.addTarget(self, action: #selector(self.withdrawButtonClicked), for: .touchUpInside)
      $0.isEnabled = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.checkLabel.snp.bottom).offset(38)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(219)
        $0.height.equalTo(49)
      }
    }
  }
  //MARK: - General Helpers
  @objc func backbuttonClicked() {
    self.navigationController?.popViewController(animated: false)
  }
  @objc func checkbuttonClicked() {
    if checkbutton.isSelected == false {
      checkbutton.setImage(UIImage(named: "newcheckboxActive"), for: .normal)
      withdrawbutton.backgroundColor = .maincolor1
      checkbutton.isSelected = true
    } else {
      checkbutton.setImage(UIImage(named: "newcheckboxInctive"), for: .normal)
      withdrawbutton.backgroundColor = .gray3
      checkbutton.isSelected = false
    }
  }
  @objc func withdrawButtonClicked() {
    if withdrawbutton.backgroundColor == .maincolor1 {
      self.withdrawbutton.isEnabled = true
      let withdrawPopUpVC = WithdrawPopUpViewController()
      withdrawPopUpVC.modalPresentationStyle = .overCurrentContext
      withdrawPopUpVC.modalTransitionStyle = .crossDissolve
      self.present(withdrawPopUpVC, animated: false, completion: nil)
    }
  }
}
