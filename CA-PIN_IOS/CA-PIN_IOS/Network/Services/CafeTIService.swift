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
//    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MGU2OWUwZGNlN2Q0M2M3MzNlZTI2MTkiLCJpYXQiOjE2MjYyOTgyMDAsImV4cCI6MTYyNjM4NDYwMH0.ywdg6aOB2T9_vSxUPN-Qz7ulY_oCaJ7X0X0NHd2KE7A"
  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
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

