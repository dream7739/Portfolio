//
//  Portfolio.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

struct Portfolio: Decodable {
    let result: PortfolioResult
    let data: AssetData
}

struct PortfolioResult: Decodable {
    let message: String
    let code: Int
}

struct AssetData: Decodable {
    let assetList: [Asset]
    
    enum CodingKeys: String, CodingKey {
        case assetList = "asset_list"
    }
}

struct Asset: Decodable {
    let securitySymbol: String
    let type: String
    let securityDescription: String?
    let quantity: Int
    let ratio: Double
    let securityName: String
    
    enum CodingKeys: String, CodingKey {
        case securitySymbol = "security_symbol"
        case type
        case securityDescription = "security_description"
        case quantity
        case ratio
        case securityName = "security_name"
    }
}

// 자산관련 연산 프로퍼티
extension Asset {
    var quantityDescription: String {
        return "\(quantity)주"
    }
}
