import SwiftUI

struct DateCarouselView: View {
    // Propriété pour la liste des dates individuelles
    @State private var weekDays: [String] = []

    // Propriété pour suivre la sélection
    @State private var selectedDate: String = ""

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(weekDays, id: \.self) { date in
                    Button(action: {
                        selectedDate = date
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
        .onAppear {
            // Générer les dates individuelles de lundi à vendredi
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
        selectedDate = weekDays.first ?? ""
    }
}

struct DateCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        DateCarouselView()
    }
}
