//
//  ParentRegisterViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 21/10/2024.
//
import SwiftUI
import Combine


class ParentViewModel: ObservableObject {
    
    // Publie les changements pour réagir dans la vue
    @Published var parents: [Parent] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // Méthode pour ajouter un parent
    func addParent(id: UUID, nom: String, prenom: String, dateDeNaissance: Date, motDePasse: String, motDePasseConfirmation: String, premiereExperienceParentale: Bool, enCouple: Bool) {
        
        
        // Validation des mots de passe
        guard motDePasse == motDePasseConfirmation else {
            self.errorMessage = "Les mots de passe ne correspondent pas."
            return
        }
        
        // Création d'un objet Parent
        let newParent = Parent(
            id: UUID(), // Génération automatique d'un UUID
            nom: nom,
            prenom: prenom,
            dateDeNaissance: dateDeNaissance,
            motDePasse: motDePasse, motDePasseConfirmation: motDePasseConfirmation,
            premiereExperienceParentale: premiereExperienceParentale,
            enCouple: enCouple
        )
        
        // Simuler l'enregistrement des données (via une API ou une base de données locale)
        saveParentToDatabase(parent: newParent) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.parents.append(newParent)  // Ajouter le parent à la liste locale
                case .failure(let error):
                    self?.errorMessage = "Erreur lors de l'enregistrement: \(error.localizedDescription)"
                }
                self?.isLoading = false
            }
        }
    }
    
    // Exemple de fonction pour enregistrer les données dans une base ou une API
    func saveParentToDatabase(parent: Parent, completion: @escaping (Result<Void, Error>) -> Void) {
        // Exemple d'enregistrement dans une API. Vous pouvez adapter selon l'API ou la base de données utilisée.
        
        // Ici, vous pouvez soit envoyer des requêtes HTTP avec `URLSession`, soit utiliser un ORM local comme CoreData
        guard let url = URL(string: "http://127.0.0.1:8080/parent") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(parent)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                    return
                }
                
                completion(.success(()))
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}

