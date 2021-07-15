//
//  MyInfoModel.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/14.
//


import Foundation

// MARK: - MyInfoModel
struct MyInfoModel: Codable {
  let message: String
  let myInfo: MyInfo
}

// MARK: - MyInfo
struct MyInfo: Codable {
  let cafeti: InfoCafeti
  let nickname, email: String
  let profileImg: String
  let reviewNum, pinNum: Int
}

// MARK: - Cafeti
struct InfoCafeti: Codable {
  let cafetiIdx: Int
  let type, modifier: String
  let img, plainImg: String
  let modifierDetail: String?
}

