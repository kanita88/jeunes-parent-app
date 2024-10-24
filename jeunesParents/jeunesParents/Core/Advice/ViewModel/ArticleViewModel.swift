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
    
    // 1. Récupérer les tâches (Read)
    func fetchArticles() {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode([Article].self, from: data)
                    DispatchQueue.main.async {
                        self.articles = articles // Mise à jour de la liste des tâches
                    }
                } catch {
                    print("Erreur lors du décodage des tâches : \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Erreur réseau : \(error.localizedDescription)")
            }
        }.resume()
    }
}
