//
//  Article.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 23/10/2024.
//

import Foundation

//Modèle article
struct Article: Identifiable, Decodable {
    var id = UUID()
    let title: String
    let description: String
    let imageURL: String
}

