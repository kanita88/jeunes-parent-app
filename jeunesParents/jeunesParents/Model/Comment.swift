//
//  Comment.swift
//  jeunesParents
//
//  Created by Klesya on 23/10/2024.
//

import Foundation

class Comment: Identifiable, Codable {
    let id : UUID?
    var content: String
    var username: String
    var publicationDate: Date
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id)
        self.content = try container.decode(String.self, forKey: .content)
        self.username = try container.decode(String.self, forKey: .username)
        self.publicationDate = try container.decode(Date.self, forKey: .publicationDate)
    }
}
