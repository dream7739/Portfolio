//
//  AssetViewModel.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

final class AssetViewModel {
    let jsonConverter: JSONConverter
    var Portfolio: Portfolio?
    
    init(jsonConverter: JSONConverter) {
        self.jsonConverter = jsonConverter
    }
    
    func readPortfolio() -> Portfolio? {
        guard let data = jsonConverter.readJSONFile(fileName: "portfolio"),
        let Portfolio: Portfolio = jsonConverter.convertFromJSON(data: data) else { return nil }
        self.Portfolio = Portfolio
        return Portfolio
    }
    
}
