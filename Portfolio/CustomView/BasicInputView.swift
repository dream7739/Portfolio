//
//  BasicTextField.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit

final class BasicInputView: UIView {
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    let inputTextField = UITextField()
    let validationLabel = UILabel()
    
    let type: UserInputType
    
    init(type: UserInputType) {
        self.type = type
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(inputTextField)
        stackView.addArrangedSubview(validationLabel)
    }
    
    private func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        stackView.axis = .vertical
        stackView.spacing = 3
        
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.textColor = .stock1
        titleLabel.text = type.title
        
        inputTextField.delegate = self
        inputTextField.placeholder = type.placeholder
        inputTextField.font = .systemFont(ofSize: 12)
        
        if type == .phone {
            inputTextField.keyboardType = .numberPad
        } else if type == .pwd {
            inputTextField.isSecureTextEntry = true
        }
        
        validationLabel.isHidden = true
        validationLabel.font = .systemFont(ofSize: 10)
        validationLabel.textColor = .systemPink
        
    }
    
    func showInvalidMessage() {
        validationLabel.isHidden = false
        validationLabel.text = type.invalidInput
    }
    
    func hideInvalidMessage() {
        validationLabel.isHidden = true
    }
}

extension BasicInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty || type != .phone {
            return true
        }
        
        guard let text = textField.text else { return false }
        let strippedNumber = text.replacingOccurrences(of: "-", with: "") + string
        if strippedNumber.count > 11 {
            return false
        }
        
        var formattedNumber = ""
        for (index, character) in strippedNumber.enumerated() {
            if index == 3 || index == 7 {
                formattedNumber += "-"
            }
            formattedNumber += String(character)
        }
        textField.text = formattedNumber
        
        return false
    }
}
