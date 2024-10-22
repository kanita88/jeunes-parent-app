import Foundation
import UIKit

class ChildViewModel: ObservableObject {
    @Published var enfant: Enfant?
    @Published var profileImage: UIImage?
    @Published var isLoading = false
    @Published var uploadSuccess = false
    @Published var errorMessage: String?

    // Fonction pour récupérer les données de l'enfant via l'API
    func fetchChildData(childId: String) {
        isLoading = true
        ChildService.shared.fetchChildData(forChildId: childId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let enfant):
                    self?.enfant = enfant
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // Fonction pour uploader la photo de profil de l'enfant
    func uploadProfileImage() {
        guard let enfant = enfant, let image = profileImage else {
            errorMessage = "Données manquantes"
            return
        }
        
        isLoading = true
        ChildService.shared.uploadProfileImage(forChildId: enfant.id.uuidString, image: image) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.uploadSuccess = true
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.uploadSuccess = false
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
