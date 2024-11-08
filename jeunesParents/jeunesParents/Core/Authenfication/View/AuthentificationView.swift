import SwiftUI

struct AuthentificationView: View {
    @StateObject var authViewModel: AuthentificationViewModel
    @State var isShowingPassword: Bool = false
    @State var showError: Bool = false
    @State private var isAuthenticated = true
    
    var body: some View {
        NavigationStack {
            // Logo
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300 , height: 300)
            
            VStack(spacing: 21.0) {
                // Zone pour entrer l'email
                TextField("Entrez votre email", text: $authViewModel.email)
                    .autocapitalization(.none)
                    .padding()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Zone pour entrer le mot de passe
                VStack {
                    HStack {
                        Group {
                            if isShowingPassword {
                                TextField("Entrez votre mot de passe", text: $authViewModel.password)
                            } else {
                                SecureField("Entrez votre mot de passe", text: $authViewModel.password)
                            }
                            
                            Button {
                                isShowingPassword.toggle()
                            } label: {
                                Image(systemName: isShowingPassword ? "eye.slash" : "eye")
                                    .foregroundStyle(Color.primaire)
                            }
                        }
                    }
                    .padding()
                    .autocapitalization(.none)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                // Connexion Button
                Button(action: {
                    authViewModel.login()
                }) {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text("Connexion")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaire)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Text("Mot de passe oublié ? ")
                
                // Gestion des erreurs
                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            // Navigation conditionnelle vers la HomeView lorsque l'utilisateur est authentifié
            .navigationDestination(isPresented: $authViewModel.isAuthenticated) {
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }
            Spacer()
            HStack {
                Text("Pas encore de compte ?")
                NavigationLink(destination: FormView()){
                    Text("Inscrivez-vous").bold()
                        .foregroundStyle(Color.primaire)
                }
            }
        }
        .padding()
    }
}

#Preview {
    AuthentificationView(authViewModel: AuthentificationViewModel())
}
