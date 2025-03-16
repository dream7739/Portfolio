//
//  BasicButton.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit

final class BasicButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .stock1
        tintColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonTitle(_ title: String) {
        let attrStr = NSMutableAttributedString(string: title)
        let range = NSRange(location: 0, length: title.utf16.count)
        attrStr.addAttribute(
            NSAttributedString.Key.font,
            value: UIFont.systemFont(ofSize: 14, weight: .semibold),
            range: range
        )
        attrStr.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: UIColor.white,
            range: range
        )
        setAttributedTitle(attrStr, for: .normal)

    }
}
