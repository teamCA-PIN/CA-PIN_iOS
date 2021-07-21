//
//  MapResponse.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/21.
//

import Foundation

struct MapListResponseArrayType<T: Codable>: Codable {
  var status: Int?
  var success: Bool?
  var message: String?
  var cafeLocations: [T]?
}

struct CafeDetailResponseType<T: Codable>: Codable {
  var status: Int?
  var success: Bool?
  var message: String?
  var cafeDetail: T?
}

struct MyMapListResponseType<T: Codable>: Codable {
  var message: String?
  var myMapLocations: [T]?
}
