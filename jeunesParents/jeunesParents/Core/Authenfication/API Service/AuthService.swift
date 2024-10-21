//
//  AuthService.swift
//  jeunesParents
//
//  Created by Apprenant 154 on 18/10/2024.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Code pour appeler l'API d'authentification
        let loginEndpoint = "http://127.0.0.1:8080/parent"
        var request = URLRequest(url: URL(string: loginEndpoint)!)
        request.httpMethod = "POST"
        let parameters = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        // Effectuer la requête réseau
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            }
        }.resume()
    }
}

// Get All
//GET : http://localhost:3000/contacts

// Get 1 contact with id=3
//GET : http://localhost:3000/contacts/3

// Insert Contact (request.httpBody)
//POST : http://localhost:3000/contacts

// Uptade Contact with id=5 with :  (request.httpBody)
//PUT : http://localhost:3000/contacts/5

// Remove contact with id=9
//DELETE : http://localhost:3000/contacts/9

