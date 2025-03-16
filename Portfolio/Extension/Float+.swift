//
//  Float+.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

extension Float {
    func toRateFormat() -> String {
        return String(format: "%.2f%%", self)
    }
}
