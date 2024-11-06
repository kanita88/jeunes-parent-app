import Foundation

class AuthService {
    static let shared = AuthService()
    @Published var isAuthenticated: Bool = true  // État d'authentification
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<JWToken, Error>) -> Void) {
        let url = URL(string: "http://127.0.0.1:8080/parents/login")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let data = data else {
                let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid server response"])
                completion(.failure(error))
                return
            }
            
            do {
                let token = try JSONDecoder().decode(JWToken.self, from: data)
                KeyChainManager.save(token: token.token)
                completion(.success(token))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
