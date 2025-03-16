//
//  KeychainManager.swift
//  PracticeGraph
//
//  Created by 홍정민 on 3/16/25.
//

import UIKit
import Security

final class KeychainManager {
    private init() { }
    static let shared = KeychainManager()
    
    enum KeychainError: Error {
        case duplicateItem
        case itemNotFound
        case unexpectedStatus(OSStatus)
    }
    
    func saveEmailPassword(email: String, password: String) throws {
        let emailData = email.data(using: .utf8)!
        let passwordData = password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: emailData,
            kSecValueData as String: passwordData,
            kSecAttrLabel as String: "User Email",
            kSecAttrDescription as String: "User Password"
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func getEmailPassword() throws -> (email: String, password: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrLabel as String: "User Email",
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        
        guard let existingItem = item as? [String: Any],
              let emailData = existingItem[kSecAttrAccount as String] as? Data,
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let email = String(data: emailData, encoding: .utf8),
              let password = String(data: passwordData, encoding: .utf8) else {
            throw KeychainError.itemNotFound
        }
        
        return (email, password)
    }
    
    func deleteEmailPassword() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrLabel as String: "User Email"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
