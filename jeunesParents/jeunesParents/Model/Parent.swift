//
//  Register.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 18/10/2024.
//

import Foundation
import SwiftUI

// Structure pour représenter un parent
struct Parent: Identifiable, Codable {
    var id: UUID = UUID()  // ID généré automatiquement
    var nom: String
    var prenom: String
    var dateDeNaissance: Date?
    var motDePasse: String?
    var premiereExperienceParentale: Bool
    var enCouple: Bool
    var enfants: [Enfant] = []  // Tableau vide par défaut
    
    
    // Fonction pour ajouter un enfant au tableau
    mutating func ajouterEnfant(_ enfant: Enfant) {
        enfants.append(enfant)
    }
    
    // Exemple de méthode pour afficher un résumé du parent
    func description() -> String {
        return "\(nom) \(prenom), \(enCouple ? "en couple" : "célibataire")"
    }
}
