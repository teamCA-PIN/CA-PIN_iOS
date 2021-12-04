//
//  MapViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import Foundation
import UIKit
import CoreLocation

import Moya
import NMapsMap
import RxMoya
import RxSwift
import SnapKit
import Then

// MARK: - MapViewController
class MapViewController: UIViewController, NMFLocationManagerDelegate {
  
  // MARK: - Components
  private let topView = UIView()
  private let titleImageView = UIImageView()
  private let menuButton = UIButton()
  private let mypageButton = UIButton()
  private let hashButton = UIButton()
  private let mapView = NMFNaverMapView(frame: .zero)
  private let locationButton = NMFLocationButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
  private let zoomControllView = NMFZoomControlView(frame: CGRect(x: 0, y: 0, width: 35, height: 70))
  private let toggleView = UIView()
  private let capinMapButton = UIButton()
  private let myMapButton = UIButton()
  private let informationView = UIView()
  private let informationTitleLabel = UILabel()
  private let informationStarIconView = UIImageView()
  private let informationStarLabel = UILabel()
  private let informationImageView = UIImageView()
  private let informationContextLabel = UILabel()
  private let informationTagContainerView = UIView()
  private let informationTagLabel = UILabel()
  private let informationAddButton = UIButton()
  
  // MARK: - Variables
  var locationManager = CLLocationManager()
  var currentLatitude: Double?
  var currentLongitude: Double?
  var informationRevealed = false
  var capinOrMyMap = 0
  var markers = [NMFMarker]()
  var currentMarkers = [NMFMarker]()
  var tags: [Int] = []
  var cafeListModel: [CafeLocation] = [CafeLocation(id: "1", latitude: 37.5260118, longitude: 127.0355868)]
  var myMapCafeList: [MyMapCafe] = [MyMapCafe(id: "", latitude: 0, longitude: 0)]
  var cafeDetailModel: CafeServerDetail?
  var categoryArray: [MyCategoryList] = []
  var isSaved: Bool?
  var rating: Float = 0
  var coordinates: [MapCoordinates] = [MapCoordinates(coordinates: NMGLatLng(lat: 36.1, lng: 107.2), colorCode: "", id: "")]
  var selectedMarker: NMFMarker?
  let locationComponent = NMFLocationManager.sharedInstance()
  let disposeBag = DisposeBag()
  let listProvider = MoyaProvider<CafeService>(plugins: [NetworkLoggerPlugin(verbose: true)])
  let userProvider = MoyaProvider<UserService>()
  var selectedCafeId = ""
  
  // MARK: - LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.isHidden = true
    self.mapView.mapView.touchDelegate = self
    self.mapView.mapView.addCameraDelegate(delegate: self)
    locationComponent?.add(self)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if self.capinOrMyMap == 0 {
      setupCafeList()
    }
    else {
      setupMyMapList()
    }
    layout()
    if selectedCafeId != nil {
      self.setupCafeInformation(cafeId: selectedCafeId)
    }
    if informationRevealed == true {
      informationView.isHidden = false
      informationRevealed = false
    }
  }
}

// MARK: - Extensions
extension MapViewController {
  
