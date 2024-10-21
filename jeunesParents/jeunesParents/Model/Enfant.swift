//
//  EnfantRegister.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 18/10/2024.
//

import Foundation
import SwiftUI

struct Enfant: Identifiable, Codable {
    var id: UUID
    var prenom: String
    var genre: String
    var dateDeNaissance: Date
    var terme: Bool
    var poinds: Double
    var taille: Int
    
}
