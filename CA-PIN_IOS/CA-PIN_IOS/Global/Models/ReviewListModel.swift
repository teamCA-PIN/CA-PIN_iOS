//
//  ReviewListModel.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/09.
//

import Foundation

//// MARK: - ReviewListModel
//struct ReviewListModel: Codable {
//    let message: String
//    let reviews: [Review]?
//}
//
//// MARK: - Review
//struct Review: Codable {
//    let id, nickname, date: String
//    let rating: Float
//    let recommend: [Int]?
//    let content: String
//    let imgs: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case nickname, date, rating, recommend, content, imgs
//    }
//}

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

