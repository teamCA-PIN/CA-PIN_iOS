//
//  CafeTIModel.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/14.
//

import Foundation

// MARK: - CafeTIModel
struct CafeTIModel: Codable {
  let message: String?
  let result: CafeTIResult
}

// MARK: - Result
struct CafeTIResult: Codable {
  let cafetiIdx: Int
  let type, modifier: String
  let modifierDetail: String?
  let introduction: String
  let img, plainImg: String
}
