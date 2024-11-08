import Foundation

class ParentService {
    static func saveParentToDatabase(parent: Parent, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/parents/signup") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Ajoutez ici les informations sur l'utilisateur à envoyer
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
            } else if let data = data {
                do {
                    let responseJSON = try JSONDecoder().decode([String: String].self, from: data)
                    if let token = responseJSON["token"] {
                        // Sauvegarder le token d'inscription
                        KeyChainManager.save(token: token)
                        completion(.success(token))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token non trouvé dans la réponse"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
