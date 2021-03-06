//
//  ReviewService.swift
//  CA-PIN_IOS
//
//  Created by λΈνμ on 2021/07/12.
//
import UIKit
import Foundation

import Moya
import SwiftKeychainWrapper

enum ReviewService {
  case reviewList(cafeId: String)
  case writeReview(cafeId: String, recommend: [Int]?, content: String, rating: Float, images: [UIImage]?)
  case editReview(reviewId: String, recommend: [Int]?, content: String, rating: Float, isAllDeleted: Bool, images: [UIImage]?)
  case deleteReview(reviewId: String)
  case reportReivew(reviewId: String)
}

extension ReviewService: TargetType {
  
  private var token: String {
        return KeychainWrapper.standard.string(forKey: KeychainStorage.tokenAccess) ?? ""
  }
  
  public var baseURL: URL {
    switch self {
    case .writeReview(cafeId: let cafeId, _, _, _, _):
        return URL(string: "\(Environment.baseURL)/reviews?cafe=\(cafeId)")!
    default:
        return URL(string: Environment.baseURL)!
    }
  }
  
  var path: String {
    switch self {
    case .reviewList(let cafeId):
      return "/reviews"
    case .writeReview:
      return ""
    case .editReview(let reviewId, _, _, _, _, _):
      return "/reviews/\(reviewId)"
    case .deleteReview(let reviewId):
      return "/reviews/\(reviewId)"
    case .reportReivew(reviewId: let reviewId):
      return "/reviews/report/\(reviewId)"
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
    case .reportReivew:
      return .post
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    
    case .deleteReview:
      return .requestPlain
    case .reviewList(cafeId: let cafeId):
      return .requestParameters(parameters: ["cafe": cafeId], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
      
    case .writeReview(_, recommend: let recommend, content: let content, rating: let rating, images: let images):
      var multiPartFormData: [MultipartFormData] = [] /// multipart form data λΉ λ°°μ΄ λ§λ€κΈ°
      /// recommend λΆκΈ°μ²λ¦¬ -> dictionary ννλ‘
      if recommend == [] {
        let review = [
          "content": content,
          "rating": rating
        ] as [String: Any]
        /// dictionaryλ₯Ό JSONDataλ‘ λ³ν
        let data = try! JSONSerialization.data(withJSONObject: review, options: .prettyPrinted)
        /// JSONDataλ₯Ό JSONStringμΌλ‘ λ³ν
        let jsonString = String(data: data, encoding: .utf8)!
        /// JSONStringμ MultipartformDataλ‘ λ³ν
        let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "review")
        /// μ΅μ’μΌλ‘ λ³΄λΌ κ°μ²΄μ append
        multiPartFormData.append(stringData)
      }
      else {
        let review = [
          "recommend": recommend,
          "content": content,
          "rating": rating
        ] as [String: Any]
        let data = try! JSONSerialization.data(withJSONObject: review, options: .prettyPrinted)
        let jsonString = String(data: data, encoding: .utf8)!
        let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "review")
        multiPartFormData.append(stringData)
      }
      /// image νμΌ
      if images != nil {
        for image in images! {
          /// UIImageλ₯Ό jpegImageDataλ‘ λ³ν
          let imageData = image.jpegData(compressionQuality: 1.0)
          /// jpegDataλ₯Ό MultipartformDataλ‘ λ³ν
          let imgData = MultipartFormData(provider: .data(imageData!), name: "imgs", fileName: "image", mimeType: "image/jpeg")
          multiPartFormData.append(imgData)
          
        }
      }
      return .uploadMultipart(multiPartFormData)
      
    case .editReview(_, recommend: let recommend, content: let content, rating: let rating, isAllDeleted: let isAllDeleted, images: let images):
      var multiPartFormData: [MultipartFormData] = []
      if recommend == [] {
        let review = [
          "content": content,
          "rating": rating,
          "isAllDeleted": isAllDeleted
        ] as [String: Any]
        let data = try! JSONSerialization.data(withJSONObject: review, options: .prettyPrinted)
        let jsonString = String(data: data, encoding: .utf8)!
        let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "review")
        multiPartFormData.append(stringData)
      }
      else {
        let review = [
          "recommend": recommend,
          "content": content,
          "rating": rating,
          "isAllDeleted": isAllDeleted
        ] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: review, options: .prettyPrinted)
        let jsonString = String(data: data, encoding: .utf8)!
        let stringData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "review")
        multiPartFormData.append(stringData)
      }
      if images != nil {
        for image in images! {
          let imageData = image.jpegData(compressionQuality: 1.0)
          let imgData = MultipartFormData(provider: .data(imageData!), name: "imgs", fileName: "image", mimeType: "image/jpeg")
          multiPartFormData.append(imgData)
          
        }
      }
      return .uploadMultipart(multiPartFormData)
    case .reportReivew(reviewId: let reviewId):
      return .requestPlain
    }
    
  }
  
  var headers: [String : String]? {
    switch self {
    case .reviewList,
         .deleteReview,
         .reportReivew:
      return ["Content-Type": "application/json",
              "token": token]
    case .writeReview,
         .editReview:
      return ["Content-Type": "multipart/form-data",
              "token": token]
    }
  }
}
