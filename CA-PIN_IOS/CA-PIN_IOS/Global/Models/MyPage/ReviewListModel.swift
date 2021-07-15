//
//  ReviewListModel.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/15.
//

import Foundation
// MARK: - ReviewListModel
struct ReviewListModel: Codable {
    let message: String
    let reviews: [Review]
}

// MARK: - Review
struct Review: Codable {
    let id, cafeName, cafeID, content: String
    let rating: Double
    let createAt: String
    let imgs: [String]?
    let recommend: [Int]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cafeName
        case cafeID = "cafeId"
        case content, rating
        case createAt = "create_at"
        case imgs, recommend
    }
}
