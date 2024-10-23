import SwiftUI

struct CardView: View {
    var title: String
    var value: String
    var subtitle: String
    var iconName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Titre
                Text(title)
                    .font(.title2)
                    .lineLimit(nil) // Autorise plusieurs lignes
                    .fixedSize(horizontal: false, vertical: true) // Empêche le texte de se couper
                    .fontWeight(.semibold)
                Image(systemName: "chevron.right")
            }
            Spacer()
            // Valeur et Sous-titre
            HStack {
                VStack {
                    Text(value)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    Text(subtitle)
                }
                Spacer()
                // Icône
                Image(systemName: iconName)
                    .font(.system(size: 40))
            }
            .foregroundStyle(Color.primaire)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .frame(width: 200, height: 150)
    }
}

#Preview {
    CardView(title: "Rendez-vous Médicale", value: "15", subtitle: "Avril", iconName: "stethoscope")
}
