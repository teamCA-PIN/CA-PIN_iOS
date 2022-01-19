//
//  CafeDetailPopupTagCollectionViewCell.swift
//  CA-PIN_IOS
//
//  Created by hansol on 2021/12/14.
//

import UIKit

import SnapKit
import Then

// MARK: - CafeDetailPopupTagCollectionViewCell

final class CafeDetailPopupTagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Components
    
    private let tagLabel = UILabel()

    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension CafeDetailPopupTagCollectionViewCell {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        backgroundColor = .clear
        contentView.backgroundColor = .gray1
        contentView.setRounded(radius: 10.5)
        contentView.add(tagLabel) {
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    // MARK: - General Helpers
    
    func dataBind(tag: String) {
        tagLabel.setupLabel(
            text: tag,
            color: .pointcolor1,
            font: .notoSansKRRegularFont(fontSize: 10)
        )
    }
}
