//
//  CafeDetailPopupView.swift
//  CA-PIN_IOS
//
//  Created by hansol on 2021/12/14.
//

import UIKit

import SnapKit
import Then

// MARK: - CafeDetailPopupView

final class CafeDetailPopupView: UIView {
    
    // MARK: - Lazy Components
    
    private lazy var tagCollectionView: UICollectionView = {
        let layout = LeftAlignCollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            $0.dataSource = self
        }
        return collectionView
    }()
    
    // MARK: - Components
    
    private let cafeImageView = UIImageView()
    private let cafeNameLabel = UILabel()
    private let starIconImageView = UIImageView().then {
        $0.image = UIImage(named: "star2")
    }
    
    private let starLabel = UILabel()
    private let saveView = UIView().then {
        $0.setRounded(radius: 5)
        $0.isUserInteractionEnabled = true
    }
    
    private let saveImageView = UIImageView()
    private let saveLabel = UILabel()
    
    // MARK: - Variables
    
    var detailModel: CafeServerDetailModel?
    var rootViewController: UIViewController?
    var isSaved: Bool?
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        register()
        layout()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension CafeDetailPopupView {
    
    // MARK: - Layout Helpers
    
    private func layout() {
        self.adds(
            [
                cafeImageView,
                cafeNameLabel,
                starIconImageView,
                starLabel,
                tagCollectionView,
                saveView
            ]
        )
        
        saveView.adds(
            [
                saveImageView,
                saveLabel
            ]
        )
        
        cafeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(13)
            $0.width.height.equalTo(137)
        }
        
        cafeNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.cafeImageView)
            $0.leading.equalTo(self.cafeImageView.snp.trailing).offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        starIconImageView.snp.makeConstraints {
            $0.top.equalTo(self.cafeNameLabel.snp.bottom).offset(3)
            $0.leading.equalTo(self.cafeNameLabel)
            $0.width.height.equalTo(12)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.starIconImageView)
            $0.leading.equalTo(self.starIconImageView.snp.trailing).offset(4)
        }
        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.starIconImageView.snp.bottom).offset(12)
            $0.leading.equalTo(self.starIconImageView)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(46)
        }
        
        saveView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.leading.equalTo(self.cafeNameLabel)
            $0.trailing.equalToSuperview().offset(-13)
            $0.height.equalTo(30)
        }
        
        saveLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(5)
        }
        
        saveImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(self.saveLabel.snp.leading).offset(-2)
            $0.width.height.equalTo(15)
        }
    }
    
    // MARK: - General Helpers
    
    private func register() {
        tagCollectionView.register(
            CafeDetailPopupTagCollectionViewCell.self,
            forCellWithReuseIdentifier: CafeDetailPopupTagCollectionViewCell.reuseIdentifier
        )
    }
    
    func dataBind(model: CafeServerDetailModel, rootViewController: UIViewController) {
        detailModel = model
        self.rootViewController = rootViewController
        isSaved = model.isSaved
        
        if let img = model.cafeDetail.img {
            cafeImageView.imageFromUrl(model.cafeDetail.img, defaultImgPath: "")
        }
        else {
            cafeImageView.image = UIImage(named: "cafeEmptyImage")
        }
        cafeNameLabel.setupLabel(
            text: model.cafeDetail.name,
            color: .black,
            font: .notoSansKRMediumFont(fontSize: 20)
        )
        
        if let rating = model.cafeDetail.rating {
            starLabel.setupLabel(
                text: "\(rating)",
                color: .pointcolorYellow,
                font: .notoSansKRMediumFont(fontSize: 14)
            )
        }
        else {
            starLabel.setupLabel(
                text: "0.0",
                color: .pointcolorYellow,
                font: .notoSansKRMediumFont(fontSize: 14)
            )
        }
        
        if model.isSaved {
            saveView.backgroundColor = .pointcolor1
            saveView.borderColor = .clear
            saveView.borderWidth = 1
            saveImageView.image = UIImage(named: "iconPinsaveWhite")
            saveLabel.setupLabel(
                text: "저장됨",
                color: .white,
                font: .notoSansKRMediumFont(fontSize: 12)
            )
        }
        else {
            saveView.backgroundColor = .clear
            saveView.borderColor = .pointcolor1
            saveView.borderWidth = 1
            saveImageView.image = UIImage(named: "iconPinsaveSmall")
            saveLabel.setupLabel(
                text: "핀저장",
                color: .pointcolor1,
                font: .notoSansKRMediumFont(fontSize: 12)
            )
        }
    }
    
    func reloadCollectionView() {
        tagCollectionView.reloadData()
    }
    
    private func addGesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(touchupSaveButton))
        saveView.addGestureRecognizer(gesture)
    }
    
    // MARK: - Action Helpers
    
    @objc
    private func touchupSaveButton() {
        if let rootVC = rootViewController as? MapViewController,
            let isSaved = isSaved {
            if !isSaved {
                rootVC.setupCategory()
            }
            else {
                rootVC.setupCategory()
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CafeDetailPopupView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let model = detailModel {
            switch model.cafeDetail.tags[indexPath.item].name.count {
            case 5:
                return CGSize(width: 64, height: 21)
            case 6:
                return CGSize(width: 73, height: 21)
            case 7:
                return CGSize(width: 73, height: 21)
            default:
                return CGSize(width: 55, height: 21)
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

// MARK: - UICollectionViewDataSource

extension CafeDetailPopupView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = detailModel {
            return model.cafeDetail.tags.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tagCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CafeDetailPopupTagCollectionViewCell.reuseIdentifier, for: indexPath)
                as? CafeDetailPopupTagCollectionViewCell else { return UICollectionViewCell() }
        
        if let model = detailModel {
            tagCell.dataBind(tag: model.cafeDetail.tags[indexPath.item].name)
        }
        return tagCell
    }
}
