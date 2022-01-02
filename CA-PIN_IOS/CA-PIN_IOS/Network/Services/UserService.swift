//
//  UserService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//

import UIKit
import Foundation

import Moya
import SwiftKeychainWrapper

enum UserService {
  case myInfo
  case reviews
    case categoryList(cafeID: String?)
  case editMyInfo(nickname: String, profilImg: UIImage)
}

extension UserService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.tokenAccess) ?? ""

  }
  
  public var baseURL: URL {
    return URL(string: Environment.baseURL)!
  }
  
  var path: String {
    switch self {
    case .myInfo,
         .editMyInfo:
      return "/user/myInfo"
    case .reviews:
      return "/user/reviews"
    case .categoryList(cafeID: _):
      return "/user/categoryList"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .myInfo,
         .reviews,
         .categoryList:
      return .get
    case .editMyInfo:
      return .put
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .myInfo,
            .reviews:
      return .requestPlain
    case .categoryList(cafeID: let cafeID):
        if let cafeID = cafeID {
            return .requestParameters(parameters: ["cafeId": cafeID], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
        }
        else {
            return .requestPlain
        }
    case .editMyInfo(nickname: let nickname, profilImg: let profileImg):
        var multiPartFormData: [MultipartFormData] = []
      let nickname = Data(nickname.utf8)
//        let data = try! JSONSerialization.data(withJSONObject: nickname, options: .prettyPrinted)
        let jsonString = String(data: nickname, encoding: .utf8)!
        let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "nickname")
        multiPartFormData.append(stringData)
      
        if profileImg != nil {
            let imageData = profileImg.jpegData(compressionQuality: 1.0)
            let imgData = MultipartFormData(provider: .data(imageData!), name: "profileImg", fileName: "image", mimeType: "image/jpeg")
            multiPartFormData.append(imgData)
        }
        return .uploadMultipart(multiPartFormData)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .editMyInfo:
      return ["Content-Type": "multipart/form-data",
              "token": token]
    default:
      return ["Content-Type": "application/json",
              "token": token]
    }
  }
}

