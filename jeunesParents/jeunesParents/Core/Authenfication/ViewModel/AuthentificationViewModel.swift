import Foundation
import SwiftUI
import Combine
import UIKit

class AuthentificationViewModel: ObservableObject {
    @Published var parent: Parent?  // Propriété parent doit être @Published pour être observée par la vue
    @Published var enfant: Enfant?
    @Published var profileImage: UIImage? // Stocke l'image de profil sélectionnée
    @Published var isUploading = false
    @Published var uploadSuccess = false
    @Published var email: String = "emilie.petit@example.com"
    @Published var password: String = "emilie1234"
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(enfant: Enfant?) {
        self.enfant = enfant
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
                    if error.localizedDescription.contains("Mot de passe incorrect") {
                        self?.errorMessage = "Le mot de passe est incorrect. Veuillez réessayer."
                    } else if error.localizedDescription.contains("Could not connect") {
                        self?.errorMessage = "Impossible de se connecter. Vérifiez votre connexion Internet et réessayez."
                    } else {
                        self?.errorMessage = error.localizedDescription  // Message générique
                    }
                }
            }
        }
    }
}
