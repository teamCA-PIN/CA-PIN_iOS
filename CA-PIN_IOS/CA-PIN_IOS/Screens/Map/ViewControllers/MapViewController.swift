//
//  MapViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit
import CoreLocation

import NMapsMap
import SnapKit
import Then

// MARK: - MapViewController
class MapViewController: UIViewController {
  
  // MARK: - Components
  let topView = UIView()
  let titleImageView = UIImageView()
  let menuButton = UIButton()
  let hashButton = UIButton()
  let mapView = NMFNaverMapView(frame: .zero)
  let toggleView = UIView()
  let capinMapButton = UIButton()
  let myMapButton = UIButton()
  let informationView = UIView()
  let informationTitleLabel = UILabel()
  let informationStarIconView = UIImageView()
  let informationStarLabel = UILabel()
  let informationImageView = UIImageView()
  let informationContextLabel = UILabel()
  let informationTagContainerView = UIView()
  let informationTagLabel = UILabel()
  let informationAddButton = UIButton()
  let marker = NMFMarker().then {
    $0.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
  }
  
  var locationManager = CLLocationManager()
  var currentLatitude: Double?
  var currentLongitude: Double?
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    layout()
    marker.mapView = self.mapView.mapView
    let handler = { (overlay: NMFOverlay) -> Bool in
      self.informationView.isHidden = false
      return true
    }
    marker.touchHandler = handler
  }
  
}

