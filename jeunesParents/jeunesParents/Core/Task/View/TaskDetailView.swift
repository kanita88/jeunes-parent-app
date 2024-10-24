//
//  TaskDetailView.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 23/10/2024.
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task  // La tâche dont on veut voir les détails

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.nom)
                .font(.largeTitle)
                .bold()

            Text("Description")
                .font(.headline)
            Text(task.tache)
                .font(.body)

//            Text("Nom du parent")
//                .font(.headline)
//            Text(task.id_parent?.uuidString ?? "Aucun parent")
//                .font(.body)

            Text("Statut")
                .font(.headline)
            Text(task.completed ? "Complétée" : "Non complétée")
                .foregroundColor(task.completed ? .green : .red)
                .font(.body)

            Spacer()
        }
        .padding()
        .navigationTitle("Détail de la tâche")
        .navigationBarTitleDisplayMode(.inline)  // Titre de la vue
    }
}

#Preview {
    TaskDetailView(task: Task.Model_Task) // Utilisation de la tâche d'exemple pour le preview
}
