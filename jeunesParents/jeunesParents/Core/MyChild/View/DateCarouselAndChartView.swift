import SwiftUI
import Charts

struct DateCarouselAndChartView: View {
    // Propriété pour la liste des dates individuelles
    @State private var weekDays: [String] = []
    // Propriété pour suivre la sélection
    @State private var selectedDate: String = ""
    // Propriété pour les données à afficher dans le graphique
    @State private var dataPoints: [DataPoint] = []
    
    var body: some View {
        VStack {
            // Carrousel de dates
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(weekDays, id: \.self) { date in
                        Button(action: {
                            selectedDate = date
                            updateChartData(for: date)  // Mettre à jour les données du graphique
                        }) {
                            Text(date)
                                .font(.system(size: 20))
                                .fontWeight(selectedDate == date ? .bold : .regular)
                                .foregroundColor(selectedDate == date ? .white : .gray)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(selectedDate == date ? Color.blue : Color.clear)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            
            // Graphique dynamique
            Chart(dataPoints) { point in
                LineMark(
                    x: .value("Jour", point.day),
                    y: .value("Poids", point.value)
                )
                .symbol(Circle())
                .interpolationMethod(.catmullRom) // Lissage des lignes
            }
            .frame(height: 300)
            .padding()
            
            Spacer()
        }
        .onAppear {
            // Générer les dates et les données du carrousel
            generateWeekDaysForMonth()
        }
    }

    // Fonction pour générer les jours de lundi à vendredi pour tout le mois
    func generateWeekDaysForMonth() {
        let calendar = Calendar.current
        let today = Date()
        let currentMonth = calendar.component(.month, from: today)

        // Formatteur pour les jours et mois
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"  // Format de la date : 21 Octobre

        var dates: [String] = []
        var currentMonday: Date? = calendar.nextDate(after: today, matching: DateComponents(weekday: 2), matchingPolicy: .nextTime)

        // Générer les dates de lundi à vendredi pour chaque semaine du mois en cours
        while let monday = currentMonday, calendar.component(.month, from: monday) == currentMonth {
            for i in 0..<5 {  // Du lundi au vendredi (5 jours)
                if let day = calendar.date(byAdding: .day, value: i, to: monday) {
                    let dayString = dateFormatter.string(from: day)
                    dates.append(dayString)
                }
            }

            // Passer au lundi suivant
            currentMonday = calendar.date(byAdding: .day, value: 7, to: monday)
        }

        // Mettre à jour la propriété weekDays avec toutes les dates générées
        weekDays = dates
        
        // Chercher la date du jour et la sélectionner si possible
        let todayString = dateFormatter.string(from: today)
        if weekDays.contains(todayString) {
            selectedDate = todayString
        } else {
            selectedDate = weekDays.first ?? ""
        }
        
        // Charger les données pour la date sélectionnée (date du jour ou première date)
        updateChartData(for: selectedDate)
    }

    // Mettre à jour les données du graphique en fonction de la date sélectionnée
    func updateChartData(for date: String) {
        // Ici, nous mettons à jour les points de données du graphique en fonction de la date sélectionnée
        // Vous pouvez changer cette logique selon vos données réelles

        // Exemple de données fictives
        let sampleData = [
            DataPoint(day: "Lundi", value: 60),
            DataPoint(day: "Mardi", value: 65),
            DataPoint(day: "Mercredi", value: 70),
            DataPoint(day: "Jeudi", value: 50),
            DataPoint(day: "Vendredi", value: 85)
        ]
        
        // Vous pouvez filtrer ou modifier ces données selon la date sélectionnée
        dataPoints = sampleData
    }
}

// Modèle pour représenter un point de données
struct DataPoint: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

struct DateCarouselAndChartView_Previews: PreviewProvider {
    static var previews: some View {
        DateCarouselAndChartView()
    }
}
