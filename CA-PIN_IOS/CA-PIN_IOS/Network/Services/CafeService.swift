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
  
  func urlEncode(string: String) -> String? { return string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]{} ").inverted) }
  
  
  private var token: String {
//    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MGVjNjk0MTJkNGNhZDY0ZjBkNmVhNjgiLCJpYXQiOjE2MjYzMzMwMDMsImV4cCI6MTYyNjQxOTQwM30.W3VgorVwJPdQoHFaK0V8ieIgcN37no83XqeBzeGuP9g"
  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
  }
  
  
  var path: String {
    switch self {
    case .cafeListMymap:
      return "/cafes/myMap"
    case .cafeDetail(cafeId: let cafeId):
      return "/cafes/detail/\(cafeId)"
    default:
      return "/cafes"
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
    case .cafeListMymap, .cafeDetail:
      return .requestPlain
    case .cafeList(tags: let tags):
      return .requestParameters(parameters: ["tags": tags], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
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

