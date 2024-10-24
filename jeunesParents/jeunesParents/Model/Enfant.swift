import Foundation
import SwiftUI

struct Enfant: Identifiable, Codable {
    let id: UUID
    var nom: String
    var genre: String
    var dateDeNaissance: String
    var terme: Bool
    var poids: Double
    var taille: Int
    var profileImageURL: String? // URL de l'image de profil
    var cartesDeDeveloppement: [String] // Par exemple, une liste de cartes de développement

    // Calcul de l'âge à partir de la date de naissance
    var age: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Assurez-vous que votre date de naissance suit ce format
        if let birthDate = formatter.date(from: dateDeNaissance) {
            let ageComponents = Calendar.current.dateComponents([.year, .month], from: birthDate, to: Date())
            let years = ageComponents.year ?? 0
            let months = ageComponents.month ?? 0
            return "\(years) ans et \(months) mois"
        }
        return "Âge inconnu" // Retourne une valeur par défaut en cas d'erreur
    }
}

struct DevelopmentCard: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let imageUrl: String? // L'URL de l'image (facultatif)
    let ageRange: ClosedRange<Int> // Tranche d'âge pour laquelle la carte est applicable
}
