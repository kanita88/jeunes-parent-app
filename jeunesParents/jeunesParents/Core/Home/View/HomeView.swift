//
//  HomeView.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 18/10/2024.
//


import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @ObservedObject var taskviewModel = TaskViewModel()
    @State private var selectedTab: Tab = .myday
    @ObservedObject var taskViewModel = TaskViewModel()
    @State private var showingAddTaskView = false
    @State private var selectedTask: Task?
    @State private var showEditTaskSheet = false
    @State private var showingTaskDetailView = false
    @State private var showingArticleDetail = false
    
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                Text("Bonjour!")
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "bell")
                    .resizable()
                    .frame(width:20, height: 20)
                    .padding(.trailing)
            }
            .padding()
            //
            Text("Comment allez-vous aujourd'hui?")
                .font(.headline)
            HStack(spacing: 30) {
                ForEach(0..<4) { index in
                    Button(action: {
                        viewModel.moodSelected(index: index)
                    }) {
                        Text(viewModel.emojiText(index: index))
                            .font(.largeTitle)
                            .padding()
                    }
                    .background( viewModel.selectSmile == index ? Color.pink.opacity(0.1) : Color.clear)
                    .cornerRadius(30)
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(25)
            .shadow(radius: 5)
            
            
            if let smile = viewModel.selectSmile {
                Text("Votre humeur du jour : \(viewModel.emojiText(index: smile))")
                    .font(.headline)
                    .padding()
            } else {
                Text("Sélectionnez un émoji pour exprimer votre humeur!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            //Ajouter une tâche
            VStack(alignment: .leading) {
                HStack {
                    Text("Ma journée")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    // Bouton d'ajout avec l'icône "plus"
                    Button(action: {
                        showingAddTaskView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                
                if taskViewModel.tasks.isEmpty {
                    Text("Aucune tâche ajoutée.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(taskViewModel.tasks) { task in
                            HStack {
                                Text(task.nom)
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    taskViewModel.updateTask(Task(id: task.id, nom: task.nom, tache: task.tache, completed: !task.completed))
                                }) {
                                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.completed ? .green : .gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .padding()
            .sheet(isPresented: $showingAddTaskView) {
                TaskAddView(taskViewModel: taskViewModel)
            }
            .onAppear {
                taskViewModel.fetchTasks() // Charger les tâches lorsque la vue apparaît
            }
            
            // Section des recommandations
            VStack(alignment: .leading) {
                HStack {
                    Text("Recommandation : ")
                        .font(.title2)
                        .bold()
                }
               
            }
            .padding()
            .sheet(isPresented: $showingArticleDetail) {
                // Contenu de la modal (pour le moment juste "Hello")
                Text("Hello")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
    // Suppression via glissement
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = taskViewModel.tasks[index]
            taskViewModel.deleteTask(task) // Suppression de la tâche via le ViewModel
        }
    }
}


#Preview {
    HomeView()
}

