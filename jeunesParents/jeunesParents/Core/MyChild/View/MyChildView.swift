import SwiftUI

struct MyChildView: View {
    @ObservedObject var childViewModel: ChildViewModel
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            // Barre supérieure avec l'icône de profil
            HStack {
                if let profileImage = childViewModel.profileImage {
                    // Si l'image a été sélectionnée, affichez-la
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .onTapGesture {
                            isImagePickerPresented = true
                        }
                } else {
                    // Afficher l'icône par défaut ou la photo de profil existante
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        if let enfant = childViewModel.enfant, let imageURL = enfant.profileImageURL {
                            AsyncImage(url: URL(string: imageURL)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else {
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
                Spacer()
                Image(systemName: "bell")
            }
            .padding()

            // Si l'image a été sélectionnée, permettre l'upload
            if childViewModel.profileImage != nil {
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
            } else if childViewModel.uploadSuccess {
                Text("Image envoyée avec succès !")
                    .foregroundColor(.green)
                    .padding()
            } else if let errorMessage = childViewModel.errorMessage {
                Text("Erreur : \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .sheet(isPresented: $isImagePickerPresented, onDismiss: {
            // Si une image est sélectionnée, elle sera sauvegardée dans le ViewModel
        }) {
            ImagePicker(selectedImage: $childViewModel.profileImage, isPresented: $isImagePickerPresented)
        }
        .onAppear {
            childViewModel.fetchChildData(childId: "12345") // Remplacez par l'ID réel de l'enfant
        }
    }
}

#Preview {
    MyChildView(childViewModel: ChildViewModel())
}
