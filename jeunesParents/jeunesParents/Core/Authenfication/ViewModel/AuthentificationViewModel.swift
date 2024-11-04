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
        isLoading = true
        errorMessage = nil
        
        AuthService.shared.login(email: email, password: password)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Simulate successful login (you'd want to check the response here instead)
            self.isLoading = false
            // Navigate to next screen or handle success
        }
    }
}
