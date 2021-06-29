//
//  ViewController.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import UIKit

import NMapsMap

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
  }


}

