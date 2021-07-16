//
//  PinTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit
import Moya
import RxMoya
import RxSwift
import SwiftyColor

class MyCategoryTableViewCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
  
  // MARK: - Components
  let colorView = UIView()
  let titleLabel = UILabel()
  let numberLabel = UILabel()
  let editButton = UIButton()
  let separatorView = UIView()
  
  let disposeBag = DisposeBag()
  private let CategoryProvider = MoyaProvider<CategoryService>()
  
  var categoryID: String = ""
//  var categoryName: String = ""
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    let parentViewController: UIViewController = self.parentViewController!
    // Configure the view for the selected state
  }
}
extension MyCategoryTableViewCell {
  func layout() {
    layoutColorView()
    layoutTitleLabel()
    layoutEditButton()
    layoutNumberLabel()
    layoutSeparatorView()
  }
  func layoutColorView() {
    self.contentView.add(self.colorView) {
      $0.backgroundColor = .category2
      $0.setRounded(radius: 14.5)
      $0.snp.makeConstraints {
        $0.width.equalTo(29)
        $0.height.equalTo(29)
        $0.top.equalTo(self.contentView.snp.top).offset(14)
        $0.leading.equalTo(self.contentView.snp.leading).offset(26)
      }
    }
  }
  func layoutTitleLabel() {
    self.contentView.add(self.titleLabel) {
      $0.setupLabel(text: "기본 카테고리", color: .black, font: UIFont.notoSansKRMediumFont(fontSize: 14))
      $0.sizeToFit()
      $0.snp.makeConstraints {
        $0.height.equalTo(20)
        $0.top.equalTo(self.contentView.snp.top).offset(19)
        $0.leading.equalTo(self.colorView.snp.trailing).offset(22)
      }
    }
  }
  func layoutEditButton() {
    self.contentView.add(self.editButton) {
      $0.setImage(UIImage(named: "iconEditVertical"), for: .normal)
      $0.addTarget(self, action: #selector(self.editButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.width.equalTo(28)
        $0.height.equalTo(28)
        $0.top.equalTo(self.contentView.snp.top).offset(14)
        $0.trailing.equalTo(self.contentView.snp.trailing).offset(-12)
      }
    }
  }
  func layoutNumberLabel() {
    self.contentView.add(self.numberLabel) {
      $0.setupLabel(text: "88/100", color: .gray4, font: UIFont.notoSansKRMediumFont(fontSize: 12), align: .right)
      $0.snp.makeConstraints {
        $0.width.equalTo(67)
        $0.height.equalTo(20)
        $0.top.equalTo(self.contentView.snp.top).offset(18)
        $0.trailing.equalTo(self.editButton.snp.leading).offset(-4)
      }
    }
  }
  func layoutSeparatorView() {
    self.contentView.add(self.separatorView) {
      $0.backgroundColor = .gray2
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.leading.equalToSuperview()
        $0.bottom.equalToSuperview()
        $0.trailing.equalToSuperview()
      }
    }
  }
  func hexStringToUIColor (hex:String) -> UIColor {
      var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

      if (cString.hasPrefix("#")) {
          cString.remove(at: cString.startIndex)
      }

      if ((cString.count) != 6) {
          return UIColor.gray
      }

      var rgbValue:UInt64 = 0
      Scanner(string: cString).scanHexInt64(&rgbValue)

      return UIColor(
          red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
          green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
          blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
          alpha: CGFloat(1.0)
      )
  }
  func setCategoryData(colorCode: String, name: String, number: Int) {
    let color = hexStringToUIColor(hex: colorCode)
    self.colorView.backgroundColor = color
    self.titleLabel.text = name
    self.numberLabel.text = "\(number)/100"
  }
  
  @objc func editButtonClicked() {
    let alertController: UIAlertController
    alertController = UIAlertController(title: "카테고리 편집", message: nil, preferredStyle: .actionSheet)

    let editAction: UIAlertAction
    editAction = UIAlertAction(title: "카테고리 수정", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
      /// TODO 카테고리 수정 뷰로 이동
      let editVC = EditCategoryViewController()
      self.parentViewController?.navigationController?.pushViewController(editVC  , animated: false)
    })
    let deleteAction: UIAlertAction
    deleteAction = UIAlertAction(title: "카테고리 삭제", style: .destructive, handler: { (action: UIAlertAction) in
      let dvc = DeleteCategoryPopUpViewController()
      dvc.categoryId = self.categoryID
      dvc.modalPresentationStyle = .overCurrentContext
      self.parentViewController?.present(dvc, animated: false, completion: nil)
    })

    let cancelAction: UIAlertAction
    cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)

    alertController.addAction(editAction)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    
    alertController.view.tintColor = .maincolor1

    parentViewController?.present(alertController, animated: true, completion: nil)
  }
}
