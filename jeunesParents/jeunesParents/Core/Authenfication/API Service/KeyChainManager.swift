import Foundation
import Security

struct KeyChainManager {
    
    private static let tokenAccount = "token"  // Nom du compte token centralisé

    // Sauvegarde du token dans le Keychain
    static func save(token: String) {
        guard let tokenData = token.data(using: .utf8) else {
            print("Erreur : impossible de convertir le token en données.")
            return
        }
        
        // Création de la requête
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount,
            kSecValueData as String: tokenData
        ]
        
        // Suppression des éventuels tokens existants avant d'ajouter le nouveau
        SecItemDelete(query as CFDictionary)
        
        // Ajout du token au Keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Token enregistré avec succès dans le Keychain.")
        } else {
            print("Erreur lors de l'enregistrement du token : \(status)")
        }
    }
    
    // Récupération du token depuis le Keychain
    static func get() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // Vérification du statut et conversion des données
        if status == errSecSuccess, let data = item as? Data {
            if let token = String(data: data, encoding: .utf8) {
                print("Token récupéré avec succès : \(token)")
                return token
            } else {
                print("Erreur : impossible de convertir les données récupérées en chaîne.")
            }
        } else {
            print("Erreur lors de la récupération du token : \(status)")
        }
        
        return nil
    }
    
    // Suppression du token depuis le Keychain
    static func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenAccount
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess {
            print("Token supprimé avec succès du Keychain.")
        } else if status == errSecItemNotFound {
            print("Aucun token trouvé dans le Keychain.")
        } else {
            print("Erreur lors de la suppression du token : \(status)")
        }
    }
}
