//
//  MapViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import NMapsMap
import SnapKit
import Then

// MARK: - MapViewController
class MapViewController: UIViewController {
  
  // MARK: - Components
  let topView = UIView()
  let titleLabel = UILabel()
  let menuButton = UIButton()
  let mapView = NMFMapView(frame: .zero)
  let toggleView = UIView()
  let capinMapButton = UIButton()
  let myMapButton = UIButton()
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
  }
  
}

// MARK: - Extensions
extension MapViewController {
  // MARK: - Layout Helpers
  func layout() {
    layoutTopView()
    layoutTitleLabel()
    layoutMenuButton()
    layoutMapView()
    layoutToggleView()
    layoutCapinMapButton()
    layoutMyMapButton()
  }
  func layoutTopView() {
    view.add(topView) {
      $0.backgroundColor = .white
      $0.cornerRadius = 10
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        $0.height.equalTo(146)
      }
    }
  }
  func layoutTitleLabel() {
    
  }
  func layoutMenuButton() {
    
  }
  func layoutMapView() {
    
  }
  func layoutToggleView() {
    
  }
  func layoutCapinMapButton() {
    
  }
  func layoutMyMapButton() {
    
  }
}
