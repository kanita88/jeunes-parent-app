import SwiftUI

//  EnfantView.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 23/10/2024.
//

struct EnfantView : View{
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var enfantViewModel = EnfantViewModel()
    
    @State private var prenom = ""
    @State private var genre = ""
    @State private var dateDeNaissance = Date()
    @State private var terme = false
    @State var alimentation = ""
    @State var poids = 0.0
    @State var taille = 0
    
    let alimentations = ["allaitement", "biberon", "mixte"]
   
    
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
                
                Text("Informations sur l'enfant ")
                    .font(.title)
                    .fontWeight(.bold)
                
                Form {
                    HStack {
                        Section(header: Text("Prenom")) {
                            TextField("Prenom", text: $prenom)
                                .padding(.leading, 130)
                            
                        }
                    }
                    
                    HStack {
                        Section(header: Text("Genre")) {
                            TextField("Genre", text: $prenom)
                                .padding(.leading, 140)
                            
                        }
                    }
                    
                    HStack {
                        Section(header: Text("Date de Naissance")) {
                            DatePicker("", selection: $dateDeNaissance,displayedComponents: .date)                }
                    }
                    
                    HStack {
                        Section(header: Text("Né à terme")) {
                            Picker("", selection: $terme) {
                                Text("Oui").tag(true)
                                Text("Non").tag(false)
                                    
                            }
                            
                        }
                    }
                    
                    HStack{
                        Section(header: Text("Alimentation")) {
                            Picker("", selection: $alimentation) {
                                ForEach(alimentations, id: \.self) { mode in
                                    Text(mode).tag(mode)
                                }
                            }
                        }
                    }
                    
                    HStack{
                        Section(header: Text("Poids (kg)")) {
                        TextField("Poids en kg", value: $poids, formatter: NumberFormatter()) // TextField pour un Double
                            .keyboardType(.decimalPad)
                            .padding(.leading, 150)
                        }
                    }
                    
                    HStack{
                        Section(header: Text("Taille (cm)")) {
                        TextField("Taille en cm", value: $taille, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .padding(.leading, 150)
                        }
                    }
                      
                    
                    Button(action: {
                        // Utilisation de la fonction formatDate pour convertir dateDeNaissance en String
                        let formattedDate = formatDate(dateDeNaissance)
                        
                        // Création d'un nouvel objet Enfant
                        let newEnfant = Enfant(
                            id: UUID(), // ID généré automatiquement
                            prenom: prenom,
                            genre: genre,
                            dateDeNaissance: formattedDate, // Date formatée
                            terme: terme,
                            alimentation: alimentation,
                            poids: poids,
                            taille: taille)
                       
                        // Appel de la méthode d'ajout dans le ViewModel
                        enfantViewModel.addEnfant(newEnfant)
                        
                        // Ferme la vue après l'ajout
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Création")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                        
                    }
                    
                }
                
            .disableAutocorrection(true)
            .scrollContentBackground(.hidden)
            
            }
            
        }
        
    }
    


#Preview {
    EnfantView()
}
