//
//  Comment.swift
//  jeunesParents
//
//  Created by Klesya on 23/10/2024.
//

import Foundation

class Comment: Identifiable {
    let id = UUID()
    var content: String
    var username: String
    var publicationDate: Date

    init(content: String, username: String, publicationDate: Date) {
        self.content = content
        self.username = username
        self.publicationDate = publicationDate
    }
}
