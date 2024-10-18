//
//  Parent.swift
//  jeunesParents
//
//  Created by Apprenant 154 on 18/10/2024.
//

import Foundation

struct Parent: Identifiable, Codable {
    let id: UUID
    let fullName: String?
    let birthDate: Date
    let email: String
    let token: String
    let firstExperience: Bool
    let numbersOfChildren: Int
    let avatarURL: String?
    //    let children: [Child]
}
