import SwiftUI

struct MyChildView: View {
    @ObservedObject var childViewModel: ChildViewModel
    @State private var isImagePickerPresented = false
    @State private var isShowingNotifications = false
    @State private var isShowingSearchView = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Barre supérieure avec l'icône de profil, la cloche et la recherche
                HStack {
                    buildProfileImage() // Affichage de l'image de profil
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
                .padding(.horizontal)

                // Si l'image de profil est sélectionnée, afficher le bouton d'enregistrement
                if childViewModel.profileImage != nil {
                    Button(action: {
                        childViewModel.uploadProfileImage()
                    }) {
                        Text("Enregistrer la photo")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }

                // Indicateur de chargement pendant l'upload
                if childViewModel.isLoading {
                    ProgressView("Envoi en cours...")
                        .padding()
                }

                // Message de bienvenue dynamique
                Text("Bienvenue, \(childViewModel.enfant?.nom ?? "Enfant") !")
                    .bold()
                    .font(.system(size: 30))
                    .padding(.top, 10)

                // Afficher l'âge de l'enfant si disponible
                if let age = childViewModel.enfant?.age {
                    Text("Âge : \(age)")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }

                // Affichage du profil de l'enfant
                ChildProfileView(childViewModel: childViewModel)

                // Carrousel de dates et graphique de croissance
                DateCarouselAndChartView()

                // Section des cartes de développement
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(childViewModel.developmentCards) { card in
                            DevelopmentCardView(title: card.title, description: card.description)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $childViewModel.profileImage, isPresented: $isImagePickerPresented)
        }
        .onAppear {
            // Pas besoin d'appeler une API ici, les données sont statiques
        }
        .sheet(isPresented: $isShowingNotifications) {
            NotificationsView()
        }
        .sheet(isPresented: $isShowingSearchView) {
            SearchView()
        }
    }

    // Fonction pour gérer l'affichage de l'image de profil
    @ViewBuilder
    private func buildProfileImage() -> some View {
        if let profileImage = childViewModel.profileImage {
            Image(uiImage: profileImage)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .onTapGesture {
                    isImagePickerPresented = true
                }
        } else {
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
