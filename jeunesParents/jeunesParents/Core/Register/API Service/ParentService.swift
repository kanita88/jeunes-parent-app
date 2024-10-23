import Foundation

class ParentService {
    
    static let shared = ParentService() // Singleton pour accéder facilement au service partout dans l'app
    
    // Fonction pour ajouter un parent via l'API
    func addParent(_ parent: Parent, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/parent") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Utilisation de l'ISO8601 pour encoder les dates
        
        do {
            let jsonData = try encoder.encode(parent)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let responseError = NSError(domain: "InvalidResponse", code: -1, userInfo: nil)
                completion(.failure(responseError))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
}

// Fonction pour récupérer tous les parents
func fetchParents(completion: @escaping (Result<[Parent], Error>) -> Void) {
    
    // URL de l'API pour récupérer la liste des parents
    guard let url = URL(string: "http://127.0.0.1:8080/parent") else {
        completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error)) // Gestion des erreurs réseau
            return
        }
        
        guard let data = data else {
            let noDataError = NSError(domain: "NoData", code: -1, userInfo: nil)
            completion(.failure(noDataError)) // Vérification de la présence des données
            return
        }
        
        // Décoder les données en un tableau de `Parent`
        do {
            let parents = try JSONDecoder().decode([Parent].self, from: data)
            completion(.success(parents)) // Succès, renvoyer les parents
        } catch {
            completion(.failure(error)) // Gestion des erreurs de décodage JSON
        }
    }.resume()
}

// Fonction pour récupérer un parent par son ID
func fetchParent(byID id: UUID, completion: @escaping (Result<Parent, Error>) -> Void) {
    let urlString = "http://127.0.0.1:8080/parent/\(id)" // URL de l'API pour récupérer un parent spécifique
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            let noDataError = NSError(domain: "NoData", code: -1, userInfo: nil)
            completion(.failure(noDataError))
            return
        }
        
        // Décoder les données JSON en objet Parent
        do {
            let parent = try JSONDecoder().decode(Parent.self, from: data)
            completion(.success(parent))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}

// Fonction pour mettre à jour un parent
func updateParent(_ parent: Parent, completion: @escaping (Result<Void, Error>) -> Void) {
    
    // URL de l'API pour la mise à jour des parents
    guard let url = URL(string: "http://127.0.0.1:8080/parent/\(parent.id)") else {
        completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Convertir l'objet Parent en JSON
    do {
        let jsonData = try JSONEncoder().encode(parent)
        request.httpBody = jsonData
    } catch {
        completion(.failure(error))
        return
    }
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let responseError = NSError(domain: "InvalidResponse", code: -1, userInfo: nil)
            completion(.failure(responseError))
            return
        }
        
        completion(.success(())) // Succès de la mise à jour
    }.resume()
}

// Fonction pour supprimer un parent
func deleteParent(byID id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
    let urlString = "http://127.0.0.1:8080/parent/\(id)" // URL de l'API pour la suppression
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let responseError = NSError(domain: "InvalidResponse", code: -1, userInfo: nil)
            completion(.failure(responseError))
            return
        }
        
        completion(.success(())) // Succès de la suppression
    }.resume()
}
