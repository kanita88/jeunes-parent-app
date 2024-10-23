import SwiftUI

struct FormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var parentViewModel = ParentViewModel()
    
    @State private var nom = ""
    @State private var prenom = ""
    @State private var dateDeNaissance = Date()
    @State private var email = ""
    @State private var motDePasse = ""
    @State private var premiereExperienceParentale = false
    @State private var enCouple = false
    
    // Variable pour activer la navigation après validation du formulaire
    @State private var navigateToGrossesse = false
    
    // Variables pour afficher les messages d'erreur
    @State private var emailError = ""
    @State private var motDePasseError = ""
    @State private var nomError = ""
    @State private var prenomError = ""
    
    // Fonction pour valider les informations de l'email
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Validation des champs
    func validateFields() -> Bool {
        var isValid = true
        
        // Réinitialiser les erreurs
        emailError = ""
        motDePasseError = ""
        nomError = ""
        prenomError = ""
        
        // Validation des informations
        if nom.isEmpty {
            nomError = "Le nom ne peut pas être vide."
            isValid = false
        }
        
        if prenom.isEmpty {
            prenomError = "Le prénom ne peut pas être vide."
            isValid = false
        }
        
        if !validateEmail(email) {
            emailError = "Veuillez entrer un email valide."
            isValid = false
        }
        
        if motDePasse.isEmpty {
            motDePasseError = "Le mot de passe ne peut pas être vide."
            isValid = false
        }
        
        return isValid
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("Inscription")
                    .font(.title)
                    .fontWeight(.bold)
                
                Form {
                    Section(header: Text("Nom")) {
                        TextField("Quel est votre nom ?", text: $nom)
                        
                        if !nomError.isEmpty {
                            Text(nomError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    Section(header: Text("Prénom")) {
                        TextField("Quel est votre prénom ?", text: $prenom)
                        if !prenomError.isEmpty {
                            Text(prenomError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    Section(header: Text("Date de Naissance")) {
                        DatePicker("", selection: $dateDeNaissance, displayedComponents: .date)
                    }
                    
                    Section(header: Text("Email")) {
                        TextField("test@test.com", text: $email)
                            .textInputAutocapitalization(.never)
                        if !emailError.isEmpty {
                            Text(emailError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    Section(header: Text("Mot de passe")) {
                        SecureField("Mot de passe", text: $motDePasse)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section(header: Text("Première expérience parentale")) {
                        Picker("Avez-vous une première expérience parentale ?", selection: $premiereExperienceParentale) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Êtes-vous en couple ?")) {
                        Picker("Êtes-vous en couple ?", selection: $enCouple) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                // Bouton de validation
                Button(action: {
                    if validateFields() {
                        // Ajouter le parent si toutes les validations réussissent
                        parentViewModel.addParent(
                            id: UUID(),
                            nom: nom,
                            prenom: prenom,
                            dateDeNaissance: dateDeNaissance,
                            motDePasse: motDePasse,
                            premiereExperienceParentale: premiereExperienceParentale,
                            enCouple: enCouple
                        )
                        
                        // Fermer la vue après l'ajout
                        presentationMode.wrappedValue.dismiss()
                        
                        navigateToGrossesse = true
                    }
                }) {
                    Text("Création")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaire)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                // Navigation vers la vue Grossesse
                NavigationLink(destination: GrossesseView(), isActive: $navigateToGrossesse) {
                    EmptyView()
                }
            }
            .disableAutocorrection(true)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    FormView()
}
