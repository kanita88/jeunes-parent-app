//
//  HomeViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import Foundation

    class HomeViewModel: ObservableObject {
        
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
    
    // Récupérer les articles (Read)
        @Published var articles: [Article] = []
        
        private let baseURL = "http://127.0.0.1:8080/article" // URL de base de l'API
        
        // Récupérer les articles (Read)
        func fetchArticles() {
            guard let url = URL(string: baseURL) else {
                print("URL invalide")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Erreur réseau : \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("Aucune donnée reçue")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode([Article].self, from: data)
                    DispatchQueue.main.async {
                        self.articles = articles // Mettre à jour la liste des articles
                    }
                } catch {
                    print("Erreur lors du décodage des articles : \(error.localizedDescription)")
                }
            }.resume()
        }
    }
