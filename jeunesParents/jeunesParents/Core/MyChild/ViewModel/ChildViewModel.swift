import Foundation
import UIKit

class ChildViewModel: ObservableObject {
    @Published var enfant: Enfant?
    @Published var profileImage: UIImage?
    @Published var isLoading = false
    @Published var uploadSuccess = false
    @Published var errorMessage: String?

    // Fonction pour récupérer les données de l'enfant via l'API
    func fetchChildData(parentId: UUID) {
        // Réinitialiser les états précédents
        isLoading = true
        errorMessage = nil
        uploadSuccess = false
        
        ChildService.shared.fetchChildData(parentId: parentId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let enfant):
                    self?.enfant = enfant
                    self?.errorMessage = nil  // Réinitialiser le message d'erreur
                case .failure(let error):
                    self?.errorMessage = "Échec du chargement : \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Fonction pour uploader la photo de profil de l'enfant
    func uploadProfileImage() {
        // Validation des données avant l'upload
        guard let enfant = enfant, let image = profileImage else {
            errorMessage = "Données manquantes"
            return
        }

        // Réinitialiser les états précédents
        isLoading = true
        errorMessage = nil
        uploadSuccess = false
        
        ChildService.shared.uploadProfileImage(forChildId: enfant.id.uuidString, image: image) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.uploadSuccess = true
                    self?.errorMessage = nil  // Réinitialiser le message d'erreur
                case .failure(let error):
                    self?.uploadSuccess = false
                    self?.errorMessage = "Échec de l'upload : \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Fonction pour réinitialiser l'état du succès d'upload après affichage d'un feedback
    func resetUploadState() {
        uploadSuccess = false
    }
}
