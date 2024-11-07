//
//  HomeViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var prenom: String = "" // prénom de l'utilisateur
    
    @Published var selectSmile: Int? = nil
    
    // Exécuter une action lors de la sélection d'un émoji
    func moodSelected(index: Int) {
        selectSmile = index
    }
    
    // Retourner l'emoji correspondant à chaque index
    func emojiText(index: Int) -> String {
        switch index {
        case 0: return "😀" // Heureux
        case 1: return "🙂" // Neutre
        case 2: return "😟" // Triste
        case 3: return "😭" // Très triste
        default: return "🙂"
        }
    }
    
    private let baseURL = "http://127.0.0.1:8080/parents/profile"

    func fetchPrenom(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "URL Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = KeyChainManager.get() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(NSError(domain: "Auth Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token introuvable"])))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Aucune donnée reçue"])))
                return
            }
            
            // Affiche la réponse JSON brute
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Réponse JSON brute : \(jsonString)")
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let prenom = json["prenom"] as? String {
                    completion(.success(prenom))
                } else {
                    completion(.failure(NSError(domain: "Parse Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Format JSON invalide"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
