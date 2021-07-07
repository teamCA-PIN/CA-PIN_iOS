//
//  ReviewTableViewCell.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/06.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Components
    let nameLabel = UILabel()
    let scoreLabel = UILabel()
    let moreButton = UIButton()
    let editButton = UIButton()
    let explainText = UITextView()
    let tagContainerView = UIView()
    let flavorView = UIView()
    let flavorLabel = UILabel()
    let vibeView = UIView()
    let vibeLabel = UILabel()
    let imageStackView = UIStackView()
    let reviewImageView1 = UIImageView()
    let reviewImageView2 = UIImageView()
    let moreImageButton = UIButton()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
