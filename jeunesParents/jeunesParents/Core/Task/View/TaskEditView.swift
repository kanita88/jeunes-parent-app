//
//  TaskEditView.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 23/10/2024.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel

    @State var task: Task  // La tâche à éditer

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nom de la tâche")) {
                    TextField("Nom", text: $task.nom)
                }
                Section(header: Text("Description de la tâche")) {
                    TextField("Description", text: $task.tache)
                }
                Section(header: Text("Statut")) {
                    Toggle(isOn: $task.completed) {
                        Text("Tâche complétée")
                    }
                }
            }
            .navigationTitle("Éditer la Tâche")
            .navigationBarItems(
                leading: Button("Annuler") {
                    // Fermer la vue sans modifier
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Sauvegarder") {
                    // Sauvegarder les modifications
                    taskViewModel.updateTask(task)
                    
                    // Fermer la vue après mise à jour
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    TaskEditView(taskViewModel: TaskViewModel(), task: Task.Model_Task)
}
