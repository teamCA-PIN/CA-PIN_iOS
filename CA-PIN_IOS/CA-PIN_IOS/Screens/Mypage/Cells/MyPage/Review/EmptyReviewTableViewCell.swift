//
//  EmptyReviewTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/11.
//

import UIKit

class EmptyReviewTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let suggestLabel = UILabel()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
extension EmptyReviewTableViewCell {
  func layout() {
    layoutSuggestLabel()
  }
  func layoutSuggestLabel() {
    self.contentView.add(self.suggestLabel) {
      $0.numberOfLines = 0
      $0.setupLabel(text: "리뷰를 작성해서\n방문한 곳의 기록을 남겨보세요", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14), align: .center)
      $0.letterSpacing = -0.7
      $0.snp.makeConstraints {
        $0.height.equalTo(42)
        $0.top.equalTo(self.contentView.snp.top).offset(215)
        $0.centerX.equalToSuperview()
      }
    }
  }
}
