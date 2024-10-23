//
//  ConditionMedicaleViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 21/10/2024.
//

import SwiftUI

class ConditionsMedicalViewModele: ObservableObject {
    @Published var conditionsMedicaless: [ConditionsMedicales] = []
    
    private let baseURL: String = "http://127.0.0.1:8080/ConditionMedicale"
    
    
    // Récupérer tout les enfants du serveur
    func fetchConditionsMedicales() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedConditionsMedicaless = try JSONDecoder().decode([ConditionsMedicales].self,from: data)
                    DispatchQueue.main.async {
                        self.conditionsMedicaless = decodedConditionsMedicaless
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
    func addConditionsMeddicales(_ conditionsMedicales: ConditionsMedicales) {
            guard let url = URL(string: baseURL) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                let data = try JSONEncoder().encode(conditionsMedicales)
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
                self.fetchConditionsMedicales()
            }.resume()
        }
    
   
    // Mettre à jour un enfant existante sur le serveur
    func updateConditionsMedicales(_ conditionsMedicales: ConditionsMedicales) {
        guard let url = URL(string: "\(baseURL)/\(conditionsMedicales.id)") else {
               print("URL invalide")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           do {
               let data = try JSONEncoder().encode(conditionsMedicales)
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
               self.fetchConditionsMedicales()  // Rafraîchir la liste après la mise à jour
           }.resume()
       }

    
       // Supprimer un enfant du serveur
       func deleteConditionMedicales(_ conditionMedicalesId: Int) {
           guard let url = URL(string: "\(baseURL)/\(conditionMedicalesId)") else {
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
               self.fetchConditionsMedicales()  // Rafraîchir la liste après suppression
           }.resume()
       }
    
    
    
    
    
}

