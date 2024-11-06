//
//  KeyChainManager.swift
//  VaporFront
//
//  Created by Apprenant 154 on 31/10/2024.
//

import Foundation
import Security

struct KeyChainManager {
    
    static func save(token: String) {
        guard let tokenData = token.data(using: .utf8) else {
            print("Error converting token to data")
            return
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "VaporFrontToken",
            kSecValueData as String: tokenData
        ]
        SecItemDelete(query as CFDictionary)
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func get() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "VaporFrontToken",
            kSecReturnData as String: true
        ]
        
        var item : CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    static func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "authToken"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Erreur lors de la suppression du token : \(status)")
        } else {
            print("Token supprimé avec succès du Keychain")
        }
    }
}

