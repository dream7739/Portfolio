//
//  AssetViewModel.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

final class AssetViewModel {
    let jsonConverter: JSONConverter
    var portfolio: Portfolio?
    
    init(jsonConverter: JSONConverter) {
        self.jsonConverter = jsonConverter
    }
    
    func readPortfolio() -> Portfolio? {
        guard let data = jsonConverter.readJSONFile(fileName: "portfolio"),
        let portfolio: Portfolio = jsonConverter.convertFromJSON(data: data) else { return nil }
        self.portfolio = portfolio
        return portfolio
    }
    
}
