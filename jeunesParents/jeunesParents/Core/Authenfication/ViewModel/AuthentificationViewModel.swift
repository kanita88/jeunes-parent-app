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
    
    
    func login() {
        AuthService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    // Traitement de la réponse
                    self?.isAuthenticated = true
                case .failure(let error):
                    // Gestion des erreurs
                    self?.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }
}
