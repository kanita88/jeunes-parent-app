//
//  TaskAddView.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import SwiftUI

struct TaskAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var taskViewModel: TaskViewModel
    
    @State private var nom: String = ""
    @State private var tache: String = ""
    @State private var completed: Bool = false
    @State private var id_parent: UUID? = nil  // Champ pour l'ID parent
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nom de la tâche")) {
                    TextField("Nom", text: $nom)
                }
                Section(header: Text("Description de la tâche")) {
                    TextField("Description", text: $tache)
                }
//                Section(header: Text("Statut")) {
//                    Toggle(isOn: $completed) {
//                        Text("Tâche complétée")
//                    }
//                }
//                Section(header: Text("ID Parent")) {
//                    TextField("ID Parent", text: Binding(
//                        get: { id_parent?.uuidString ?? "" },
//                        set: { id_parent = UUID(uuidString: $0) }
//                    ))
//                }
            }
            .navigationTitle("Ajouter une Tâche")
            .navigationBarItems(
                leading: Button("Annuler") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Ajouter") {
                    if !nom.isEmpty && !tache.isEmpty {
                        taskViewModel.addTask(nom: nom, tache: tache, completed: completed, id_parent: id_parent)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

#Preview {
    TaskAddView(taskViewModel: TaskViewModel())
}
