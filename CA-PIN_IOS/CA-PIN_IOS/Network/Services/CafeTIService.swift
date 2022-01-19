//
//  CafeTIService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum CafeTIService {
  case cafeTI(answers: [Int])
}

extension CafeTIService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.tokenAccess) ?? ""
  }
  
  public var baseURL: URL {
      return URL(string: Environment.baseURL)!
  }
  
  var path: String {
    switch self {
    case .cafeTI:
      return "/cafeti"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .cafeTI:
      return .post
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .cafeTI(answers: let answers):
      return .requestCompositeParameters(bodyParameters: ["answers": answers], bodyEncoding: JSONEncoding.default, urlParameters: .init())
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

