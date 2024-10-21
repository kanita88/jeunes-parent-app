//
//  Forum.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

class Forum : Identifiable {
    let id = UUID()
    var title : String
    var theme : String
    var publicationDate : Date
    var description : String
    var comment : [String]
    var resolu : Bool
    
    init(title: String, theme: String, publicationDate: Date, description: String, comment: [String], resolu: Bool) {
        self.title = title
        self.theme = theme
        self.publicationDate = publicationDate
        self.description = description
        self.comment = comment
        self.resolu = resolu
    }
}
