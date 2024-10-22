import SwiftUI
//  ParentView.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 21/10/2024.
//

struct FormView : View {
    @Environment(\.presentationMode) var presentationMode
    //
    @ObservedObject var parentViewModel = ParentViewModel()
    //
    
    
    @State private var nom = ""
    @State private var prenom = ""
    @State private var dateDeNaissance = Date()
    @State private var email = ""
    @State private var motDePasse = ""
    @State private var motDePasseConfirmation = ""
    @State private var premiereExperienceParentale = false
    @State private var enCouple = false
    @State private var enfants = ""
    
    // Fonction pour formater la date en String
        func formatDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium // Format de la date (tu peux personnaliser)
            return formatter.string(from: date)
        }
    
    var body: some View {
        NavigationStack {
            VStack(){
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("Inscription")
                    .font(.title)
                    .fontWeight(.bold)
                
                Form {
                    HStack {
                        Section(header: Text("Nom")) {
                            TextField("Quel est votre nom ?", text: $nom)
                                .padding(.leading, 110)
                        }
                    }
                    
                    HStack {
                        Section(header: Text("Prenom")) {
                            TextField("Prenom", text: $prenom)
                                .padding(.leading, 90)
                            
                        }
                    }
                    
                    HStack {
                        Section(header: Text("Date de Naissance")) {
                            DatePicker("", selection: $dateDeNaissance,displayedComponents: .date)                }
                    }
                    
                    HStack {
                        Section(header: Text("Email")) {
                            TextField("test@test.com", text: $email)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 105)
                        }
                    }
                    
                    HStack {
                        Section(header: Text("Mot de passe")) {
                            SecureField("Mot de passe", text: $motDePasse)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 45)
                        }
                        
                    }
                    
                    HStack {
                        Section(header: Text("Confirme")) {
                            SecureField("Confirme", text: $motDePasseConfirmation)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 80)
                        }
                    }
                    
                    Section(header: Text("Première expérience parentale")) {
                        Picker("Avez-vous une première expérience parentale ?", selection: $premiereExperienceParentale) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accentColor(Color.blue)
                    }
                    
                    Section(header: Text("Êtes-vous en couple ?")) {
                        Picker("Êtes-vous en couple ?", selection: $enCouple) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .tint(.blue)
                    }
                    
                }
                
            }
            
            .disableAutocorrection(true)
            .scrollContentBackground(.hidden)
        }
        
        
        Button(action: {
    // Utilisation de la fonction formatDate pour convertir dateDeNaissance en String
            let formattedDate = formatDate(dateDeNaissance)
            let newParent = Parent(id: UUID(), nom: nom, prenom: prenom, dateDeNaissance: formattedDate, motDePasse: motDePasse, motDePasseConfirmation : motDePasseConfirmation, premiereExperienceParentale: false, enCouple: enCouple, enfants: [])
           
            parentViewModel.addParent(newParent)
            presentationMode.wrappedValue.dismiss()
        })
        {
            
        }
    }
}

#Preview {
    FormView()
}

