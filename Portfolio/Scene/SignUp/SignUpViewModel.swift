//
//  SignUpViewModel.swift
//  Portfolio
//
//  Created by 홍정민 on 3/16/25.
//

import Foundation

final class SignUpViewModel {
    let keychainManager: KeychainManager
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    func saveUserCredentials(email: String, password: String) {
        do {
            try keychainManager.saveEmailPassword(
                email: email,
                password: password
            )
        } catch {
            print("저장 실패: \(error)")
        }
    }
}
