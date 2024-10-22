import Foundation
import SwiftUI

class AuthentificationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
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
        // Validation d'email basique avec regex
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// Fonction de connexion
    func login() {
        // Réinitialiser les messages d'erreur
        errorMessage = nil
        
        // Valider les informations
        guard validateCredentials() else { return }
        
        self.isLoading = true  // Démarrer le chargement
        
        // Appeler le service d'authentification
        AuthService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false  // Arrêter le chargement une fois terminé
                switch result {
                case .success(_):
                    self?.isAuthenticated = true  // Connexion réussie
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription  // Gestion des erreurs
                }
            }
        }
    }
}
