//
//  PinTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layout()
    }
    
    // MARK: - Components
    let addButton = UIButton()
    let colorView = UIView()
    let nameLabel = UILabel()
    let numberLabel = UILabel()
    let editButton = UIButton()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CategoryTableViewCell {
    func layout() {
        layoutAddButton()
        layoutColorView()
        layoutNameLabel()
        layoutNumberLabel()
        layoutEditButton()
    }
    func layoutAddButton() {
        self.contentView.add(self.addButton) {
            $0.setImage(UIImage(named: "logo"), for: .normal)
            $0.setRounded(radius: 14.5)
            $0.snp.makeConstraints {
                $0.width.equalTo(29)
                $0.height.equalTo(29)
            }
        }
    }
    func layoutColorView() {
        self.contentView.add(self.colorView) {
            $0.setRounded(radius: 14.5)
            $0.snp.makeConstraints {
                $0.width.equalTo(29)
                $0.height.equalTo(29)
                $0.leading.equalTo(self.contentView.snp.leading).offset(26)
            }
        }
    }
    func layoutNameLabel() {
        self.contentView.add(self.nameLabel) {
            $0.setupLabel(text: "기본 카테고리", color: .black, font: UIFont.systemFont(ofSize: 14))
            $0.snp.makeConstraints {
                $0.width.equalTo(150)
                $0.height.equalTo(20)
            }
        }
    }
    func layoutNumberLabel() {
        self.contentView.add(self.numberLabel) {
            $0.setupLabel(text: "100/100", color: .gray, font: UIFont.systemFont(ofSize: 12), align: .right)
            $0.snp.makeConstraints {
                $0.width.equalTo(67)
                $0.height.equalTo(20)
            }
        }
    }
    func layoutEditButton() {
        self.contentView.add(self.editButton) {
            $0.setImage(UIImage(named: "logo"), for: .normal)
            $0.snp.makeConstraints {
                $0.width.equalTo(28)
                $0.height.equalTo(28)
                $0.trailing.equalTo(self.contentView.snp.trailing).offset(-12)
            }
        }
    }
}
