//
//  CategoryListModel.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/14.
//

import Foundation

// MARK: - CategoryListModel
struct CategoryListModel: Codable {
    let message: String
    let myCategoryList: [MyCategoryList]
}

// MARK: - MyCategoryList
struct MyCategoryList: Codable {
    let cafes: [String]
    let id, color, name: String
    let isPin: Bool?

    enum CodingKeys: String, CodingKey {
        case cafes
        case id = "_id"
        case color, name, isPin
    }
}
