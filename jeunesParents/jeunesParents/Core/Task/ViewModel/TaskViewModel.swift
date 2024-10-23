//
//  TaskViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    private let baseURL = "http://127.0.0.1:8080/task" // URL de base de l'API
    
    // 1. Récupérer les tâches (Read)
    func fetchTasks() {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let tasks = try decoder.decode([Task].self, from: data)
                    DispatchQueue.main.async {
                        self.tasks = tasks // Mise à jour de la liste des tâches
                    }
                } catch {
                    print("Erreur lors du décodage des tâches : \(error.localizedDescription)")
                }
            } else if let error = error {
                print("Erreur réseau : \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // 2. Ajouter une nouvelle tâche (Create)
    func addTask(nom: String, tache: String, completed: Bool, id_parent: UUID?) {
        guard let url = URL(string: baseURL) else {
            print("URL invalide")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Création de la tâche avec l'option d'un parent (si fourni)
        let task = Task(id: nil, nom: nom, tache: tache, completed: completed, id_parent: id_parent)
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(task)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Gestion des erreurs réseau
                if let error = error {
                    print("Erreur réseau : \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    // Vérification du statut HTTP
                    if httpResponse.statusCode == 200 {
                        // Si la tâche est correctement ajoutée (code HTTP 200)
                        if let data = data {
                            let decoder = JSONDecoder()
                            do {
                                let newTask = try decoder.decode(Task.self, from: data)
                                print(newTask)
                                DispatchQueue.main.async {
                                    self.tasks.append(newTask) // Mise à jour de la liste des tâches
                                }
                            } catch {
                                print("Erreur lors du décodage de la tâche : \(error.localizedDescription)")
                            }
                        }
                    } else {
                        // Gestion des autres codes de statut HTTP
                        print("Erreur lors de la création de la tâche. Statut HTTP : \(httpResponse.statusCode)")
                        if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                            print("Réponse de l'API : \(responseBody)")
                        }
                    }
                }
            }.resume()
            fetchTasks()
        } catch {
            print("Erreur d'encodage de la tâche : \(error.localizedDescription)")
        }
    }
    
    // 3. Mettre à jour une tâche (Update)
    func updateTask(_ task: Task) {
        guard let taskID = task.id, let url = URL(string: "\(baseURL)/\(taskID.uuidString)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(task)
            request.httpBody = jsonData
        } catch {
            print("Erreur d'encodage de la tâche : \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur de mise à jour de la tâche : \(error)")
                return
            }
            self.fetchTasks() // Recharger les tâches après la mise à jour
        }.resume()
    }
    
    // 4. Supprimer une tâche (Delete)
    func deleteTask(_ task: Task) {
        guard let taskID = task.id, let url = URL(string: "\(baseURL)/\(taskID.uuidString)") else {
            print("URL invalide ou tâche sans ID")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur lors de la suppression de la tâche : \(error)")
                return
            }
            
            // Mise à jour de la liste des tâches après la suppression
            DispatchQueue.main.async {
                self.tasks.removeAll { $0.id == task.id }
            }
        }.resume()
    }
}
