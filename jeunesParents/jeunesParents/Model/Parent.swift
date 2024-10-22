//
//  Register.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 18/10/2024.
//

import Foundation
import SwiftUI

struct Parent: Identifiable, Codable {
    let id: UUID
    let nom: String
    var prenom: String
    var dateDeNaissance: String
    var motDePasse: String
    var motDePasseConfirmation: String
    var premiereExperienceParentale: Bool
    var enCouple: Bool
    let enfants: [Enfant]
    
}
