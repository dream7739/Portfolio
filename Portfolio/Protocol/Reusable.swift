//
//  Reusable.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension UIView: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
