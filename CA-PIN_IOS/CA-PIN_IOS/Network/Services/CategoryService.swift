//
//  CategoryService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//

import Foundation

import Moya
import SwiftKeychainWrapper

enum CategoryService {
  case createCategory(colorIndex: Int, categoryName: String)
  case deleteCategory(categoryId: String)
  case addCafe(cafeId: String, categoryId: String?)
  case cafeListInCategory(categoryId: String)
  case deleteCafeInCategory(categoryId: String, cafeList: [String])
  case editCategory(categoryId: String, colorIndex: Int, categoryName: String)
}

extension CategoryService: TargetType {
  
  private var token: String {
    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
  }
  
  var path: String {
    switch self {
    case .createCategory:
      return "/category"
    case .deleteCategory(categoryId: let categoryId):
      return "/category/\(categoryId)"
    case .addCafe(cafeId: let cafeId, _):
      return "/cateogry/\(cafeId)/archive"
    case .cafeListInCategory(categoryId: let categoryId):
      return "/category/\(categoryId)/cafes"
    case .deleteCafeInCategory(categoryId: let categoryId, _):
      return "/category/\(categoryId)/archive"
    case .editCategory(categoryId: let categoryId, _, _):
      return "/category/\(categoryId)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .createCategory,
         .addCafe:
      return .post
    case .deleteCategory:
      return .delete
    case .cafeListInCategory:
      return .get
    case .deleteCafeInCategory:
      return .delete
    case .editCategory:
      return .put
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    
    case .createCategory(colorIndex: let colorIndex, categoryName: let categoryName):
      return .requestCompositeParameters(bodyParameters: ["colorIdx": colorIndex,
                                                          "categoryName": categoryName],
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
    case .deleteCategory,
         .cafeListInCategory:
      return .requestPlain
    case .addCafe(_, categoryId: let categoryId):
      if categoryId == "" {
        return .requestPlain
      }
      else {
        return .requestCompositeParameters(bodyParameters: ["categoryId": categoryId],
                                           bodyEncoding: JSONEncoding.default,
                                           urlParameters: .init())
      }
     
    case .deleteCafeInCategory(_, cafeList: let cafeList):
      return .requestCompositeParameters(bodyParameters: ["cafeList": cafeList],
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
    case .editCategory(_, colorIndex: let colorIndex, categoryName: let categoryName):
      return .requestCompositeParameters(bodyParameters: ["colorIdx": colorIndex,
                                                          "categoryName": categoryName],
                                         bodyEncoding: JSONEncoding.default,
                                         urlParameters: .init())
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
