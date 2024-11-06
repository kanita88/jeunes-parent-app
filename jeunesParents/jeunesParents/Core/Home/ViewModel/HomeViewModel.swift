//
//  HomeViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var prenom: String = "Utilisateur" // prénom de l'utilisateur
    
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
    
    func fetchPrenom(token: String) {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/parent/profile")!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur de réseau : \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                do {
                    let responseDict = try JSONDecoder().decode([String: String].self, from: data)
                    DispatchQueue.main.async {
                        self.prenom = responseDict["prenom"] ?? "Nom inconnu"
                        print("Prénom récupéré : \(self.prenom)")
                    }
                } catch {
                    print("Erreur de décodage : \(error.localizedDescription)")
                }
            } else {
                print("Requête échouée avec le code : \((response as? HTTPURLResponse)?.statusCode ?? -1)")
            }
        }.resume()
    }
}
