//
//  Comment.swift
//  jeunesParents
//
//  Created by Klesya on 23/10/2024.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id : UUID?
    var articleId: UUID?
    var content: String
    var username: String
    var publicationDate: Date
}
