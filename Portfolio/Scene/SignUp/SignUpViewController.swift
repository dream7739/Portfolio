//
//  SignUpViewController.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    private let titleLabel = UILabel()
    private let announceLabel = UILabel()
    private let nextButton = BasicButton()
    private let infoStackView = UIStackView()
    private let emailInputView = BasicInputView(type: .email)
    private let idInputView  = BasicInputView(type: .id)
    private let passwordInputView = BasicInputView(type: .pwd)
    private let phoneInputView  = BasicInputView(type: .phone)
    
    let viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(announceLabel)
        view.addSubview(infoStackView)
        infoStackView.addArrangedSubview(emailInputView)
        infoStackView.addArrangedSubview(idInputView)
        infoStackView.addArrangedSubview(passwordInputView)
        infoStackView.addArrangedSubview(phoneInputView)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        
        announceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(announceLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.bottom.lessThanOrEqualTo(nextButton.snp.top).offset(-10)
        }
        
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            make.height.equalTo(50)
        }
        
    }
    
    private func configureView() {
        view.backgroundColor = .white
        titleLabel.text = "상위 1% 자산관리를 당신에게 AIM®"
        titleLabel.font = .systemFont(ofSize: 12)
        
        announceLabel.text = "회원정보를 입력해주세요"
        announceLabel.font = .boldSystemFont(ofSize: 16)
        
        infoStackView.axis = .vertical
        infoStackView.spacing = 10
        infoStackView.alignment = .leading
        
        emailInputView.inputTextField.becomeFirstResponder()
        
        nextButton.setButtonTitle("회원가입")
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func nextButtonClicked() {
        let isValid = checkInputValidation()
        if isValid {
            let email = emailInputView.inputTextField.text!.trimmingCharacters(in: .whitespaces)
            let password = passwordInputView.inputTextField.text!.trimmingCharacters(in: .whitespaces)
            viewModel.saveUserCredentials(email: email, password: password)
            
            let assetViewModel = AssetViewModel(jsonConverter: JSONConverter.shared)
            let assetViewController = AssetViewController(viewModel: assetViewModel)
            navigationController?.pushViewController(assetViewController, animated: true)
            
            print(try? KeychainManager.shared.getEmailPassword())
        }
    }
}

extension SignUpViewController {
    private func checkInputValidation() -> Bool {
        var invalidTextField: [UITextField] = []
        
        let emailValid = emailInputView.inputTextField.text!.trimmingCharacters(in: .whitespaces).isValidEmail
        if !emailValid {
            invalidTextField.append(emailInputView.inputTextField)
            emailInputView.showInvalidMessage()
        } else {
            emailInputView.hideInvalidMessage()
        }
        
        let idValid = idInputView.inputTextField.text!.trimmingCharacters(in: .whitespaces).isValidID
        if !idValid {
            invalidTextField.append(idInputView.inputTextField)
            idInputView.showInvalidMessage()
        } else {
            idInputView.hideInvalidMessage()
        }
        
        let passwordValid = passwordInputView.inputTextField.text!.trimmingCharacters(in: .whitespaces).isValidPassword
        if !passwordValid {
            invalidTextField.append(passwordInputView.inputTextField)
            passwordInputView.showInvalidMessage()
        } else {
            passwordInputView.hideInvalidMessage()
        }
        
        let phoneValid = phoneInputView.inputTextField.text!.trimmingCharacters(in: .whitespaces).isValidPhoneNumber
        if !phoneValid {
            invalidTextField.append(phoneInputView.inputTextField)
            phoneInputView.showInvalidMessage()
        } else {
            phoneInputView.hideInvalidMessage()
        }
        
        if !invalidTextField.isEmpty {
            invalidTextField[0].becomeFirstResponder()
        }
        
        return emailValid && idValid && passwordValid && phoneValid
    }
}
