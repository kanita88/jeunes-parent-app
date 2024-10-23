//
//  EnfantRegister.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 18/10/2024.
//

import Foundation
import SwiftUI

struct Enfant: Identifiable, Codable {
    let id: UUID
    let nom: String
    var genre: String
    var dateDeNaissance: String
    var terme: Bool
    var poids: Double
    var taille: Int
    var profileImageURL: String? // URL de l'image de profil
    var cartesDeDeveloppement: [DevelopmentCard]
    
    var age: String {
        // Calcul de l'âge à partir de la date de naissance (simple exemple)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if let birthDate = formatter.date(from: dateDeNaissance) {
            let ageComponents = Calendar.current.dateComponents([.year, .month], from: birthDate, to: Date())
            let years = ageComponents.year ?? 0
            let months = ageComponents.month ?? 0
            return "\(years) ans et \(months) mois"
        }
        return "Inconnu"
    }
    
}

struct DevelopmentCard: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let imageUrl: String?
    let ageRange: ClosedRange<Int>
}
