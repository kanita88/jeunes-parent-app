import Foundation


class AuthService {
    static let shared = AuthService()

    @Published var isAuthenticated: Bool = false  // L'état d'authentification devrait être initialisé à false

    // URL de base centralisée pour plus de flexibilité
    private let baseURL = "http://127.0.0.1:8080"
    
    private init() {}

    // Fonction de connexion avec un email et un mot de passe
    func login(email: String, password: String, completion: @escaping (Result<JWToken, Error>) -> Void) {
        
        // Construction de l'URL
        guard let url = URL(string: "\(baseURL)/parents/login") else {
            let error = NSError(domain: "AuthError", code: -2, userInfo: [NSLocalizedDescriptionKey: "URL invalide"])
            completion(.failure(error))
            return
        }

        // Préparation de la requête
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encodage de l'email et mot de passe pour l'Authorization Header
        let authData = (email + ":" + password).data(using: .utf8)?.base64EncodedString()
        guard let authString = authData else {
            let error = NSError(domain: "AuthError", code: -3, userInfo: [NSLocalizedDescriptionKey: "Échec de l'encodage des identifiants"])
            completion(.failure(error))
            return
        }
        
        request.addValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        
        // Exécution de la requête réseau
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Vérification de la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                let error = NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Réponse du serveur invalide"])
                if let errorData = data, let errorMessage = String(data: errorData, encoding: .utf8) {
                    print("Détails de l'erreur serveur : \(errorMessage)")
                }
                completion(.failure(error))
                return
            }
            
            // Traitement de la réponse et récupération du token
            guard let data = data else {
                let error = NSError(domain: "AuthError", code: -4, userInfo: [NSLocalizedDescriptionKey: "Aucune donnée reçue"])
                completion(.failure(error))
                return
            }
            
            do {
                // Décodage du token JWT
                let token = try JSONDecoder().decode(JWToken.self, from: data)
                // Sauvegarde du token dans le Keychain
                KeyChainManager.save(token: token.token) // Assurez-vous que cette fonction existe et fonctionne correctement
                self.isAuthenticated = true // Met à jour l'état d'authentification
                completion(.success(token)) // Retourne le token au succès
            } catch {
                completion(.failure(error)) // Retourne l'erreur si le décodage échoue
            }
        }.resume() // Lancement de la requête
    }
}
