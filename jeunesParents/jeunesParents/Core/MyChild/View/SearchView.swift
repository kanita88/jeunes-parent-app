import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isSearching = false

    // Exemple de données fixes pour la recherche
    let fixedData = [
        "Vaccination : 3 à venir",
        "Progrès moteurs : Capacité à courir, sauter sur place, monter des escaliers avec assistance",
        "Rendez-vous Médical : 15 Avril",
        "Langage : Utilisation de phrases simples de 2 à 3 mots",
        "Interaction sociale : Jeux avec d'autres enfants, début de reconnaissance des émotions",
        "Autonomie : Capacité à manger seul, essayer de s'habiller",
        "Vaccin : BCG prévu le 25 novembre",
        "Rendez-vous pédiatre : 3 janvier",
        "Conseils sommeil : Trouver des solutions pour des nuits plus longues"
    ]
    
    // Filtrer les résultats en fonction de la recherche
    var filteredResults: [String] {
        if searchText.isEmpty {
            return fixedData
        } else {
            return fixedData.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            // Barre de recherche
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Rechercher...", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .onTapGesture {
                        isSearching = true
                    }
                if isSearching {
                    Button(action: {
                        searchText = ""
                        isSearching = false
                    }) {
                        Text("Annuler")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 10)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Affichage des résultats de la recherche
            List {
                ForEach(filteredResults, id: \.self) { result in
                    Text(result)
                        .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Recherche")
    }
}

#Preview {
    SearchView()
}
