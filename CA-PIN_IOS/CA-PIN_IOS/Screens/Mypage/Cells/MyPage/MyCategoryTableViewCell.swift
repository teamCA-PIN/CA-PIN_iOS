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
    }
    
    // MARK: - Components
  let plusButton = UIButton()
  let plusLabel = UILabel()
  let colorView = UIView()
  let titleLabel = UILabel()
  let numberLabel = UILabel()
  let editButton = UIButton()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
