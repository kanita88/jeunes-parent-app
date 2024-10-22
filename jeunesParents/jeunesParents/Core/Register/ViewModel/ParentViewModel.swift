//
//  ParentRegisterViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 21/10/2024.
//
import SwiftUI


class ParentViewModel: ObservableObject {
    @Published var parents: [Parent] = []
    
    private let baseURL: String = "http://10.80.55.104:3000/User"
    
    // Récupérer tous les parents du serveur
    func fetchParent() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedUsers = try JSONDecoder().decode([Parent].self,from: data)
                    DispatchQueue.main.async {
                        self.parents = decodedUsers
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
                
            } else if let error = error {
                print("error fetching data: \(error)")
            }
            
        }.resume()
    }
    
    
    // Ajouter un nouveau parent sur le serveur
    func addParent(_ parent: Parent) {
            guard let url = URL(string: baseURL) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                let data = try JSONEncoder().encode(parent)
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
                self.fetchParent()
            }.resume()
        }
    
    // Mettre à jour un parent existant sur le serveur
       func updateParent(_ parent: Parent) {
           guard let url = URL(string: "\(baseURL)/\(parent.id)") else {
               print("URL invalide")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           do {
               let data = try JSONEncoder().encode(parent)
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
               self.fetchParent()  // Rafraîchir la liste après la mise à jour
           }.resume()
       }

       // Supprimer un parent du serveur
       func deleteParent(_ parentId: Int) {
           guard let url = URL(string: "\(baseURL)/\(parentId)") else {
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
               self.fetchParent()  // Rafraîchir la liste après suppression
           }.resume()
       }
    
    
    
}

