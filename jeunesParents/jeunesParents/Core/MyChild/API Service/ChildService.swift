import Combine
import UIKit

struct ChildAndParentData: Codable {
    let enfant: Enfant
    let parentName: String
}


class ChildService {
    static let shared = ChildService()
    
    func uploadProfileImage(forChildId childId: String, image: UIImage) -> Future<Bool, Error> {
        return Future { promise in
            guard let url = URL(string: "http://127.0.0.1:8080/enfant/\(childId)/uploadPhoto") else {
                promise(.failure(ServiceError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                promise(.failure(ServiceError.invalidImage))
                return
            }
            
            var body = Data()
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    promise(.success(true))
                } else {
                    promise(.failure(ServiceError.uploadFailed))
                }
            }.resume()
        }
    }
    
    // Méthode pour récupérer les cartes de développement depuis l'API
    func fetchDevelopmentCards() -> AnyPublisher<[DevelopmentCard], Error> {
        guard let url = URL(string: "http://127.0.0.1:8080/jalon") else {
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [DevelopmentCard].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    // Méthode pour récupérer les données de l'enfant et du parent
    func fetchChildAndParentData(parentId: UUID) -> AnyPublisher<ChildAndParentData, Error> {
        let urlString = "http://127.0.0.1:8080/parent/\(parentId)/child"
        guard let url = URL(string: urlString) else {
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ChildAndParentData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchChildData(parentId: UUID) -> AnyPublisher<Enfant, Error> {
        let urlString = "http://127.0.0.1:8080/parent/\(parentId)/child"  // URL de l'API pour récupérer l'enfant
        guard let url = URL(string: urlString) else {
            return Fail(error: ServiceError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Enfant.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    // Définir les erreurs de service possibles
    enum ServiceError: Error {
        case invalidURL
        case noData
        case invalidImage
        case uploadFailed
    }
}
