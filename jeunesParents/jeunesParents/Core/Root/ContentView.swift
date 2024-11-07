import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthentificationViewModel() // Initialisez ici
    
    var body: some View {
        NavigationStack {
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(authViewModel) // Passe l'environnement à MainTabView
            } else {
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
