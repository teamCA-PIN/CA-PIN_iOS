//
//  CafeMenuModel.swift
//  CA-PIN_IOS
//
//  Created by 김지수 on 2021/07/15.
//


import Foundation

// MARK: - CafeMenuModel
struct CafeMenuModel: Codable {
    let message: String
    let menus: [Menu]
}

// MARK: - Menu
struct Menu: Codable {
    let name: String
    let price: Int
}