// MARK: - Extensions
extension MapViewController {
  // MARK: - Layout Helpers
  func layout() {
    layoutMapView()
    layoutTopView()
    layoutTitleImageView()
    layoutMenuButton()
    layoutHashButton()
    layoutToggleView()
    layoutCapinMapButton()
    layoutMyMapButton()
    layoutInformationView()
    layoutInformationTitleLabel()
    layoutInformationStarLabel()
    layoutInformationStarIconView()
    layoutInformationImageView()
    layoutInformationContextLabel()
    layoutInformationTagContainerView()
    layoutInformationTagLabel()
    layoutInformationAddButton()
  }
  func layoutTopView() {
    view.add(topView) {
      $0.backgroundColor = .white
      $0.cornerRadius = 10
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(self.view.safeAreaInsets.top+(self.navigationController?.navigationBar.bounds.height)!)
        $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        $0.height.equalTo(56)
      }
    }
  }
  func layoutTitleImageView() {
    topView.add(titleImageView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.center.equalToSuperview()
        $0.width.equalTo(80)
        $0.height.equalTo(30)
      }
    }
  }
  func layoutMenuButton() {
    topView.add(menuButton) {
      $0.setBackgroundImage(UIImage(named: "logo"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedMenuButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalTo(self.topView.snp.trailing).offset(-20)
        $0.width.height.equalTo(30)
      }
    }
  }
  func layoutHashButton() {
    topView.add(hashButton) {
      $0.setBackgroundImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalTo(self.topView.snp.leading).offset(20)
        $0.width.height.equalTo(30)
      }
    }
  }
  func layoutMapView() {
    view.add(mapView) {
      $0.showZoomControls = true
      $0.showLocationButton = true
      self.currentCoordinate()
      $0.mapView.positionMode = .normal
      $0.mapView.locationOverlay.location =
        NMGLatLng(lat: self.currentLatitude ?? self.mapView.mapView.latitude,
                  lng: self.currentLongitude ?? self.mapView.mapView.longitude)
      $0.snp.makeConstraints {
        $0.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
      }
    }
  }
  func layoutToggleView() {
    mapView.add(toggleView) {
      $0.backgroundColor = .white
      $0.setRounded(radius: 10)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.bottom.equalTo(self.mapView.snp.bottom).offset(34)
        $0.width.equalTo(220)
        $0.height.equalTo(49)
      }
    }
  }
  func layoutCapinMapButton() {
    toggleView.add(capinMapButton) {
      $0.setupButton(title: "카핀맵",
                     color: .gray,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .white,
                     state: .normal,
                     radius: 10)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.toggleView.snp.centerX).offset(-2)
        $0.top.equalTo(self.toggleView.snp.top).offset(2)
        $0.leading.equalTo(self.toggleView.snp.leading).offset(2)
        $0.bottom.equalTo(self.toggleView.snp.bottom).offset(-2)
      }
    }
  }
  func layoutMyMapButton() {
    toggleView.add(myMapButton) {
      $0.setupButton(title: "마이맵",
                     color: .gray,
                     font: .notoSansKRRegularFont(fontSize: 16),
                     backgroundColor: .white,
                     state: .normal,
                     radius: 10)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.toggleView.snp.centerX).offset(2)
        $0.trailing.equalTo(self.toggleView.snp.trailing).offset(-2)
        $0.top.equalTo(self.toggleView.snp.top).offset(2)
        $0.bottom.equalTo(self.toggleView.snp.bottom).offset(-2)
      }
    }
  }
  func layoutInformationView() {
    view.add(informationView) {
      $0.isHidden = true
      $0.backgroundColor = .white
      $0.setRounded(radius: 10)
      $0.snp.makeConstraints {
        $0.bottom.equalTo(self.toggleView.snp.top).offset(-11)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.height.equalTo(161)
      }
    }
  }
  func layoutInformationTitleLabel() {
    informationView.add(informationTitleLabel) {
      $0.setupLabel(text: "후엘고",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20))
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.informationView.snp.leading).offset(16)
        $0.top.equalTo(self.informationView.snp.top).offset(17)
      }
    }
  }
  func layoutInformationStarLabel() {
    informationView.add(informationStarLabel) {
      $0.setupLabel(text: "3.5",
                    color: 0xFFD027.color,
                    font: .notoSansKRMediumFont(fontSize: 14))
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.informationView.snp.trailing).offset(-16)
        $0.centerY.equalTo(self.informationTitleLabel.snp.centerY)
      }
    }
  }
  func layoutInformationStarIconView() {
    informationView.add(informationStarIconView) {
      $0.image = UIImage(named: "logo")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.informationView.snp.top).offset(26)
        $0.trailing.equalTo(self.informationStarLabel.snp.leading).offset(-7)
        $0.width.height.equalTo(12)
      }
    }
  }
  func layoutInformationImageView() {
    informationView.add(informationImageView) {
      $0.image = UIImage(named: "logo")
      $0.setRounded(radius: 10)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.informationTitleLabel.snp.leading)
        $0.top.equalTo(self.informationTitleLabel.snp.bottom).offset(7)
        $0.width.height.equalTo(92)
      }
    }
  }
  func layoutInformationContextLabel() {
    informationView.add(informationContextLabel) {
      $0.setupLabel(text:
                      "서울 마포구 마포대로11길 118 1층 (염리동), 서울 마포구 마포대로11길 118 1층 (염리동)",
                    color: 0x878787.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.numberOfLines = 3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.informationStarLabel.snp.bottom).offset(20)
        $0.leading.equalTo(self.informationImageView.snp.trailing).offset(17)
      }
    }
  }
  func layoutInformationTagContainerView() {
    informationView.add(informationTagContainerView) {
      $0.backgroundColor = 0xA98E7A.color
      $0.setRounded(radius: 12)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.informationContextLabel.snp.leading)
        $0.bottom.equalTo(self.informationImageView.snp.bottom)
        $0.width.equalTo(89)
        $0.height.equalTo(23)
      }
    }
  }
  func layoutInformationTagLabel() {
    informationView.add(informationTagLabel) {
      $0.setupLabel(text: "분위기 맛집",
                    color: .white,
                    font: .notoSansKRMediumFont(fontSize: 12))
      $0.snp.makeConstraints {
        $0.centerY.equalTo(self.informationTagContainerView.snp.centerY)
        $0.leading.equalTo(self.informationTagContainerView.snp.leading).offset(10)
      }
    }
    self.informationTagContainerView.snp.remakeConstraints {
      $0.leading.equalTo(self.informationContextLabel.snp.leading)
      $0.bottom.equalTo(self.informationImageView.snp.bottom)
      $0.trailing.equalTo(self.informationTagLabel.snp.trailing).offset(10)
      $0.height.equalTo(23)
    }
  }
  func layoutInformationAddButton() {
    informationView.add(informationAddButton) {
      $0.setBackgroundImage(UIImage(named: "logo"), for: .normal)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.informationStarLabel.snp.trailing)
        $0.bottom.equalTo(self.informationImageView.snp.bottom)
        $0.width.height.equalTo(28)
      }
    }
  }
  
  // MARK: - General Helpers
  func currentCoordinate() {
    let locationManager = self.locationManager
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    
    let coordinates = locationManager.location?.coordinate
    self.currentLatitude = coordinates?.latitude
    self.currentLongitude = coordinates?.longitude
    
  }
  @objc func clickedMenuButton() {
    let hamburgerVC = HamburgerViewController()
    self.navigationController?.pushViewController(hamburgerVC, animated: true)
  }
}

