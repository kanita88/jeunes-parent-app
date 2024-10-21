//
//  EnfantViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 21/10/2024.
//

import SwiftUI

class EnfantViewModel: ObservableObject {
    @Published var enfants: [Enfant] = []
    
    private let baseURL: String = "http://10.80.55.104:3000/User"
    
    
    // Récupérer tout les enfants du serveur
    func fetchEnfant() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedUsers = try JSONDecoder().decode([Enfant].self,from: data)
                    DispatchQueue.main.async {
                        self.enfants = decodedUsers
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
                
            } else if let error = error {
                print("error fetching data: \(error)")
            }
            
        }.resume()
    }
    
    
    // Ajouter une nouveau enfant sur le serveur
    func addEnfant(_ enfant: Enfant) {
            guard let url = URL(string: baseURL) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                let data = try JSONEncoder().encode(enfant)
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
                self.fetchEnfant()
            }.resume()
        }
    
   
    // Mettre à jour un enfant existante sur le serveur
    func updateEnfant(_ enfant: Enfant) {
           guard let url = URL(string: "\(baseURL)/\(enfant.id)") else {
               print("URL invalide")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           do {
               let data = try JSONEncoder().encode(enfant)
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
               self.fetchEnfant()  // Rafraîchir la liste après la mise à jour
           }.resume()
       }

    
       // Supprimer un enfant du serveur
       func deleteEnfant(_ enfantId: Int) {
           guard let url = URL(string: "\(baseURL)/\(enfantId)") else {
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
               self.fetchEnfant()  // Rafraîchir la liste après suppression
           }.resume()
       }
    
    
    
    
    
}

