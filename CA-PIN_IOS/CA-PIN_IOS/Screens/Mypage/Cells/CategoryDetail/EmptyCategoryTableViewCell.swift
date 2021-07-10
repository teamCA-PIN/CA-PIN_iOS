//
//  EmptyCategoryTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/08.
//

import UIKit

class EmptyCategoryTableViewCell: UITableViewCell {
  
  let emptyImageView = UIImageView()
  let explainLabel = UILabel()

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

extension EmptyCategoryTableViewCell {
  func layout() {
    layoutEmptyImageView()
    layoutExplainLabel()
  }
  func layoutEmptyImageView() {
    self.contentView.add(self.emptyImageView) {
      $0.image = UIImage(named: "group637")
      $0.snp.makeConstraints {
        $0.width.equalTo(222)
        $0.height.equalTo(222)
        $0.top.equalTo(self.contentView.snp.top).offset(141)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutExplainLabel() {
    self.contentView.add(self.explainLabel) {
      $0.setupLabel(text: "이 카테고리에 핀 해둔 카페가 없습니다.", color: .gray4, font: UIFont.notoSansKRMediumFont(fontSize: 16), align: .center)
      $0.snp.makeConstraints {
        $0.width.equalTo(300)
        $0.height.equalTo(23)
        $0.top.equalTo(self.emptyImageView.snp.bottom).offset(19)
        $0.centerX.equalToSuperview()
      }
    }
  }
}
