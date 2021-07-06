//
//  QuestionTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/04.
//

import UIKit

import SnapKit
import SwiftyColor
import Then

// MARK: - QuestionTableViewCell

class QuestionTableViewCell: UITableViewCell {
  
  // MARK: - Components
  
  let backview = UIView()
  let questionLabel = UILabel()
  
  // MARK: - LifeCycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
  
  func setData(questiontitle :String) {
    questionLabel.text = questiontitle
  }
}

// MARK : - Extensions

extension QuestionTableViewCell {
  
  // MARK : - Helpers
  func layout() {
    layoutBackView()
    layoutQuestionLabel()
  }
  func layoutBackView() {
    self.contentView.add(backview) {
      $0.backgroundColor = 0xf9f9f9.color
      $0.setRounded(radius: 5)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(5)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalToSuperview()
        $0.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        $0.height.equalTo(50)
      }
    }
  }
  func layoutQuestionLabel() {
    self.contentView.add(questionLabel) {
      $0.snp.makeConstraints {
        $0.centerX.equalTo(self.contentView.snp.centerX)
        $0.centerY.equalTo(self.contentView.snp.centerY)
      }
    }
  }
}
