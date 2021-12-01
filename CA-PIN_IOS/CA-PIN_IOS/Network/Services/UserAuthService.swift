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
  case emailAuth(email: String)
  case changePassword(email: String, password: String)
}

extension UserAuthService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.tokenAccess) ?? ""
  }
  
  public var baseURL: URL {
      return URL(string: Environment.baseURL)!
  }
  
  var path: String {
    switch self {
    case .login:
      return "/user/login"
    case .signup:
      return "/user/signup"
    case .emailAuth:
      return "/user/emailAuth"
    case .changePassword:
      return "/user/changePassword"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login,
         .signup,
         .emailAuth:
      return .post
    case .changePassword:
      return .put
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
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
    case .emailAuth(email: let email):
      return .requestCompositeParameters(bodyParameters: ["email": email],
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
    case .changePassword(email: let email, password: let password):
      return .requestCompositeParameters(bodyParameters: ["email": email, "password": password],
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .emailAuth, .changePassword:
      return ["Content-Type": "application/json"]
    default:
      return ["Content-Type": "application/json",
              "token": token]
    }
  }
}
