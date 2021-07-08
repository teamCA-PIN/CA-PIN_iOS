//
//  CafeDetailModel.swift
//  CA-PIN_IOS
//
//  Created by 노한솔 on 2021/07/08.
//

import Foundation

// MARK: - CafeDetailModel
struct CafeDetailModel: Codable {
    let message: String
    let cafeDetail: CafeDetail
}

// MARK: - CafeDetail
struct CafeDetail: Codable {
    let tags: [Tag]
    let offday: [Int]
    let id, name, cafeImg, address: String
    let latitude, longitude: Int
    let insta, opentime, closetime: String
    let isSaved: Bool
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case tags, offday
        case id = "_id"
        case name, cafeImg, address, latitude, longitude, insta, opentime, closetime, isSaved, rating
    }
}

// MARK: - Tag
struct Tag: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}


