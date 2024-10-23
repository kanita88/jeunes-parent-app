//
//  GrossesseRegister.swift
//  jeunesParents
//
//  Created by Apprenant 142 on 18/10/2024.
//

import Foundation
import SwiftUI

struct Grossesse: Identifiable, Codable {
    var id: UUID
    var dateMenstruation: String
    var dateConception: String
    var dateAccouchement: String
    var grossesseMultiple: Bool
    var modeAccouchement: String
    var conditionsMedicales: String
    
}
