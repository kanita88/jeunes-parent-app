import Foundation

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
//    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
//        // Endpoint de l'API d'authentification
//        let loginEndpoint = "http://127.0.0.1:8080/parent/login"
//        
//        // Préparation de la requête
//        guard let url = URL(string: loginEndpoint) else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        // Paramètres de la requête (body)
//        let parameters = ["email": email, "password": password]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
//        
//        // Configuration de la session
//        let config = URLSessionConfiguration.default
//        config.timeoutIntervalForRequest = 30 // Timeout si la réponse est trop longue
//        
//        let session = URLSession(configuration: config)
//        
//        // Lancer la requête réseau
//        session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            // Vérification du code de statut HTTP
//            if let httpResponse = response as? HTTPURLResponse {
//                guard (200...299).contains(httpResponse.statusCode) else {
//                    let statusError = NSError(domain: "InvalidResponse", code: httpResponse.statusCode, userInfo: [
//                        NSLocalizedDescriptionKey: "Server returned status code \(httpResponse.statusCode)"
//                    ])
//                    completion(.failure(statusError))
//                    return
//                }
//            }
//            
//            // Vérification de la présence des données
//            guard let data = data else {
//                let dataError = NSError(domain: "NoData", code: -1, userInfo: [
//                    NSLocalizedDescriptionKey: "No data received"
//                ])
//                completion(.failure(dataError))
//                return
//            }
//            
//            // Décodage de la réponse
//            if let responseString = String(data: data, encoding: .utf8) {
//                completion(.success(responseString))
//            } else {
//                let decodeError = NSError(domain: "DecodingError", code: -1, userInfo: [
//                    NSLocalizedDescriptionKey: "Unable to decode response"
//                ])
//                completion(.failure(decodeError))
//            }
//        }.resume()
//    }
    
    func login(email: String, password: String) {
        let url = URL(string: "http://127.0.0.1:8080/parent/login")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let responseHttp = response as? HTTPURLResponse,
                  responseHttp.statusCode == 200, let data = data else {
                print("Error : \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                let token = try JSONDecoder().decode(JWToken.self, from: data)
                print("token : ", token)
                
                KeyChainManager.save(token: token.token)
            } catch {
                print("Error")
            }
            print("Authentification réussie")
            
            
        }
        .resume()
    }
}
