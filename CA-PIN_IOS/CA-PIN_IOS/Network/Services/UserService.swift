//
//  UserService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum UserService {
  case myInfo
  case reviews
  case categoryList
}

extension UserService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""

  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
  }
  
  var path: String {
    switch self {
    case .myInfo:
      return "/user/myInfo"
    case .reviews:
      return "/user/reviews"
    case .categoryList:
      return "/user/categoryList"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .myInfo,
         .reviews,
         .categoryList:
      return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .myInfo,
         .reviews,
         .categoryList:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    default:
      return ["Content-Type": "application/json",
              "token": token]
    }
  }
}

