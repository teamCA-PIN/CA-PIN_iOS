//
//  UserAuthService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum UserAuthService {
  case login(email: String, password: String)
  case signup(email: String, password: String, nickname: String)
}

extension UserAuthService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
  }
  
  var path: String {
    switch self {
    case .login:
      return "/user/login"
    case .signup:
      return "/user/signup"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login,
         .signup:
      return .post
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    
    case .login(email: let email, password: let password):
      return .requestCompositeParameters(bodyParameters: ["email": email,
                                                          "password": password],
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
    case .signup(email: let email, password: let password, nickname: let nickname):
      return .requestCompositeParameters(bodyParameters: ["email": email,
                                                          "password": password,
                                                          "nickname": nickname],
                                         bodyEncoding: JSONEncoding.default, urlParameters: .init())
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
