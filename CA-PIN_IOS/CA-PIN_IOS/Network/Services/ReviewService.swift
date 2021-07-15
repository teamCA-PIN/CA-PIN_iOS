//
//  ReviewService.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/12.
//
import UIKit
import Foundation

import Moya
import SwiftKeychainWrapper

enum ReviewService {
  case reviewList(cafeId: String)
  case writeReview(cafeId: String, review: String, recommend: [Int]?, content: String, rating: Float, images: [UIImage]?)
  case editReview(reviewId: String)
  case deleteReview(reviewId: String)
}

extension ReviewService: TargetType {

  private var token: String {
//    return KeychainWrapper.standard.string(forKey: KeychainStorage.accessToken) ?? ""
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MGVjNjk0MTJkNGNhZDY0ZjBkNmVhNjgiLCJpYXQiOjE2MjYyODE2NTcsImV4cCI6MTYyNjM2ODA1N30.KrUpKHCZKmahakpFbZbt8cdUS9NB99lffupEpS8NQzo"
  }
  
  public var baseURL: URL {
    return URL(string: "http://3.37.75.200:5000")!
  }

  var path: String {
    switch self {
    case .reviewList(let cafeId):
      return "/reviews"
    case .writeReview(cafeId: let cafeId):
      return "/reviews?cafe=\(cafeId)"
    case .editReview(let reviewId):
      return "/reviews:\(reviewId)"
    case .deleteReview(let reviewId):
      return "/reviews:\(reviewId)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .reviewList:
      return .get
    case .writeReview:
      return .post
    case .editReview:
      return .put
    case .deleteReview:
      return .delete
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {

    case .deleteReview, .editReview, .writeReview:
      return .requestPlain
    case .reviewList(cafeId: let cafeId):
      return .requestParameters(parameters: ["cafe": cafeId], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
    }
  }

  var headers: [String : String]? {
    switch self {
    case .reviewList,
         .deleteReview:
      return ["Content-Type": "application/json",
              "token": token]
    case .writeReview,
         .editReview:
      return ["Content-Type": "multipart/form-data",
              "token": token]
    }
  }
}
