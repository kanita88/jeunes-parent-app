import SwiftUI

struct GrossesseView : View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var grossesseViewModel = GrossesseViewModel()
    
    @State private var dateMenstruation = Date()
    @State private var dateConception = Date()
    @State private var dateAccouchement = Date()
    @State private var grossesseMultiple = false
    @State private var modeAccouchement  = ""
    @State private var conditionsMedicales = ""
    
    // Variable pour activer la navigation après validation
    @State private var navigateToEnfant = false
    
    let modesAccouchement = ["Naturel", "Césarienne", "Indécis"]
    let conditionsMedicaless = ["Hypertension", "Diabète gestationnel", "Précédente césarienne"]
    
    // Fonction pour convertir une date en chaîne de caractères
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    // Fonction pour calculer la date de conception (14 jours après la date des dernières menstruations)
    func calculerDateConception(dateMenstruation: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 14, to: dateMenstruation) ?? Date()
    }
    
    // Fonction pour calculer la date d'accouchement (280 jours après la date des dernières menstruations)
    func calculerDateAccouchement(dateMenstruation: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 280, to: dateMenstruation) ?? Date()
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
                        Text(formatDate(dateConception)) // Convertir la date en String pour l'affichage
                    }
                    
                    // Date prévue d'accouchement (calculée automatiquement)
                    Section(header: Text("Date prévue d'accouchement")) {
                        Text(formatDate(dateAccouchement)) // Convertir la date en String pour l'affichage
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
                    }
                    
                    // Conditions médicales
                    Section(header: Text("Conditions médicales")) {
                        Picker("Sélectionner", selection: $conditionsMedicales) {
                            ForEach(conditionsMedicaless, id: \.self) { conditions in
                                Text(conditions).tag(conditions)
                            }
                        }
                    }
                    
                    // Bouton de validation
                    Button(action: {
                        // Utilisation de la fonction formatDate pour convertir la date en String
                        let formattedDateMenstruation = formatDate(dateMenstruation)
                        let formattedDateConception = formatDate(dateConception)
                        let formattedDateAccouchement = formatDate(dateAccouchement)
                        
                        // Utilisation dans l'initialisation de l'objet Grossesse
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
