//
//  CafeService.swift
//  CA-PIN_IOS
//
//  Created by λΈνμ on 2021/07/12.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum CafeService {
  case cafeList(tags: [Int]?)
  case cafeListMymap(tags: [Int]?)
  case cafeDetail(cafeId: String)
  case cafeMenu(cafeId: String)
}

extension CafeService: TargetType {
  
  func urlEncode(string: String) -> String? { return string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]{} ").inverted) }
  
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.tokenAccess) ?? ""

  }
  
    public var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
  
  
  var path: String {
    switch self {
    case .cafeListMymap:
      return "/cafes/myMap"
    case .cafeDetail(cafeId: let cafeId):
      return "/cafes/detail/\(cafeId)"
    case .cafeMenu(cafeId: let cafeId):
      return "/cafes/\(cafeId)/menus"
    default:
      return "/cafes"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .cafeList, .cafeListMymap, .cafeDetail, .cafeMenu:
      return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .cafeDetail, .cafeMenu:
      return .requestPlain
      /// ?tags={tagIdx1}&tags={tagsIdx2}
    case .cafeList(tags: let tags), .cafeListMymap(tags: let tags):
      return .requestParameters(parameters: ["tags": tags], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .cafeList, .cafeMenu:
      return ["Content-Type": "application/json"]
    case .cafeListMymap,
         .cafeDetail:
      return ["Content-Type": "application/json",
              "token": token]
    }
  }
}
