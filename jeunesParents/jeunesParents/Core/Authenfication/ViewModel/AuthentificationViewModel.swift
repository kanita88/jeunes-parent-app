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
    
    // Initialisation avec un enfant (optionnel)
    init(enfant: Enfant?) {
        self.enfant = enfant
    }
    
    /// Fonction pour valider les informations d'authentification
    private func validateCredentials() -> Bool {
        // Vérifie que les champs ne sont pas vides
        if email.isEmpty || password.isEmpty {
            errorMessage = "L'email et le mot de passe ne peuvent pas être vides."
            return false
        }
        
        // Vérifie que l'email est valide
        if !isValidEmail(email) {
            errorMessage = "Veuillez entrer une adresse email valide."
            return false
        }
        
        return true // Retourne vrai si toutes les validations passent
    }
    
    /// Fonction de validation de l'email avec regex simple
    private func isValidEmail(_ email: String) -> Bool {
        // Modèle regex simplifié pour valider l'adresse email
        let emailRegEx = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// Fonction de connexion
    func login() {
        // Valide les informations d'identification avant de continuer
        guard validateCredentials() else { return }
        
        isLoading = true // Active le chargement
        errorMessage = nil // Réinitialise le message d'erreur
        
        // Appelle la fonction de connexion du AuthService
        AuthService.shared.login(email: email, password: password) { [weak self] result in
            // Passe sur le thread principal pour mettre à jour l'interface
            DispatchQueue.main.async {
                self?.isLoading = false // Désactive le chargement
                
                // Gère le résultat de la tentative de connexion
                switch result {
                case .success(let token):
                    // Connexion réussie : met à jour l'état et affiche le token
                    self?.isAuthenticated = true
                    print("Connexion réussie, token : \(token.token)")
                    
                case .failure(let error):
                    // Connexion échouée : affiche le message d'erreur
                    self?.errorMessage = error.localizedDescription
                    self?.isAuthenticated = false
                }
            }
        }
    }
}
