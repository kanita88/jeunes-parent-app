import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthentificationViewModel()
    
    var body: some View {
        NavigationStack {
            // Vérification de l'état de connexion
            if authViewModel.isAuthenticated {
                MainTabView()// Passe directement à la HomeView si connecté
            } else {
                // Vue de connexion si l'utilisateur n'est pas authentifié
                AuthentificationView(authViewModel: authViewModel)
                    .onAppear {
                        authViewModel.loadToken() // Charger le token au démarrage
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
