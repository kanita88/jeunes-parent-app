import SwiftUI

struct MyChildView: View {
    @ObservedObject var childViewModel: ChildViewModel
    @State private var isImagePickerPresented = false
    @State private var isShowingNotifications = false  // État pour la feuille Notifications
    @State private var isShowingSearchView = false     // État pour la feuille Recherche
    
    var body: some View {
        ScrollView {
            VStack {
                // Barre supérieure avec l'icône de profil, la cloche et la recherche
                HStack {
                    buildProfileImage()
                    
                    Spacer()
                    
                    // Icône de recherche
                    Button(action: {
                        isShowingSearchView = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 24))
                    }
                    .padding(.trailing, 10)
                    
                    // Icône de la cloche pour accéder aux notifications
                    Button(action: {
                        isShowingNotifications = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 24))
                    }
                }
                .padding()
                
                // Bouton d'enregistrement de la photo après sélection
                if let _ = childViewModel.profileImage {
                    Button(action: {
                        childViewModel.uploadProfileImage()
                    }) {
                        Text("Enregistrer la photo")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                
                // Indicateur de chargement pendant l'upload
                if childViewModel.isLoading {
                    ProgressView("Envoi en cours...")
                        .padding()
                }
                
                // Message de bienvenue dynamique
                Text("Bienvenue, \(childViewModel.parentName) !")
                    .bold()
                    .font(.system(size: 30))
                    .padding(.top, 10)
                
                // Ajout de la vue ChildProfile si nécessaire
                ChildProfileView(childViewModel: childViewModel)
                
                // Carrousel de dates et graphique de croissance
                DateCarouselAndChartView()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    // Section des cartes
                    HStack(spacing: 16) {
                        // Utilisation de la CardView pour chaque carte
                        CardView(title: "Rendez-vous Médicale", value: "15", subtitle: "Avril", iconName: "stethoscope")
                        CardView(title: "Vaccination", value: "3", subtitle: "A venir", iconName: "stethoscope")
                        CardView(title: "Taille", value: "62", subtitle: "Cm", iconName: "stethoscope")
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        // Feuille pour la sélection d'une image (profile image)
        .sheet(isPresented: $isImagePickerPresented, onDismiss: {
            // Si une image est sélectionnée, elle sera sauvegardée dans le ViewModel
        }) {
            ImagePicker(selectedImage: $childViewModel.profileImage, isPresented: $isImagePickerPresented)
        }
        .onAppear {
            if let parentId = UUID(uuidString: "PARENT_ID_Ici") {
                childViewModel.fetchChildData(parentId: parentId)
            } else {
                print("Erreur : parentId est nil")
            }
        }
        // Feuille pour les notifications
        .sheet(isPresented: $isShowingNotifications) {
            NotificationsView()
        }
        // Feuille pour la recherche
        .sheet(isPresented: $isShowingSearchView) {
            SearchView()
        }
    }
    
    // Fonction pour gérer l'affichage de l'image de profil
    @ViewBuilder
    private func buildProfileImage() -> some View {
        if let profileImage = childViewModel.profileImage {
            // Si l'image a été sélectionnée, l'affiche
            Image(uiImage: profileImage)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .onTapGesture {
                    isImagePickerPresented = true
                }
        } else {
            // Si l'image n'a pas été sélectionnée, affiche l'image par défaut ou l'image existante
            Button(action: {
                isImagePickerPresented = true
            }) {
                if let enfant = childViewModel.enfant, let imageURL = enfant.profileImageURL {
                    AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        @unknown default:
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
    }
}

#Preview {
    MyChildView(childViewModel: ChildViewModel())
}
