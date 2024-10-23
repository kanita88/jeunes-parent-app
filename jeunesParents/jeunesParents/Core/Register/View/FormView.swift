import SwiftUI

struct FormView : View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var parentViewModel = ParentViewModel()
    
    @State private var nom = ""
    @State private var prenom = ""
    @State private var dateDeNaissance = Date()
    @State private var email = ""
    @State private var motDePasse = ""
    @State private var motDePasseConfirmation = ""
    @State private var premiereExperienceParentale = false
    @State private var enCouple = false
    
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
    
    var body: some View {
        NavigationStack {
            VStack() {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("Inscription")
                    .font(.title)
                    .fontWeight(.bold)
                
                Form {
                    // Nom
                    Section(header: Text("Nom")) {
                        TextField("Quel est votre nom ?", text: $nom)
                        if !nomError.isEmpty {
                            Text(nomError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // Prénom
                    Section(header: Text("Prénom")) {
                        TextField("Quel est votre prénom ?", text: $prenom)
                        if !prenomError.isEmpty {
                            Text(prenomError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // Date de naissance
                    Section(header: Text("Date de Naissance")) {
                        DatePicker("", selection: $dateDeNaissance, displayedComponents: .date)
                    }
                    
                    // Email
                    Section(header: Text("Email")) {
                        TextField("", text: $email)
                            .textInputAutocapitalization(.never)
                        if !emailError.isEmpty {
                            Text(emailError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // Mot de passe
                    Section(header: Text("Mot de passe")) {
                        SecureField("Mot de passe", text: $motDePasse)
                            .textInputAutocapitalization(.never)
                    }
                    
                    // Confirmation du mot de passe
                    Section(header: Text("Confirmez le mot de passe")) {
                        SecureField("Confirmez", text: $motDePasseConfirmation)
                            .textInputAutocapitalization(.never)
                        if !motDePasseError.isEmpty {
                            Text(motDePasseError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // Première expérience parentale
                    Section(header: Text("Première expérience parentale")) {
                        Picker("Avez-vous une première expérience parentale ?", selection: $premiereExperienceParentale) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // En couple
                    Section(header: Text("Êtes-vous en couple ?")) {
                        Picker("Êtes-vous en couple ?", selection: $enCouple) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Button(action: {
                    // Réinitialiser les erreurs
                    emailError = ""
                    motDePasseError = ""
                    nomError = ""
                    prenomError = ""
                    
                    // Validation des informations
                    if nom.isEmpty {
                        nomError = "Le nom ne peut pas être vide."
                    }
                    
                    if prenom.isEmpty {
                        prenomError = "Le prénom ne peut pas être vide."
                    }
                    
                    if !validateEmail(email) {
                        emailError = "Veuillez entrer un email valide."
                    }
                    
                    if motDePasse != motDePasseConfirmation {
                        motDePasseError = "Les mots de passe ne correspondent pas."
                    }
                    
                    // Si pas d'erreurs, ajouter le parent
                    if nomError.isEmpty && prenomError.isEmpty && emailError.isEmpty && motDePasseError.isEmpty {
                        parentViewModel.addParent(
                            id: UUID(),
                            nom: nom,
                            prenom: prenom,
                            dateDeNaissance: dateDeNaissance,
                            motDePasse: motDePasse,
                            motDePasseConfirmation: motDePasseConfirmation,
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
                .padding()
                
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
