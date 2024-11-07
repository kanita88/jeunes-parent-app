import Foundation

class ParentService {
    
    // Fonction pour enregistrer un parent dans la base de données ou API
    static func saveParentToDatabase(parent: Parent, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/parent") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(parent)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                    return
                }
                
                completion(.success(()))
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
}
