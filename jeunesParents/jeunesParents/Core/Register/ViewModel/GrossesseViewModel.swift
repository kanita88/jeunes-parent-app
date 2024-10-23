//
//  GrossesseViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 21/10/2024.
//

import SwiftUI

class GrossesseViewModel: ObservableObject {
    @Published var grossesses: [Grossesse] = []
    
    private let baseURL: String = "http://127.0.0.1:8080/grossesse"
   
    
    // Récupérer toutes les gorssesses du serveur
    func fetchGrossesse() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedGrossesses = try JSONDecoder().decode([Grossesse].self,from: data)
                    DispatchQueue.main.async {
                        self.grossesses = decodedGrossesses
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
                
            } else if let error = error {
                print("error fetching data: \(error)")
            }
            
        }.resume()
    }
    
    
    // Ajouter une nouvelle grossesse sur le serveur
    func addGrossesse(_ grossesse: Grossesse) {
            guard let url = URL(string: baseURL) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                let data = try JSONEncoder().encode(grossesse)
                request.httpBody = data
            } catch {
                print("Error encoding contact: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error adding contact: \(error)")
                    return
                }
                self.fetchGrossesse()
            }.resume()
        }
    
    
    // Mettre à jour une grossesse existante sur le serveur
       func updateGrossesse(_ grossesse: Grossesse) {
           guard let url = URL(string: "\(baseURL)/\(grossesse.id)") else {
               print("URL invalide")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           do {
               let data = try JSONEncoder().encode(grossesse)
               request.httpBody = data
           } catch {
               print("Erreur lors de l'encodage de l'utilisateur : \(error)")
               return
           }

           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Erreur lors de la mise à jour de l'utilisateur : \(error)")
                   return
               }
               self.fetchGrossesse()  // Rafraîchir la liste après la mise à jour
           }.resume()
       }

    
       // Supprimer une grossesse du serveur
       func deleteGrossesse(_ grossesseId: Int) {
           guard let url = URL(string: "\(baseURL)/\(grossesseId)") else {
               print("URL invalide")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "DELETE"

           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Erreur lors de la suppression de l'utilisateur : \(error)")
                   return
               }
               self.fetchGrossesse()  // Rafraîchir la liste après suppression
           }.resume()
       }
    
    
    
    
    
}

