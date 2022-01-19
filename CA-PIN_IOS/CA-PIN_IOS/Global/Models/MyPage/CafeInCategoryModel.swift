//
//  CafeInCategoryModel.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/14.
//

import Foundation

// MARK: - CafeInCategoryModel
struct CafeInCategoryModel: Codable {
  let message: String
  let cafeDetail: [String] = []
}

// MARK: - CafeDetail
struct CafeDetail: Codable {
  let tags: [Tag]
  let id, name, address: String
  
  enum CodingKeys: String, CodingKey {
    case tags
    case id = "_id"
    case name, address
  }
}

// MARK: - Tag
struct Tag: Codable {
  let id, name: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case name
  }
}
