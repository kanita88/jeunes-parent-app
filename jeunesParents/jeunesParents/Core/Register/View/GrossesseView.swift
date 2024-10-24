import SwiftUI

struct GrossesseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var grossesseViewModel = GrossesseViewModel()
    
    @State private var dateMenstruation = Date()
    @State private var dateConception = Date()
    @State private var dateAccouchement = Date()
    @State private var grossesseMultiple = false
    @State private var modeAccouchement  = "Naturel"
    @State private var conditionsMedicales = "Hypertension"
    
    // Variable pour activer la navigation après validation
    @State private var navigateToEnfant = false
    
    // Variables pour afficher les messages d'erreur
    @State private var modeAccouchementError = ""
    @State private var conditionsMedicalesError = ""
    
    let modesAccouchement = ["Naturel", "Césarienne", "Indécis"]
    let conditionsMedicaless = ["Hypertension", "Diabète gestationnel", "Précédente césarienne"]
    
    // Fonction pour calculer la date de conception (14 jours après la date des dernières menstruations)
    func calculerDateConception(dateMenstruation: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 14, to: dateMenstruation) ?? Date()
    }
    
    // Fonction pour calculer la date d'accouchement (280 jours après la date des dernières menstruations)
    func calculerDateAccouchement(dateMenstruation: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 280, to: dateMenstruation) ?? Date()
    }
    
    // Validation des champs
    func validateFields() -> Bool {
        var isValid = true
        
        // Réinitialiser les erreurs
        modeAccouchementError = ""
        conditionsMedicalesError = ""
        
        if modeAccouchement.isEmpty {
            modeAccouchementError = "Veuillez sélectionner un mode d'accouchement."
            isValid = false
        }
        
        if conditionsMedicales.isEmpty {
            conditionsMedicalesError = "Veuillez sélectionner une condition médicale."
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
                
                Text("Informations sur la grossesse")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Form {
                    // Date des dernières menstruations
                    Section(header: Text("Date des dernières menstruations")) {
                        DatePicker("", selection: $dateMenstruation, displayedComponents: .date)
                            .onChange(of: dateMenstruation) { newDate in
                                dateConception = calculerDateConception(dateMenstruation: newDate)
                                dateAccouchement = calculerDateAccouchement(dateMenstruation: newDate)
                            }
                    }
                    
                    // Date de conception (calculée automatiquement)
                    Section(header: Text("Date estimée de conception")) {
                        DatePicker("", selection: $dateConception, displayedComponents: .date) // Utilisation de Date directement
                    }
                    
                    // Date prévue d'accouchement (calculée automatiquement)
                    Section(header: Text("Date prévue d'accouchement")) {
                        DatePicker("", selection: $dateAccouchement, displayedComponents: .date) // Utilisation de Date directement
                    }
                    
                    // Grossesse multiple
                    Section(header: Text("Grossesse multiple ?")) {
                        Picker("Grossesse multiple", selection: $grossesseMultiple) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // Mode d'accouchement
                    Section(header: Text("Mode d'accouchement")) {
                        Picker("Sélectionner", selection: $modeAccouchement) {
                            ForEach(modesAccouchement, id: \.self) { mode in
                                Text(mode).tag(mode)
                            }
                        }
                        if !modeAccouchementError.isEmpty {
                            Text(modeAccouchementError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // Conditions médicales
                    Section(header: Text("Conditions médicales")) {
                        Picker("Sélectionner", selection: $conditionsMedicales) {
                            ForEach(conditionsMedicaless, id: \.self) { conditions in
                                Text(conditions).tag(conditions)
                            }
                        }
                        if !conditionsMedicalesError.isEmpty {
                            Text(conditionsMedicalesError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // Bouton de validation
                    Button(action: {
                        // Validation des champs avant l'ajout
                        if validateFields() {
                            let newGrossesse = Grossesse(
                                id: UUID(),
                                dateMenstruation: dateMenstruation,
                                dateConception: dateConception,
                                dateAccouchement: dateAccouchement,
                                grossesseMultiple: grossesseMultiple,
                                modeAccouchement: modeAccouchement,
                                conditionsMedicales: conditionsMedicales
                            )
                            
                            grossesseViewModel.addGrossesse(newGrossesse)
                            navigateToEnfant = true
                        }
                    }) {
                        Text("Valider")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaire)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
                // Navigation vers la vue Enfant
                NavigationLink(destination: EnfantView(childViewModel: ChildViewModel()), isActive: $navigateToEnfant) {
                    EmptyView()
                }
            }
            .disableAutocorrection(true)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    GrossesseView()
}
