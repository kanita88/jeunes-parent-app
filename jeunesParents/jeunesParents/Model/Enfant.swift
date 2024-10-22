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
    let age: Int
    var genre: String
    var dateDeNaissance: Date
    var terme: Bool
    var poids: Double
    var taille: Int
    var profileImageURL: String? // URL de l'image de profil
    
}
