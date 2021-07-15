//
//  ReviewDetailModel.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/14.
//

import Foundation

// MARK: - ReviewDetailModel
struct ReviewDetailModel: Codable {
    let message: String
    let reviews: [ServerReview]?
    let isReviewed: Bool
}

// MARK: - Review
struct ServerReview: Codable {
    let id, cafeID: String
    let writer: Writer
    let rating: Double
    let createdAt, content: String
    let recommend: [Int]?
    let imgs: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cafeID = "cafeId"
        case writer, rating
        case createdAt = "created_at"
        case content, recommend, imgs
    }
}

// MARK: - Writer
struct Writer: Codable {
    let id, nickname: String
    let profileImg: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case nickname, profileImg
    }
}

