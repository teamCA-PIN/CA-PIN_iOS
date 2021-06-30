//
//  MapViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/30.
//

import UIKit

import NMapsMap

class MapViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
  }
  
}
