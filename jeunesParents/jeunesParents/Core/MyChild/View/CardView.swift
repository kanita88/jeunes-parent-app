import SwiftUI

struct CardView: View {
    var title: String
    var value: String
    var subtitle: String
    var iconName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Titre de la carte
            HStack {
                Text(title)
                    .font(.title3) // Taille légèrement plus petite pour une meilleure répartition
                    .lineLimit(2) // Limiter à deux lignes pour éviter les débordements
                    .fixedSize(horizontal: false, vertical: true) // Permet au texte de prendre plusieurs lignes si nécessaire
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray) // Icône avec une couleur discrète
            }
            
            Spacer()
            
            // Valeur et Sous-titre
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(value)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                // Icône
                Image(systemName: iconName)
                    .font(.system(size: 40))
                    .foregroundColor(.blue) // Couleur primaire pour l'icône
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Ombre plus subtile
        .frame(width: 200, height: 150) // Taille de la carte
    }
}

#Preview {
    CardView(title: "Rendez-vous Médical", value: "15", subtitle: "Avril", iconName: "stethoscope")
}
