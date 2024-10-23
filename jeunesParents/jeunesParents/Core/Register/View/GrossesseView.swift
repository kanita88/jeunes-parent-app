import SwiftUI

struct GrossesseView : View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var parentViewModel = ParentViewModel()
    
    @State private var dateMenstruation = Date()
    @State private var dateConception = Date()
    @State private var dateAccouchement = Date()
    @State private var grossesseMultiple = false
    @State private var modeAccouchement  = ""
    @State private var conditionsMedicales = ""
    
    let modesAccouchement = ["Naturel", "Césarienne", "Indécis"]
    let conditionsMedicaless = ["Hypertension", "Diabète gestationnel", "Précédente césarienne"]
    
    // Fonction pour formater la date en String
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    // Fonction pour calculer la date de conception (14 jours après la date des dernières menstruations)
    func calculerDateConception(dateMenstruation: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 14, to: dateMenstruation) ?? Date()
    }

    // Fonction pour calculer la date d'accouchement (280 jours après la date des dernières menstruations)
    func calculerDateAccouchement(dateMenstruation: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 288, to: dateMenstruation) ?? Date()
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
                    HStack {
                        Section(header: Text("Date des dernières menstruations")) {
                            DatePicker("", selection: $dateMenstruation, displayedComponents: .date)
                                .onChange(of: dateMenstruation) { newDate in
                                    // Calculer la date de conception et la date d'accouchement à chaque modification
                                    dateConception = calculerDateConception(dateMenstruation: newDate)
                                    dateAccouchement = calculerDateAccouchement(dateMenstruation: newDate)
                                }
                        }
                    }
                    
                    // Date de conception (calculée automatiquement)
                    HStack {
                        Section(header: Text("Date estimée de conception")) {
                            Text(formatDate(dateConception))
                        }
                    }
                    
                    // Date prévue d'accouchement (calculée automatiquement)
                    HStack {
                        Section(header: Text("Date prévue d'accouchement")) {
                            Text(formatDate(dateAccouchement))
                        }
                    }
                    
                    // Grossesse multiple
                    Section(header: Text("Est-ce une grossesse multiple ?")) {
                        Picker("Grossesse multiple", selection: $grossesseMultiple) {
                            Text("Oui").tag(true)
                            Text("Non").tag(false)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accentColor(.blue)
                    }
                    
                    // Mode d'accouchement
                    HStack{
                        Section(header: Text("Mode d'accouchement")) {
                            Picker("", selection: $modeAccouchement) {
                                ForEach(modesAccouchement, id: \.self) { mode in
                                    Text(mode).tag(mode)
                                }
                            }
                        }
                    }
                    
                    
                    // Conditions médicales
                    HStack{
                        Section(header: Text("Conditions médicales")) {
                            Picker("", selection: $conditionsMedicales) {
                                ForEach(conditionsMedicaless, id: \.self) { conditions in
                                    Text(conditions).tag(conditions)
                                                   }
                                               }
                                           }
                    }
                    
                    
                    // Bouton de validation
                    Button(action: {
                        print("Données de grossesse soumises")
                        // Ajouter une logique pour enregistrer ou transmettre les données
                    }) {
                        Text("Valider")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                
    
                }
                
              }
            .disableAutocorrection(true)
            .scrollContentBackground(.hidden)
        }
    }
}

// Aperçu
#Preview {
    GrossesseView()
}
