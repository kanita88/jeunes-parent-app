import SwiftUI

struct AuthentificationView: View {
    @ObservedObject var authViewModel: AuthentificationViewModel
    @State var isShowingPassword: Bool = false
    @State var showError: Bool = false
    
    var body: some View {
        NavigationStack {
            // Logo
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300 , height: 300)
            
            VStack(spacing: 21.0) {
                // Zone pour rentrer l'email
                TextField("Entrez votre email", text: $authViewModel.email)
                    .autocapitalization(.none)
                    .padding()
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Zone pour rentrer le mot de passe
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
                            }
                        }
                    }
                    .padding()
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
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                // Error Handling
                if showError, let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            Spacer()
        }
        .padding()
        .onReceive(authViewModel.$errorMessage) { _ in
            showError = true
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView(authViewModel: AuthentificationViewModel())
    }
}
