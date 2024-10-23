import SwiftUI

//  EnfantView.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 23/10/2024.
//

struct EnfantView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var childViewModel: ChildViewModel
    
    // Variable pour activer la navigation après validation
    @State private var navigateToHome = false
    
    @State private var prenom = ""
    @State private var genre = ""
    @State private var dateDeNaissance = Date()
    @State private var terme = false
    @State var alimentation = ""
    @State var poidsString = "" // Stocker le poids comme une chaîne de caractères
    @State var tailleString = "" // Stocker la taille comme une chaîne de caractères
    
    let alimentations = ["allaitement", "biberon", "mixte"]
    
    // Fonction pour formater la date en String
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Format de la date (tu peux personnaliser)
        return formatter.string(from: date)
    }
    
    // Fonction pour convertir une chaîne en Double
    func convertToDouble(_ input: String) -> Double {
        return Double(input) ?? 0.0
    }
    
    // Fonction pour convertir une chaîne en Int
    func convertToInt(_ input: String) -> Int {
        return Int(input) ?? 0
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Text("Informations sur l'enfant ")
                    .font(.title)
                    .fontWeight(.bold)
                
                Form {
                    Section(header: Text("Prenom")) {
                        TextField("Prenom", text: $prenom)
                    }
                    
                    Section(header: Text("Genre")) {
                        TextField("Genre", text: $genre)
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
                        TextField("Poids en kg", text: $poidsString)
                            .keyboardType(.decimalPad) // Assurez-vous que le clavier est configuré pour les nombres décimaux
                    }
                    
                    Section(header: Text("Taille (cm)")) {
                        TextField("Taille en cm", text: $tailleString)
                            .keyboardType(.numberPad) // Assurez-vous que le clavier est configuré pour les nombres entiers
                    }
                }
                
                Button(action: {
                    // Utilisation de la fonction formatDate pour convertir dateDeNaissance en String
                    let formattedDate = formatDate(dateDeNaissance)
                    
                    // Création d'un nouvel objet Enfant
                    let newEnfant = Enfant(
                        id: UUID(), // ID généré automatiquement
                        nom: prenom, // Utilisez 'nom' ici pour correspondre à la structure
                        genre: genre,
                        dateDeNaissance: formattedDate, // Date formatée
                        terme: terme,
                        poids: convertToDouble(poidsString), // Conversion manuelle de la chaîne vers Double
                        taille: convertToInt(tailleString), // Conversion manuelle de la chaîne vers Int
                        profileImageURL: nil, // Si aucune URL de l'image n'est disponible
                        cartesDeDeveloppement: [] // Initialisez avec une liste vide pour les cartes de développement
                    )
                    
                    // Appel de la méthode d'ajout dans le ViewModel
                    childViewModel.addEnfant(newEnfant)
                    
                    // Active la navigation vers HomeView après l'ajout
                    navigateToHome = true
                }) {
                    Text("Valider")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
        }
        .disableAutocorrection(true)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    EnfantView(childViewModel: ChildViewModel())
}
