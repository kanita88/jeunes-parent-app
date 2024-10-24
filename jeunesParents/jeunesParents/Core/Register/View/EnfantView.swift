import SwiftUI

//  EnfantView.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 23/10/2024.

struct EnfantView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var childViewModel: ChildViewModel
    
    // Variable pour activer la navigation après validation
    @State private var navigateToHome = false
    
    // Champs d'entrée pour les informations de l'enfant
    @State private var prenom = ""
    @State private var genre = ""
    @State private var dateDeNaissance = Date()
    @State private var terme = false
    @State private var alimentation = ""
    @State private var poidsString = "" // Stocker le poids comme une chaîne de caractères
    @State private var tailleString = "" // Stocker la taille comme une chaîne de caractères
    
    let alimentations = ["allaitement", "biberon", "mixte"]
    
    // Messages d'erreur
    @State private var errorMessage = ""
    
    // Fonction pour convertir une chaîne en Double
    func convertToDouble(_ input: String) -> Double? {
        return Double(input)
    }
    
    // Fonction pour convertir une chaîne en Int
    func convertToInt(_ input: String) -> Int? {
        return Int(input)
    }
    
    // Validation des champs
    func validateFields() -> Bool {
        errorMessage = ""
        
        if prenom.isEmpty {
            errorMessage = "Le prénom est requis."
            return false
        }
        
        if genre.isEmpty {
            errorMessage = "Le genre est requis."
            return false
        }
        
        if convertToDouble(poidsString) == nil {
            errorMessage = "Le poids doit être un nombre valide."
            return false
        }
        
        if convertToInt(tailleString) == nil {
            errorMessage = "La taille doit être un nombre entier valide."
            return false
        }
        
        return true
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("Informations sur l'enfant")
                    .font(.title)
                    .fontWeight(.bold)
                
                Form {
                    Section(header: Text("Prénom")) {
                        TextField("Entrez le prénom", text: $prenom)
                    }
                    
                    Section(header: Text("Genre")) {
                        TextField("Entrez le genre", text: $genre)
                    }
                    
                    Section(header: Text("Date de Naissance")) {
                        DatePicker("", selection: $dateDeNaissance, displayedComponents: .date)
                    }
                    
                    Section(header: Text("Né à terme")) {
                        Picker("", selection: $terme) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Alimentation")) {
                        Picker("", selection: $alimentation) {
                            ForEach(alimentations, id: \.self) { mode in
                                Text(mode).tag(mode)
                            }
                        }
                    }
                    
                    Section(header: Text("Poids (kg)")) {
                        TextField("Entrez le poids", text: $poidsString)
                            .keyboardType(.decimalPad) // Clavier pour les nombres décimaux
                    }
                    
                    Section(header: Text("Taille (cm)")) {
                        TextField("Entrez la taille", text: $tailleString)
                            .keyboardType(.numberPad) // Clavier pour les nombres entiers
                    }
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Button(action: {
                    // Validation des champs
                    if validateFields() {
                        // Création d'un nouvel objet Enfant
                        let newEnfant = Enfant(
                            id: UUID(),
                            nom: prenom,
                            genre: genre,
                            dateDeNaissance: formatDate(dateDeNaissance), // Date formatée
                            terme: terme,
                            poids: convertToDouble(poidsString) ?? 0.0, // Conversion du poids
                            taille: convertToInt(tailleString) ?? 0, // Conversion de la taille
                            profileImageURL: nil, // Pas d'image par défaut
                            cartesDeDeveloppement: [] // Liste vide par défaut
                        )
                        
                        // Ajout de l'enfant dans le ViewModel
                        childViewModel.addEnfant(newEnfant)
                        
                        // Navigation vers HomeView
                        navigateToHome = true
                    }
                }) {
                    Text("Valider")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.primaire)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }.padding(.horizontal)
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
                    .navigationBarBackButtonHidden(true) // Cache le bouton de retour pour la HomeView
            }
        }
        .disableAutocorrection(true)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    EnfantView(childViewModel: ChildViewModel())
}
