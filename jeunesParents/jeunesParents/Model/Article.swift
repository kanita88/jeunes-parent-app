//
//  Article.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

class Article : Identifiable, Codable {
    var id : UUID?
    var title : String
    var description : String
    //var comments : [Comment]
    //var publicationDate : String
    var readTime : Int?
    var imageURL : String?
    var category : String?
    var content : String?
}
