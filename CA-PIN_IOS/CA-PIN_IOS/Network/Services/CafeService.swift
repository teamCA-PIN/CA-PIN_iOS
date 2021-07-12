//
//  CafeService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum CafeService {
  case cafeList(tags: [Int]?)
  case cafeListMymap
  case cafeDetail(cafeId: String)
}

extension CafeService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
  }
  
  var path: String {
    switch self {
    case .cafeList(tags: let tags):
      var tagString: String = ""
      if let tag = tags {
        for number in tag {
          tagString.append("\(number),")
        }
        tagString.removeLast()
        return "/cafes?tags=\(tagString)"
      }
      else {
        return "/cafes?tags="
      }
    case .cafeListMymap:
      return "/cafes/myMap"
    case .cafeDetail(cafeId: let cafeId):
      return "/cafes/detail/\(cafeId)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .cafeList, .cafeListMymap, .cafeDetail:
      return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .cafeList, .cafeListMymap, .cafeDetail:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .cafeList:
      return ["Content-Type": "application/json"]
    case .cafeListMymap,
         .cafeDetail:
      return ["Content-Type": "application/json",
              "token": token]
    }
  }
}

