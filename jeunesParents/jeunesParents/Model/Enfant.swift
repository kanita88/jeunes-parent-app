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
    var dateDeNaissance: String
    var terme: Bool
    var alimentation: String
    var poids: Double
    var taille: Int
   
    
}
