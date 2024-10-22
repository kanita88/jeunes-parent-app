import Foundation
import SwiftUI

/// ViewModel pour gérer la logique d'authentification.
///
/// Le ViewModel utilise `@Published` pour rendre les propriétés réactives, ce qui permet
/// aux vues SwiftUI de se mettre à jour automatiquement en réponse aux changements de données.
class AuthentificationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    
    func login() {
        self.isLoading = true  // Démarrer le chargement
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
