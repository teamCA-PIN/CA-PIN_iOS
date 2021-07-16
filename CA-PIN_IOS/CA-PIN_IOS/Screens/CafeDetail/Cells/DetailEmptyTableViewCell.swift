//
//  DetailEmptyTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/17.
//

import UIKit

import SnapKit
import Then

// MARK: - DetailEmptyTableViewCell
class DetailEmptyTableViewCell: UITableViewCell {
  
  // MARK: - Components
  let emptyContentLabel = UILabel()
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

// MARK: - Extensions
extension DetailEmptyTableViewCell {
  
  // MARK: - Layout Helpers
  func layout() {
    self.contentView.backgroundColor = .white
    self.contentView.add(emptyContentLabel) {
      $0.numberOfLines = 2
      $0.setupLabel(text: "아직 등록된 리뷰가 없어요.\n가장 먼저 리뷰를 작성해보세요.",
                    color: .gray4,
                    font: .notoSansKRRegularFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.top.equalToSuperview().offset(100)
      }
    }
  }
}
