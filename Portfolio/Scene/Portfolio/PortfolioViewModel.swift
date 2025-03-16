//
//  PortfolioViewModel.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

final class PortfolioViewModel {
    var assetList: [Asset] = []
    
    init(assetList: [Asset]) {
        self.assetList = assetList
    }
}
