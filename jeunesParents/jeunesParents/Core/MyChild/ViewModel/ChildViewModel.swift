import Combine
import UIKit

class ChildViewModel: ObservableObject {
    @Published var enfant: Enfant? = Enfant(
        id: UUID(),
        nom: "Léa",
        genre: "Féminin",
        dateDeNaissance: "2019-07-16",
        terme: true,
        poids: 12.5,
        taille: 90,
        profileImageURL: nil, // Pas d'image pour l'instant
        cartesDeDeveloppement: [] // Pas de cartes de développement pour l'instant
    )
    @Published var profileImage: UIImage? = nil
    @Published var isLoading = false
    @Published var uploadSuccess = false
    @Published var errorMessage: String?
    @Published var parentName: String = "Jean Dupont"
    @Published var developmentCards: [DevelopmentCard] = [
        DevelopmentCard(id: UUID(), title: "Progrès moteurs", description: "Capacité à courir, sauter sur place.", imageUrl: nil, ageRange: 2...4),
        DevelopmentCard(id: UUID(), title: "Langage", description: "Utilisation de phrases simples.", imageUrl: nil, ageRange: 2...3)
    ]
    @Published var childAge: Int = 2
    
    private var cancellables = Set<AnyCancellable>()
    private let childService = ChildService()
    
    // Fonction pour ajouter un enfant
    func addEnfant(_ newEnfant: Enfant) {
        // Vous pouvez ici définir la logique pour ajouter l'enfant.
        // Par exemple, vous pourriez l'envoyer à une API ou simplement l'assigner localement.
        enfant = newEnfant
    }
    
    // Fonction pour récupérer les données de l'enfant via l'API
    func fetchChildData(parentId: UUID) {
        isLoading = true
        errorMessage = nil
        childService.fetchChildData(parentId: parentId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "Échec du chargement : \(error.localizedDescription)"
                    self?.isLoading = false
                case .finished:
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] enfant in
                self?.enfant = enfant
            }
            .store(in: &cancellables)
    }
    
    
    // Fonction pour uploader la photo de profil de l'enfant
    func uploadProfileImage() {
        guard let enfant = enfant, let image = profileImage else {
            errorMessage = "Données manquantes"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        childService.uploadProfileImage(forChildId: enfant.id.uuidString, image: image)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.uploadSuccess = false
                    self?.errorMessage = "Échec de l'upload : \(error.localizedDescription)"
                case .finished:
                    self?.uploadSuccess = true
                    self?.errorMessage = nil
                }
                self?.isLoading = false
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    // Fonction pour récupérer les cartes de développement depuis le service
    func fetchDevelopmentCards() {
        isLoading = true
        errorMessage = nil
        childService.fetchDevelopmentCards()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "Erreur lors de la récupération des cartes : \(error.localizedDescription)"
                case .finished:
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] cards in
                self?.developmentCards = cards
            }
            .store(in: &cancellables)
    }
    
    // Méthode pour récupérer les données de l'enfant et du parent
    func fetchChildAndParentData(parentId: UUID) {
        // Données pré-remplies (statiques)
        self.enfant = Enfant(
            id: UUID(),
            nom: "Léa",
            genre: "Féminin",
            dateDeNaissance: "2019-07-16",
            terme: true,
            poids: 12.5,
            taille: 90,
            profileImageURL: nil,
            cartesDeDeveloppement: []
        )
        self.parentName = "Jean Dupont"
        self.developmentCards = [
            DevelopmentCard(id: UUID(), title: "Progrès moteurs", description: "Capacité à courir, sauter sur place.", imageUrl: nil, ageRange: 2...4),
            DevelopmentCard(id: UUID(), title: "Langage", description: "Utilisation de phrases simples.", imageUrl: nil, ageRange: 2...3)
        ]
    }
    // Fonction pour filtrer les cartes en fonction de l'âge de l'enfant
    func filteredCards() -> [DevelopmentCard] {
        guard enfant != nil else { return [] } // S'assurer que les données de l'enfant existent
        return developmentCards.filter { $0.ageRange.contains(childAge) }
    }
}