  // MARK: - Layout Helpers
  private func layout() {
    layoutMapView()
    layoutTopView()
    layoutTitleImageView()
    layoutMenuButton()
    layoutMypageButton()
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
  private func layoutTopView() {
    view.add(topView) {
      $0.backgroundColor = .white
      $0.cornerRadius = 10
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(
          self.view.safeAreaInsets.top +
          (self.navigationController?.navigationBar.bounds.height)!)
        $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        $0.height.equalTo(56)
      }
    }
  }
  private func layoutTitleImageView() {
    topView.add(titleImageView) {
      $0.image = UIImage(named: "capintyponew")
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalToSuperview().offset(20)
        $0.width.equalTo(78.5)
        $0.height.equalTo(25.2)
      }
    }
  }
  private func layoutMenuButton() {
    topView.add(menuButton) {
      $0.setBackgroundImage(UIImage(named: "iconSettingnew"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedMenuButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalTo(self.topView.snp.trailing).offset(-20)
        $0.width.height.equalTo(23)
      }
    }
  }
  private func layoutMypageButton() {
    self.topView.add(mypageButton) {
      $0.setBackgroundImage(UIImage(named: "iconMypagenew"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedMypageButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalTo(self.menuButton.snp.leading).offset(-14)
        $0.width.equalTo(26)
        $0.height.equalTo(22)
      }
    }
  }
  private func layoutHashButton() {
    topView.add(hashButton) {
      $0.setBackgroundImage(UIImage(named: "iconFilternew"), for: .normal)
      $0.addTarget(self, action: #selector(self.clickedHashButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalTo(self.mypageButton.snp.leading).offset(-14)
        $0.width.equalTo(28)
        $0.height.equalTo(20)
      }
    }
  }
  private func layoutMapView() {
    view.add(mapView) {
      self.currentCoordinate()
      $0.mapView.positionMode = .normal
      $0.showZoomControls = true
      $0.showLocationButton = true
      $0.mapView.locationOverlay.location =
      NMGLatLng(lat: self.currentLatitude ?? self.mapView.mapView.latitude,
                lng: self.currentLongitude ?? self.mapView.mapView.longitude)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
          .offset((self.navigationController?.navigationBar.bounds.height)!)
        $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
        $0.bottom.equalTo(self.view.snp.bottom)
      }
    }
  }
  private func layoutLocationButton() {
    view.add(locationButton) {
      $0.mapView = self.mapView.mapView
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.view.snp.trailing).offset(-10)
        $0.centerY.equalToSuperview()
      }
    }
  }
  private func layoutZoomControlView() {
    view.add(zoomControllView) {
      $0.mapView = self.mapView.mapView
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.view.snp.trailing).offset(-30)
        $0.bottom.equalTo(self.locationButton.snp.top).offset(-20)
      }
    }
  }
  private func layoutToggleView() {
    mapView.add(toggleView) {
      $0.backgroundColor = .white
      $0.setRounded(radius: 19)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.bottom.equalTo(self.mapView.snp.bottom).offset(-34)
        $0.width.equalTo(120)
        $0.height.equalTo(38)
      }
    }
  }
  private func layoutCapinMapButton() {
    toggleView.add(capinMapButton) {
      $0.setRounded(radius: 16)
      $0.backgroundColor = .pointcolor1
      $0.setImageByName("iconCapinmapWhite")
      if self.capinOrMyMap != 0 {
        $0.backgroundColor = .white
        $0.setImageByName("iconCapinmapBlue")
      }
      $0.addTarget(self, action: #selector(self.clickedToggleButton(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.toggleView.snp.centerX).offset(-3)
        $0.top.equalTo(self.toggleView.snp.top).offset(3)
        $0.leading.equalTo(self.toggleView.snp.leading).offset(3)
        $0.bottom.equalTo(self.toggleView.snp.bottom).offset(-3)
      }
    }
  }
  private func layoutMyMapButton() {
    toggleView.add(myMapButton) {
      $0.setRounded(radius: 16)
      $0.backgroundColor = .white
      $0.setImageByName("iconMymapBlue")
      if self.capinOrMyMap != 0 {
        $0.backgroundColor = .pointcolor1
        $0.setImageByName("iconMymapWhite")
      }
      $0.addTarget(self, action: #selector(self.clickedToggleButton(_:)), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.toggleView.snp.centerX).offset(3)
        $0.trailing.equalTo(self.toggleView.snp.trailing).offset(-3)
        $0.top.equalTo(self.toggleView.snp.top).offset(3)
        $0.bottom.equalTo(self.toggleView.snp.bottom).offset(-3)
      }
    }
  }
  private func layoutInformationView() {
    view.add(informationView) {
      $0.isHidden = true
      $0.backgroundColor = .white
      $0.setRounded(radius: 10)
      let tapGesture = UITapGestureRecognizer(target: self,
                                              action: #selector(self.tappedInformationView))
      $0.addGestureRecognizer(tapGesture)
      $0.snp.makeConstraints {
        $0.bottom.equalTo(self.toggleView.snp.top).offset(-11)
        $0.leading.equalTo(self.view.snp.leading).offset(20)
        $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
        $0.height.equalTo(161)
      }
    }
  }
  private func layoutInformationTitleLabel() {
    informationView.add(informationTitleLabel) {
      $0.setupLabel(text: "후엘고",
                    color: .black,
                    font: .notoSansKRMediumFont(fontSize: 20))
      $0.letterSpacing = -1.0
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.informationView.snp.leading).offset(16)
        $0.top.equalTo(self.informationView.snp.top).offset(17)
      }
    }
  }
  private func layoutInformationStarLabel() {
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
  private func layoutInformationStarIconView() {
    informationView.add(informationStarIconView) {
      $0.image = UIImage(named: "star")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.informationView.snp.top).offset(26)
        $0.trailing.equalTo(self.informationStarLabel.snp.leading).offset(-7)
        $0.width.height.equalTo(12)
      }
    }
  }
  private func layoutInformationImageView() {
    informationView.add(informationImageView) {
      $0.image = UIImage(named: "image176")
      $0.setRounded(radius: 10)
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.informationTitleLabel.snp.leading)
        $0.top.equalTo(self.informationTitleLabel.snp.bottom).offset(7)
        $0.width.height.equalTo(92)
      }
    }
  }
  private func layoutInformationContextLabel() {
    informationView.add(informationContextLabel) {
      $0.setupLabel(text:
                      "서울 마포구 마포대로11길 118 1층 (염리동), 서울 마포구 마포대로11길 118 1층 (염리동)",
                    color: 0x878787.color,
                    font: .notoSansKRRegularFont(fontSize: 12))
      $0.numberOfLines = 3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.informationStarLabel.snp.bottom).offset(20)
        $0.leading.equalTo(self.informationImageView.snp.trailing).offset(17)
        $0.trailing.equalTo(self.informationView.snp.trailing).offset(-20)
      }
    }
  }
  private func layoutInformationTagContainerView() {
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
  private func layoutInformationTagLabel() {
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
  private func layoutInformationAddButton() {
    informationView.add(informationAddButton) {
      $0.setBackgroundImage(UIImage(named: "iconPinplusActive"), for: .normal)
      $0.addTarget(self,
                   action: #selector(self.clickedAddCategoryButton),
                   for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.trailing.equalTo(self.informationStarLabel.snp.trailing)
        $0.bottom.equalTo(self.informationImageView.snp.bottom)
        $0.width.height.equalTo(28)
      }
    }
  }
  
  // MARK: - General Helpers
  private func currentCoordinate() {
    let locationManager = self.locationManager
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
    
    let coordinates = locationManager.location?.coordinate
    self.currentLatitude = coordinates?.latitude
    self.currentLongitude = coordinates?.longitude
  }
  @objc func clickedMenuButton() {
    let NewSettingVC = NewSettingViewController()
    self.navigationController?.pushViewController(NewSettingVC, animated: false)
  }
  @objc func clickedMypageButton() {
    let MypageVC = MypageViewController()
      self.navigationController?.pushViewController(MypageVC, animated: false)
  }
  @objc func clickedHashButton() {
    let tagVC = TagViewController()
    tagVC.selectedTag = self.tags
    tagVC.capinOrMyMap = self.capinOrMyMap
    tagVC.mapViewController = self
    self.navigationController?.pushViewController(tagVC, animated: false)
  }
  @objc func clickedAddCategoryButton() {
    setupCategory()
    
  }
  @objc func tappedInformationView() {
    let detailView = CafeDetailViewController()
    detailView.cafeModel = self.cafeDetailModel
    detailView.cafeId = selectedCafeId
    self.navigationController?.pushViewController(detailView, animated: false)
  }
  @objc func clickedToggleButton(_ sender: UIButton?) {
    if sender == self.capinMapButton {
      sender?.backgroundColor = .pointcolor1
      sender?.setImageByName("iconCapinmapWhite")
      self.myMapButton.backgroundColor = .white
      self.myMapButton.setImageByName("iconMymapBlue")
      self.capinOrMyMap = 0
      self.setupCafeList()
      
    }
    else {
      self.capinOrMyMap = 1
      sender?.backgroundColor = .pointcolor1
      sender?.setImageByName("iconMymapWhite")
      self.capinMapButton.backgroundColor = .white
      self.capinMapButton.setImageByName("iconCapinmapBlue")
      self.setupMyMapList()
      
    }
  }
  private func setupMarker() {
    let handler = { (overlay: NMFOverlay) -> Bool in
      var id = ""
      var colorCode = ""
      if let marker = overlay as? NMFMarker {
        for coordinate in self.coordinates {
          if marker.position == coordinate.coordinates {
            self.selectedCafeId = coordinate.id
            id = coordinate.id
            colorCode = coordinate.colorCode
          }
        }
        self.selectedMarker?.iconImage = NMFOverlayImage(name: self.markerImage(colorCode: colorCode, isActive: 0))
        self.selectedMarker = marker
        marker.iconImage = NMFOverlayImage(name: self.markerImage(colorCode: colorCode, isActive: 1))
      }
      self.setupCafeInformation(cafeId: id)
      return true
    }
    for marker in currentMarkers {
      if marker != selectedMarker {
        marker.mapView = nil
      }
    }
    currentMarkers.removeAll()
    self.markers.removeAll()
    for index in 0..<self.coordinates.count {
      if selectedMarker?.position != self.coordinates[index].coordinates {
        let marker = NMFMarker(position: self.coordinates[index].coordinates)
        marker.touchHandler = handler
        
        if capinOrMyMap == 1 {
        }
        marker.iconImage = NMFOverlayImage(name: markerImage(colorCode: self.coordinates[index].colorCode, isActive: 0))
        markers.append(marker)
      }
    }
    self.findCurrentMarker()
    for marker in currentMarkers {
      marker.mapView = self.mapView.mapView
    }
  }
  private func findCurrentMarker() {
    let bounds = self.mapView.mapView.coveringBounds
    let southWest = bounds.southWest
    let northEast = bounds.northEast
    for marker in markers {
      if marker.position.lat > southWest.lat &&
          marker.position.lat < northEast.lat &&
          marker.position.lng > southWest.lng &&
          marker.position.lng < northEast.lng {
        currentMarkers.append(marker)
      }
    }
  }
  private func setupCafeList() {
    print(tags)
    listProvider.rx.request(.cafeList(tags: tags))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(MapListResponseArrayType<CafeLocation>.self,
                                          from: response.data)
            self.cafeListModel = data.cafeLocations ?? [CafeLocation(id: "1", latitude: 37.5260118, longitude: 127.0355868)]
            self.coordinates.removeAll()
            for cafe in self.cafeListModel {
              self.coordinates.append(MapCoordinates(coordinates: NMGLatLng(lat: cafe.latitude, lng: cafe.longitude), colorCode: "", id: cafe.id))
            }
            self.setupMarker()
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        self.reloadInputViews()
      }).disposed(by: disposeBag)
  }
  private func setupMyMapList() {
    listProvider.rx.request(.cafeListMymap(tags: tags))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(MyMapListResponseType<MyMapLocation>.self,
                                          from: response.data)
            self.coordinates.removeAll()
            let myMapListModel = data.myMapLocations
            var colorCode = ""
            for cafeModel in myMapListModel! {
              self.myMapCafeList = cafeModel.cafes ?? [MyMapCafe(id: "", latitude: 0, longitude: 0)]
              colorCode = cafeModel.color
              for cafe in self.myMapCafeList {
                self.coordinates.append(MapCoordinates(coordinates: NMGLatLng(lat: cafe.latitude, lng: cafe.longitude), colorCode: colorCode, id: cafe.id))
              }
            }
            self.setupMarker()
          } catch {
            print(error)
          }
        }
        if response.statusCode == 204 {
          self.coordinates.removeAll()
          self.setupMarker()
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        self.reloadInputViews()
      }).disposed(by: disposeBag)
  }
  private func setupCafeInformation(cafeId: String) {
    listProvider.rx.request(.cafeDetail(cafeId: cafeId))
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(CafeDetailResponseType<CafeServerDetail>.self,
                                          from: response.data)
            self.cafeDetailModel = data.cafeDetail!
            self.rating = data.cafeDetail?.rating ?? 0
            self.informationViewDataBind()
          } catch {
            print(error)
          }
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  private func informationViewDataBind() {
    informationTitleLabel.text = self.cafeDetailModel?.name
    informationStarLabel.text = "\(self.rating)"
    if self.cafeDetailModel?.img == nil {
      informationImageView.image = UIImage(named: "smallDetailEmptyImage")
    }
    else {
      
      informationImageView.setImage(from: self.cafeDetailModel?.img ?? "", UIImage(named: "smallDetailEmptyImage")!)
    }
    informationContextLabel.text = self.cafeDetailModel?.address
    informationTagLabel.text = self.cafeDetailModel?.tags[0].name
    informationView.isHidden = false
  }
  private func markerImage(colorCode: String, isActive: Int) -> String {
    if isActive == 1 {
      switch colorCode {
      case "6492F5":
        return "pinActiveCate1"
      case "6BBC9A":
        return "pinActiveCate2"
      case "FFC24B":
        return "pinActiveCate3"
      case "816F7C":
        return "pinActiveCate4"
      case "FFC2D5":
        return "pinActiveCate5"
      case "C9D776":
        return "pinActiveCate6"
      case "B2B9E5":
        return "pinActiveCate7"
      case "FF8E8E":
        return "pinActiveCate8"
      case "EBEAEF":
        return "pinActiveCate9"
      case "9DC5E8":
        return "pinActiveCate10"
      default:
        return "pinActiveDefault"
      }
    }
    else {
      switch colorCode {
      case "6492F5":
        return "pinInactiveCate1"
      case "6BBC9A":
        return "pinInactiveCate2"
      case "FFC24B":
        return "pinInactiveCate3"
      case "816F7C":
        return "pinInactiveCate4"
      case "FFC2D5":
        return "pinInactiveCate5"
      case "C9D776":
        return "pinInactiveCate6"
      case "B2B9E5":
        return "pinInactiveCate7"
      case "FF8E8E":
        return "pinInactiveCate8"
      case "EBEAEF":
        return "pinInactiveCate9"
      case "9DC5E8":
        return "pinInactiveCate10"
      default:
        return "pinInactiveDefault"
      }
    }
  }
  private func setupCategory() {
    userProvider.rx.request(.categoryList)
      .asObservable()
      .subscribe(onNext: { response in
        if response.statusCode == 200 {
          do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(CategoryResponseArrayType<MyCategoryList>.self,
                                          from: response.data)
            self.categoryArray = data.myCategoryList!
            let pinNavigationController = UINavigationController()
            let pinPopupVC = PinPopupViewController()
            pinPopupVC.cafeId = self.selectedCafeId
            pinPopupVC.categoryArray = self.categoryArray
            pinNavigationController.addChild(pinPopupVC)
            pinNavigationController.view.backgroundColor = .clear
            pinNavigationController.modalPresentationStyle = .overCurrentContext
            self.present(pinNavigationController, animated: true, completion: nil)
          } catch {
            print(error)
          }
        }
        else {
          
        }
      }, onError: { error in
        print(error)
      }, onCompleted: {
        
      }).disposed(by: disposeBag)
  }
}


