//
//  ResponseType.swift
//  CA-PIN_IOS
//
//  Created by 장서현 on 2021/07/13.
//

import Foundation

struct ResponseArrayType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var data: [T]?
}

struct ResponseMenuArrayType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var menus: [T]?
}

struct ResponseType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var loginData: T?
}

struct ResponseCafeTI<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var result: T?
}

struct CategoryResponseArrayType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var myCategoryList: [T]?
}

struct CafeInCategoryResponseArrayType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var cafeDetail: [T]?
}

struct ReviewListResponseArrayType<T: Codable>: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
    var cafeDetail: [T]?
}

struct Response: Codable {
    var status: Int?
    var success: Bool?
    var message: String?
}
