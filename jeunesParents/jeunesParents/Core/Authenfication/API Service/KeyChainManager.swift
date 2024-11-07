import Foundation
import Security

struct KeyChainManager {
    
    static let tokenAccount = "token"
    
    static func save(token: String) {
        guard let tokenData = token.data(using: .utf8) else {
            print("Error converting token to data")
            return
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount,
            kSecValueData as String: tokenData
        ]
        
        // Supprimer toute entrée existante avant d'ajouter le nouveau token
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Token enregistré avec succès")
        } else {
            print("Erreur lors de l'enregistrement du token : \(status)")
        }
    }
    
    static func get() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess, let data = item as? Data {
            if let token = String(data: data, encoding: .utf8) {
                print("Token récupéré : \(token)") // Afficher le token dans la console
                return token
            } else {
                print("Erreur : impossible de convertir les données en chaîne.")
            }
        } else {
            print("Erreur lors de la récupération du token : \(status)")
        }
        
        return nil
    }
    
    static func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "token" // Assurez-vous que le nom du token est correct
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("Token supprimé avec succès du Keychain")
        } else if status == errSecItemNotFound {
            print("Aucun token trouvé dans le Keychain")
        } else {
            print("Erreur lors de la suppression du token : \(status)")
        }
    }
}
