import SwiftUI

struct FormView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var parentViewModel = ParentViewModel()
    
    // Variables liées aux champs du formulaire
    @State private var nom = ""
    @State private var prenom = ""
    @State private var dateDeNaissance = Date()
    @State private var email = ""
    @State private var motDePasse = ""
    @State private var premiereExperienceParentale = false
    @State private var enCouple = false
    
    @State private var navigateToGrossesse = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Nom")) {
                    TextField("Quel est votre nom ?", text: $nom)
                    if !parentViewModel.nomError.isEmpty {
                        Text(parentViewModel.nomError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("Prénom")) {
                    TextField("Quel est votre prénom ?", text: $prenom)
                    if !parentViewModel.prenomError.isEmpty {
                        Text(parentViewModel.prenomError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("Date de Naissance")) {
                    DatePicker("", selection: $dateDeNaissance, displayedComponents: .date)
                        .labelsHidden()
                }
                
                Section(header: Text("Email")) {
                    TextField("test@test.com", text: $email)
                        .textInputAutocapitalization(.never)
                    if !parentViewModel.emailError.isEmpty {
                        Text(parentViewModel.emailError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("Mot de passe")) {
                    SecureField("Mot de passe", text: $motDePasse)
                        .textInputAutocapitalization(.never)
                    if !parentViewModel.motDePasseError.isEmpty {
                        Text(parentViewModel.motDePasseError)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
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
                
                Section {
                    Button(action: {
                        // Valider les champs avant l'ajout
                        if parentViewModel.validateFields(nom: nom, prenom: prenom, email: email, motDePasse: motDePasse) {
                            parentViewModel.addParent(
                                id: UUID(),
                                nom: nom,
                                prenom: prenom,
                                dateDeNaissance: dateDeNaissance,
                                motDePasse: motDePasse,
                                premiereExperienceParentale: premiereExperienceParentale,
                                enCouple: enCouple
                            )
                            navigateToGrossesse = true
                        }
                    }) {
                        Text("Valider")
                            .fontWeight(.bold)
                            .frame(width: 200)
                            .padding()
                            .background(isFormValid() ? Color.primaire : Color.gray) // Active le bouton uniquement si le formulaire est valide
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .disabled(!isFormValid()) // Désactive le bouton si le formulaire est invalide
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Inscription")
            .navigationDestination(isPresented: $navigateToGrossesse) {
                GrossesseView()
            }
        }
    }
    
    // Fonction pour vérifier si le formulaire est valide
    func isFormValid() -> Bool {
        return nom.isEmpty == false &&
               prenom.isEmpty == false &&
               parentViewModel.validateEmail(email) &&
               motDePasse.isEmpty == false
    }
}

#Preview {
    FormView()
}
