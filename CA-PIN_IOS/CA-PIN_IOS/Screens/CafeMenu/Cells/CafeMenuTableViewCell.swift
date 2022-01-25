//
//  CafeMenuTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/08.
//

import UIKit

import SnapKit
import Moya
import Moya
import RxSwift
import Then

// MARK: - CafeMenuTableViewCell

class CafeMenuTableViewCell: UITableViewCell {
  
  // MARK: - Identifier
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
    self.backgroundColor = .clear
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    self.selectionStyle = .none
  }
  
  func setData(menuName : String,
               price : Int)
  {
    self.menunameLabel.setupLabel(text: menuName, color: .black, font: UIFont.notoSansKRRegularFont(fontSize: 16))
    self.priceLabel.setupLabel(text: "\(price)", color: .gray4, font: UIFont.notoSansKRRegularFont(fontSize: 14))
//    menunameLabel.text = menuName
//    priceLabel.text = price
  }
  
  // MARK: - Components
  
  let menunameLabel = UILabel()
  let priceLabel = UILabel()
}

// MARK: - Extensions

extension CafeMenuTableViewCell {
  
  // MARK: - Helpers
  
  func layout() {
    contentView.backgroundColor = .clear
    layoutMenuNameLabel()
    layoutPriceLabel()
  }
  func layoutMenuNameLabel() {
    self.contentView.add(menunameLabel) {
      self.menunameLabel.textColor = .black
      self.menunameLabel.font = .notoSansKRRegularFont(fontSize: 16)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(8)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        $0.height.equalTo(23)
          $0.trailing.equalToSuperview().offset(-100)
      }
    }
  }
  func layoutPriceLabel() {
    self.contentView.add(priceLabel) {
      self.priceLabel.textColor = .gray4
      self.priceLabel.font = .notoSansKRRegularFont(fontSize: 14)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top).offset(8)
        $0.trailing.equalTo(self.contentView.snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        $0.height.equalTo(23)
      }
    }
  }
  
}
