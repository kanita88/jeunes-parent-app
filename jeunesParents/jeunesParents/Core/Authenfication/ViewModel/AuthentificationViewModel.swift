import Foundation
import SwiftUI
import Combine
import UIKit

class AuthentificationViewModel: ObservableObject {
    // Propriétés observables pour permettre à la vue de réagir aux changements
    @Published var parent: Parent?
    @Published var enfant: Enfant?
    @Published var profileImage: UIImage? // Image de profil sélectionnée
    @Published var isUploading = false // État de téléchargement de l'image
    @Published var uploadSuccess = false // Indicateur de succès du téléchargement
    @Published var email: String = "thomasl@gmail.com" // Email de l'utilisateur
    @Published var password: String = "thomas123456789" // Mot de passe de l'utilisateur
    @Published var isAuthenticated: Bool = false // Statut d'authentification
    @Published var errorMessage: String? // Message d'erreur en cas de problème
    @Published var isLoading: Bool = false // Indicateur de chargement pendant la connexion
    
    private var cancellables = Set<AnyCancellable>() // Ensemble pour stocker les abonnements Combine
    
    init() {
        // Chargement du token depuis le Keychain pour maintenir la session
        loadToken()
    }
    
    /// Fonction pour valider les informations d'authentification
    private func validateCredentials() -> Bool {
        if email.isEmpty || password.isEmpty {
            errorMessage = "L'email et le mot de passe ne peuvent pas être vides."
            return false
        }
        
        if !isValidEmail(email) {
            errorMessage = "Veuillez entrer une adresse email valide."
            return false
        }
        
        return true
    }
    
    /// Fonction de validation de l'email avec regex simple
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// Fonction de connexion
    func login() {
        guard validateCredentials() else { return }
        
        isLoading = true
        errorMessage = nil
        
        AuthService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let token):
                    self?.isAuthenticated = true
                    print("Connexion réussie, token : \(token.token)")
                    
                    // Sauvegarder le token dans le Keychain
                    KeyChainManager.save(token: token.token)
                    
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.isAuthenticated = false
                }
            }
        }
    }
    
    /// Fonction de déconnexion
    func logout() {
        KeyChainManager.deleteToken()
        self.isAuthenticated = false
        print("Déconnexion réussie et token supprimé.")
    }
    
    /// Chargement du token au démarrage de l'application
    func loadToken() {
        if let token = KeyChainManager.get() {
            isAuthenticated = true
            print("Token trouvé : \(token)")
        } else {
            isAuthenticated = false
            print("Aucun token trouvé")
        }
    }
}
