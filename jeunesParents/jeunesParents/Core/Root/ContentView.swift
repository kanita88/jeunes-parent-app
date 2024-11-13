import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthentificationViewModel() // Initialisez ici
    
    var body: some View {
        NavigationStack {
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(authViewModel) // Passe l'environnement à MainTabView
            } else {
                SplashView()
            }
        }
    }
}

#Preview {
    ContentView()
}
