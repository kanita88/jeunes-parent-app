import Foundation
import UIKit

class ChildService {
    static let shared = ChildService()
    
    private init() {}
    
    // MARK: - Upload de la photo de profil
    func uploadProfileImage(forChildId childId: String, image: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
        // Endpoint de l'API pour uploader l'image
        guard let url = URL(string: "http://127.0.0.1:8080/enfant/\(childId)/uploadPhoto") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Spécifier que c'est du multipart/form-data
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Convertir l'image en données JPEG
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "InvalidImage", code: -1, userInfo: nil)))
            return
        }
        
        // Créer le corps multipart/form-data
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Assigner le corps de la requête
        request.httpBody = body
        
        // Créer la session pour l'upload
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(true))  // Succès de l'upload
            } else {
                completion(.failure(NSError(domain: "UploadFailed", code: -1, userInfo: nil)))
            }
        }.resume()
    }
    
    // MARK: - Récupération des données d'un enfant
    func fetchChildData(parentId: UUID, completion: @escaping (Result<Enfant, Error>) -> Void) {
        let urlString = "http://127.0.0.1:8080/parent/\(parentId)/child"  // URL de l'API pour récupérer l'enfant
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
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
            
            do {
                let enfant = try JSONDecoder().decode(Enfant.self, from: data)
                completion(.success(enfant))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
