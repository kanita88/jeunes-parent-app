//
//  HomeView.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 18/10/2024.
//


import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var taskViewModel = TaskViewModel()
    @StateObject var articleViewModel = ArticleViewModel()
    @EnvironmentObject var authViewModel: AuthentificationViewModel // Récupération de l'authViewModel
    @State private var selectedTab: Tab = .myday
    @State private var showingAddTaskView = false
    @State private var showingEditTaskView = false
    @State private var selectedTask: Task?
    @State private var showEditTaskSheet = false
    @State private var showingTaskDetailView = false
    @State private var showingArticleDetail = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                Text("Bonjour, \(viewModel.prenom) !")
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "bell")
                    .font(.system(size: 20))
                Button(action: {
                    authViewModel.logout() // Déconnexion
                    authViewModel.isAuthenticated = false
                }) {
                    Image(systemName: "power").bold()
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchPrenom { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let prenom):
                            viewModel.prenom = prenom  // Mise à jour du prénom dans le viewModel
                            print("Prénom récupéré : \(prenom)")
                        case .failure(let error):
                            print("Erreur : \(error.localizedDescription)")
                        }
                    }
                }
            }
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
                                Image(systemName: "pencil.and.list.clipboard")
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
                            .swipeActions(edge: .leading) {
                                Button {
                                    selectedTask = task  // Sélectionner la tâche à éditer
                                    print("Selected task: \(selectedTask?.nom ?? "None")")
                                    showingTaskDetailView = true  // Afficher la vue détal
                                } label: {
                                    Label("Détail", systemImage: "info.circle")
                                }.tint(.blue)
                            }
                            // Ajouter les actions "Éditer" et "Supprimer" via glissement
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    taskViewModel.deleteTask(task)
                                } label: {
                                    Label("Supprimer", systemImage: "trash")
                                }
                                
                                Button {
                                    selectedTask = task  // Sélectionner la tâche à éditer
                                    print("Selected task: \(task.nom)")
                                    showingEditTaskView = true  // Afficher la vue d'édition
                                } label: {
                                    Label("Éditer", systemImage: "pencil")
                                }
                                .tint(.blue)  // Changer la couleur du bouton "Éditer"
                            }
                        }//.onDelete(perform: deleteTask)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                taskViewModel.fetchTasks() // Charger les tâches lorsque la vue apparaît
            }
            .padding()
            .sheet(isPresented: $showingAddTaskView) {
                TaskAddView(taskViewModel: taskViewModel)
            }
            .sheet(isPresented: $showingEditTaskView) {
                if let selectedTask = selectedTask {
                    TaskEditView(taskViewModel: taskViewModel, task: selectedTask)
                }
            }
            .sheet(isPresented: $showingTaskDetailView) {
                if let selectedTask = selectedTask {
                    TaskDetailView(task: selectedTask)
                }
            }
            
            
            // Section des recommandations
            VStack(alignment: .leading) {
                HStack {
                    Text("Recommandation : ")
                        .font(.title2)
                        .bold()
                }
                List(articleViewModel.articles) { article in
                    HStack {
                        Image(systemName: "list.star")
                        AsyncImage(url: URL(string: article.imageURL ?? "")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Text("Erreur d'image")
                                    .foregroundColor(.red)
                                    .frame(width: 70, height: 70)
                            } else {
                                ProgressView()
                                    .frame(width: 70, height: 70)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(article.title)
                                .font(.headline)
                            Text(article.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showingArticleDetail = true // Ouvrir la feuille modale
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .padding()
            .onAppear {
                articleViewModel.fetchArticles() // Charger les tâches lorsque la vue apparaît
                print("Fetching articles...")
            }
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
        let authViewModel = AuthentificationViewModel()  // Créer une instance pour la preview
        HomeView()
            .environmentObject(authViewModel) // Passe authViewModel à HomeView
}

