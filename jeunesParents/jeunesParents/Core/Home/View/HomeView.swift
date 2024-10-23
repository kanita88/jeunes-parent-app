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
    
    
    let articles: [Article] = [
        Article(title: "Conseils pour le sommeil des bébés", description: "Découvrez des astuces pour aider votre bébé à mieux dormir.", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqk4dN-wIWibqC2KpmCRKpOWTyxE_MKIY7OA&s"),
        Article(title: "Alimentation des nouveaux-nés", description: "Les meilleures pratiques pour nourrir votre nouveau-né.", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-V7yb02uKAjYWOGAxi4aQLqc-QevvihbXWw&s"),
        Article(title: "Les indispensables pour jeunes parents", description: "Les objets à avoir absolument pour bien commencer avec votre bébé.", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS39QMDS5LiHLKXqq4O-MhINUTidw0FF3GvqQ&s"),
        Article(title: "Comment gérer les pleurs de bébé", description: "Comprendre et calmer les pleurs de votre bébé.", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtko33YgIMB86-QRtBos8KGLmyxniY-fTpeg&s"),
        Article(title: "Activités à faire avec votre enfant", description: "Idées d'activités amusantes pour renforcer les liens avec votre enfant.", imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMP6IaSdTrWlAtqjrh6j-Xy8arYiTnByUdhg&s")
    ]
    
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
                VStack {
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
                .toolbar (content:{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Ma journée : ")
                            .font(.title2)
                            .bold()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddTaskView = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                })
                .sheet(isPresented: $showingAddTaskView) {
                    TaskAddView(taskViewModel: taskViewModel)
                }
                .onAppear {
                    taskViewModel.fetchTasks() // Charger les tâches lorsque la vue apparaît
                }
            
            Divider()
                .frame(height: 4)
                .overlay(.blue)
                .padding()
            // Section des recommandations
            
                List(articles) { article in
                    HStack {
                        AsyncImage(url: URL(string: article.imageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
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
                        
                        // Bouton pour ouvrir la modal avec un simple message "Hello"
                        Button(action: {
                            showingArticleDetail = true // Ouvrir la feuille modale
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Recommandation : ")
                            .font(.title2)
                            .bold()
                    }
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
    HomeView()
}

