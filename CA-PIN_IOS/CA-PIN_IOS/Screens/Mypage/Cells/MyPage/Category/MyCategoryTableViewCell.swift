//
//  PinTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

class MyCategoryTableViewCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
  
  // MARK: - Components
  let plusButton = UIButton()
  let plusLabel = UILabel()
  let colorView = UIView()
  let titleLabel = UILabel()
  let numberLabel = UILabel()
  let editButton = UIButton()
  let separatorView = UIView()
  
  
  
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
      $0.addTarget(self, action: #selector(self.editButtonClicekd), for: .touchUpInside)
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
  @objc func editButtonClicekd() {
    /// 액션시트
    print(" 에딧")
    
    let alertController: UIAlertController
    alertController = UIAlertController(title: "카테고리 편집", message: nil, preferredStyle: .actionSheet)

    let editAction: UIAlertAction
    // handler는 alert action이 선택됐을때, OK버튼이 실행된다면
    // 실행될 코드 블럭을 의미한다
    editAction = UIAlertAction(title: "카테고리 수정", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in print("edit pressed")
      /// 카테고리 수정 뷰로 이동
    })
    let deleteAction: UIAlertAction
    deleteAction = UIAlertAction(title: "카테고리 삭제", style: .destructive, handler: { (action: UIAlertAction) in print("delete pressed")
      /// 삭제 팝업 띄우기
      let dvc = DeleteCategoryPopUpViewController()
      dvc.modalPresentationStyle = .overFullScreen
      self.parentViewController?.present(dvc, animated: false, completion: nil)
    })

    let cancelAction: UIAlertAction
    // nil은 사용자가 누르면 아무 액션없이 alert이 dismiss된다
    cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)

    // action을 추가해줘야 실행된다.
    // 액션 순서에 상관없이 어떻게 넣어주더라도 위치는 UIAlertController가 알아서 지정해준다
    alertController.addAction(editAction)
    alertController.addAction(deleteAction)
    alertController.addAction(cancelAction)
    
    alertController.view.tintColor = .maincolor1

    // 모달로 올려줌! completion은 모달이 올라오는 애니메이션이 끝나고 직후에 호출될 블럭
    parentViewController?.present(alertController, animated: true, completion: nil)
  }
}
