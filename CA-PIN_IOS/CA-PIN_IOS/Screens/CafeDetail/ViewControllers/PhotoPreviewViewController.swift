//
//  PhotoPreviewViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/10.
//

import UIKit

import SnapKit
import Then

// MARK: - PhotoPreviewViewController
class PhotoPreviewViewController: UIViewController {
  
  // MARK: - Components
  let photoPreviewCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = true
    collectionView.isPagingEnabled = true
    return collectionView
  }()
  
  var images: [String] = ["1", "1", "1", "1", "1"]
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    layout()
    register()
    photoPreviewCollectionView.delegate = self
    photoPreviewCollectionView.dataSource = self
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedBackground))
    view.addGestureRecognizer(tapGesture)
  }
}

// MARK: - Extensions
extension PhotoPreviewViewController {
  
  // MARK: - Layout Helpers
  func layout() {
    view.backgroundColor = .backgroundCover
    view.add(photoPreviewCollectionView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.height.equalTo(244)
        $0.width.equalTo(self.images.count * 259)
        $0.trailing.equalToSuperview()
      }
    }
  }
  
  // MARK: - General Helpers
  func register() {
    photoPreviewCollectionView.register(PhotoPreviewCollectionViewCell.self, forCellWithReuseIdentifier: PhotoPreviewCollectionViewCell.reuseIdentifier)
  }
  @objc func tappedBackground() {
    self.dismiss(animated: false, completion: nil)
  }
}

// MARK: - photoPreviewCollectionView DelegateFlowLayout
extension PhotoPreviewViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 244, height: 244)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 67, bottom: 0, right: 0)
  }
}

// MARK: - photoPreviewCollectionView DataSource
extension PhotoPreviewViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoPreviewCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoPreviewCollectionViewCell else {
      return UICollectionViewCell()
    }
    photoCell.dataBind(imageName: images[indexPath.item])
    return photoCell
  }
  
  
}
