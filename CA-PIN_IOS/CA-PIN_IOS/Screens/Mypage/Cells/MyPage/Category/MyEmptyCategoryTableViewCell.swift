//
//  MyEmptyCategoryTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/10.
//

import UIKit

class MyEmptyCategoryTableViewCell: UITableViewCell {
  // MARK: - Components
  let emptyLabel = UILabel()
  
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
extension MyEmptyCategoryTableViewCell {
  func layout() {
    layoutEmptyLabel()
  }
  func layoutEmptyLabel() {
    self.contentView.add(self.emptyLabel) {
      $0.setupLabel(text: "원하는 장소에 핀하면\n카테고리 별로 모아볼 수 있어요", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14), align: .center)
      $0.letterSpacing = -0.7
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.width.equalTo(200)
        $0.height.equalTo(42)
        $0.centerX.equalToSuperview()
        $0.bottom.equalToSuperview()
      }
    }
  }
}
