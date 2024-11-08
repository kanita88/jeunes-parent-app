import Foundation

class ParentService {
    static func saveParentToDatabase(parent: Parent, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/parents") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(parent)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON envoyé : \(jsonString)")  // Vérifiez la sortie ici
            }
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }
}
