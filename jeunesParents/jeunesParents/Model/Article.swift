//
//  Article.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

class Article : Identifiable {
    let id = UUID()
    var title : String
    var description : String
    var comments : [Comment]
    var publicationDate : Date
    var readTime : Int
    var imageURL : String
    var category : String
    var content : String
    
    init(title: String, description: String, comments: [Comment], publicationDate: Date, readTime: Int, imageURL: String, category: String, content: String) {
        self.title = title
        self.description = description
        self.comments = comments
        self.publicationDate = publicationDate
        self.readTime = readTime
        self.imageURL = imageURL
        self.category = category
        self.content = content
    }
}
