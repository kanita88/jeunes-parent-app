//
//  Task.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 18/10/2024.
//

import Foundation

// Modèle pour une tâche
struct Task: Identifiable, Codable {
    var id: UUID?
    var nom: String
    var tache: String
    var completed: Bool
    var id_parent: UUID?
}

extension Task {
    static var Model_Task = Task(nom: "", tache: "", completed: Bool())
}
