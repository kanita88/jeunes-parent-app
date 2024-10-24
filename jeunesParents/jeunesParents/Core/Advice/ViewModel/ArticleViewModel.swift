//
//  ArticleViewModel.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

func createDate(year: Int, month: Int, day: Int) -> Date {
    let dateComponents = DateComponents(year: year, month: month, day: day)
    return Calendar.current.date(from: dateComponents) ?? Date()
}

class ArticleViewModel : ObservableObject {
    @Published var articles : [Article] = []
    
    private let baseURL = "http://127.0.0.1:8080/article" // URL de base de l'API
    
    // 1. Récupérer les articles (Read)
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
