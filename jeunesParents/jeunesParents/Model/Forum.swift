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
    var comments : [Comment]
    var resolu : Bool
    var category : String
    
    init(title: String, theme: String, publicationDate: Date, description: String, comments: [Comment], resolu: Bool, category: String) {
        self.title = title
        self.theme = theme
        self.publicationDate = publicationDate
        self.description = description
        self.comments = comments
        self.resolu = resolu
        self.category = category
    }
}
