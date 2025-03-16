//
//  PortfolioType.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit

enum PortfolioType: String, CaseIterable {
    case stock
    case bond
    case etc
    
    var name: String {
        switch self {
        case .stock:
            return "주식형 자산"
        case .bond:
            return "채권형 자산"
        case .etc:
            return "기타 자산"
        }
    }
    
}

enum PortfolioDetailType: String, CaseIterable {
    case developedStock
    case advancedStock
    case developedBond
    case advancedBond
    case etc
    case alternative
    
    var name: String {
        switch self {
        case .developedStock:
            return "선진시장 주식"
        case .advancedStock:
            return "신흥시장 주식"
        case .developedBond:
            return "선진시장 채권"
        case .advancedBond:
            return "신흥시장 채권"
        case .etc:
            return "미화 현금"
        case .alternative:
            return "대체자산"
        }
    }
    
    var color: UIColor {
        switch self {
        case .developedStock:
            return .stock1
        case .advancedStock:
            return .stock2
        case .developedBond:
            return .bond1
        case .advancedBond:
            return .bond2
        case .etc:
            return .etc1
        case .alternative:
            return .etc2
        }
    }
    
}
