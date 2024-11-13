//
//  ForgotPasswordView.swift
//  jeunesParents
//
//  Created by Apprenant 154 on 13/11/2024.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State var email: String = ""
    
    var body: some View {
        VStack {
            Text("Test")
            TextField("Entrez votre email", text: $email)
                .autocapitalization(.none)
                .padding()
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
            
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
        }
        .navigationTitle("Mot de passe oublié ?")
    }
}

#Preview {
    ResetPasswordView()
}