extension MapViewController: NMFMapViewTouchDelegate {
  func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
    if self.informationView.isHidden == false {
      self.informationView.isHidden = true
      self.selectedCafeId = ""
      self.viewWillAppear(true)
      for coordinate in self.coordinates {
        if selectedMarker?.position == coordinate.coordinates {
          selectedMarker?.iconImage = NMFOverlayImage(name: markerImage(colorCode: coordinate.colorCode, isActive: 0))
        }
      }
      selectedMarker = nil
    }
    for marker in currentMarkers {
      for coordinate in self.coordinates {
        if marker.position == coordinate.coordinates {
          marker.iconImage = NMFOverlayImage(name: markerImage(colorCode: coordinate.colorCode, isActive: 0))
        }
      }
    }
  }
}

extension MapViewController: NMFMapViewCameraDelegate {
  func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
    self.setupMarker()
  }
}


// MARK: - CafeListModel
struct CafeListModel: Codable {
  let message: String
  let cafeLocations: [CafeLocation]?
}

// MARK: - CafeLocation
struct CafeLocation: Codable {
  let id: String
  let latitude, longitude: Double
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case latitude, longitude
  }
}

// MARK: - CafeDetailModel
struct CafeServerDetailModel: Codable {
  let message: String
  let cafeDetail: CafeServerDetail
}

// MARK: - CafeDetail
struct CafeServerDetail: Codable {
  let tags: [ServerTag]
  let id, name, address: String
  let opentime, opentimeHoliday, closetime, closetimeHoliday: String?
  let img, instagram: String?
  let offday: [String]?
  let latitude, longitude: Double
  let rating: Float?
  
  enum CodingKeys: String, CodingKey {
    case tags
    case id = "_id"
    case name, address, instagram, opentime, opentimeHoliday, closetime, closetimeHoliday, offday, latitude, longitude, img
    case rating
  }
}

// MARK: - Tag
struct ServerTag: Codable {
  let id: String
  let tagIdx: Int
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case tagIdx, name
  }
}
