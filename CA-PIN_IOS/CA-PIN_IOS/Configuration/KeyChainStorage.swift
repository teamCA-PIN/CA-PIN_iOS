//
//  KeyChainStorage.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/06/28.
//

import Foundation

enum KeychainStorage {
  
  static var tokenAccess: String {
    return "tokenAccess"
  }
    static var tokenRefresh: String {
        return "tokenRefresh"
    }
  static var userCafeTI: String {
    return "userCafeTI"
  }
    
    static var nickname: String {
        return "nickname"
    }
}
