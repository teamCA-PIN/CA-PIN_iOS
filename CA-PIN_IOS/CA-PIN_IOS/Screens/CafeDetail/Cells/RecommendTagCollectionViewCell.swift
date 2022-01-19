//
//  RecommendTagCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/09.
//

import UIKit

import SnapKit
import Then

// MARK: - RecommendTagCollectionViewCell
class RecommendTagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    let containerView = UIView()
    let tagLabel = UILabel()
    
    // MARK: - LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        layout()
    }
}

// MARK: - Extensions
extension RecommendTagCollectionViewCell {
    func layout() {
        layoutContainerView()
        layoutTagLabel()
    }
    func layoutContainerView() {
        contentView.add(containerView) {
            $0.setRounded(radius: 11)
            $0.borderColor = .pointcolor1
            $0.borderWidth = 1
            $0.backgroundColor = .clear
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    func layoutTagLabel() {
        containerView.add(tagLabel) {
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    // MARK: - General Helpers
    func dataBind(tagName: String) {
        tagLabel.setupLabel(text: tagName, color: .pointcolor1, font: .notoSansKRRegularFont(fontSize: 12))
    }
    func dataBind(tagNumber: Int?) {
        if let number = tagNumber {
            tagLabel.setupLabel(text: number == 0 ? "맛 추천": "분위기 추천", color: .pointcolor1, font: .notoSansKRRegularFont(fontSize: 12))
        }
    }
}
