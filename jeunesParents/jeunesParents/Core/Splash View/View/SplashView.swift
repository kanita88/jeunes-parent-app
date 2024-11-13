import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false // État pour gérer la navigation vers la vue d'authentification
    @StateObject var authViewModel = AuthentificationViewModel()
    
    var body: some View {
            if isActive {
                // Navigation vers la vue d'authentification lorsque isActive est vrai
                AuthentificationView(authViewModel: authViewModel)
                // Charger le token au démarrage
                    .onAppear {
                        authViewModel.loadToken()
                    }
            } else {
                // Affichage de l'écran de démarrage avec le logo
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                .onAppear {
                    // Déclenchement de l'animation lors de l'apparition de la vue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
                .background(Color.white) // Couleur de fond blanche
                .edgesIgnoringSafeArea(.all) // Ignorer les bordures de la zone sécurisée
            }
        
    }
}

#Preview {
    SplashView()
}
