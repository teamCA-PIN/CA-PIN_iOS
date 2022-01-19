//
//  MyMapListModel.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/15.
//

import Foundation

// MARK: - MyMapListModel
struct MyMapListModel: Codable {
  let message: String
  let myMapLocations: [MyMapLocation]
}

// MARK: - MyMapLocation
struct MyMapLocation: Codable {
  let cafes: [MyMapCafe]?
  let color: String
  let name: String
}

// MARK: - Cafe
struct MyMapCafe: Codable {
  let id: String
  let latitude, longitude: Double
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case latitude, longitude
  }
}

