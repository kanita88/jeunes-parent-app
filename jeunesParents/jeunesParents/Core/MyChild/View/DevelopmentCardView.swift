import SwiftUI

struct DevelopmentCardView: View {
    var title: String
    var description: String
    var image: Image? = nil // L'image est optionnelle
    @State private var isFavorite: Bool = false // État pour savoir si la carte est favorite
    
    var body: some View {
        HStack {
            // Si une image est fournie, on l'affiche
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                    .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            // Bouton d'ajout aux favoris
            Button(action: {
                isFavorite.toggle() // Basculer l'état de favori
            }) {
                Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isFavorite ? .primaire : .gray) // Change de couleur si favori
                    .animation(.easeInOut, value: isFavorite) // Animation lors du changement d'état
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}


#Preview {
    DevelopmentCardView(title: "Test", description: "Test")
}
