//
//  LoginModel.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/13.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let message: String
    let loginData: LoginData?
}

// MARK: - LoginData
struct LoginData: Codable {
    let nickname, token: String
}
