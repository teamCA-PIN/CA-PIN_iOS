//
//  Environment.swift
//  CA-PIN_IOS
//
//  Created by hansol on 2021/11/09.
//

import Foundation

// MARK: - Environment

struct Environment {
    
    static let baseURL = (Bundle.main.infoDictionary?["BASE_URL"] as! String).replacingOccurrences(of: " ", with: "")
}
