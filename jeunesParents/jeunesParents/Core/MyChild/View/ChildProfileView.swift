import SwiftUI

struct ChildProfileView: View {
    @ObservedObject var childViewModel: ChildViewModel

    var body: some View {
        VStack {
            if let enfant = childViewModel.enfant {
                HStack {
                    // Avatar de l'enfant
                    if let imageURL = enfant.profileImageURL {
                        AsyncImage(url: URL(string: imageURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()  // Affiche un spinner pendant le chargement
                                    .frame(width: 50, height: 50)
                                    .background(Circle().fill(Color.gray.opacity(0.2)))
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person.circle")  // Placeholder en cas d'échec
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            @unknown default:
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    } else {
                        Image(systemName: "person.circle")  // Placeholder par défaut
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }

                    // Informations sur l'enfant
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(enfant.nom), \(enfant.age) !")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("née le \(enfant.dateDeNaissance)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()

                    // Bouton d'édition
                    Button(action: {
                        // Action pour modifier les informations de l'enfant
                        print("Modifier les informations de l'enfant")
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.gray)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 2)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1))
                .padding(.horizontal)
            } else if childViewModel.isLoading {
                // Indicateur de chargement
                ProgressView("Chargement des données...")
                    .padding()
            } else if let errorMessage = childViewModel.errorMessage {
                // Gestion des erreurs
                Text("Erreur : \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Aucun enfant trouvé.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .onAppear {
            // Utiliser l'ID réel du parent connecté, ici avec un UUID valide
            if let parentId = UUID(uuidString: "PARENT_ID_Ici") {
                childViewModel.fetchChildData(parentId: parentId)
            } else {
                print("Erreur : ID du parent non valide")
            }
        }
    }
}

#Preview {
    ChildProfileView(childViewModel: ChildViewModel())
}
