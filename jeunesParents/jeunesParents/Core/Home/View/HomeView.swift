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
    
    var body: some View {
        VStack {
            //profil et notification
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
            
            // affiche l'emoji sélectionné ou un message par défaut
            if let smile = viewModel.selectSmile {
                Text("Votre humeur du jour : \(viewModel.emojiText(index: smile))")
                    .font(.headline)
                    .padding()
            } else {
                Text("Sélectionnez un émoji pour exprimer votre humeur!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Ma journée : ")
                    .font(.headline)
                Spacer()
                Button (action: {
                    //
                }) {
                    Image(systemName: "pencil.tip.crop.circle.badge.plus")
                        .resizable()
                        .frame(width:20, height: 20)
                        .padding(.trailing)
                    Text("Ajouter")
                }
                
            }.padding()
            
        }
        VStack {
            NavigationView {
                List(taskviewModel.tasks) { task in
                    HStack {
                        Text(task.nom)
                        Spacer()
                        Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.completed ? .green : .red)
                    }
                }
                .onAppear{
                    taskviewModel.fetchTasks()
                }
            }
        }
            // Section des recommandations
        HStack() {
            Text("Recommandation :")
                .font(.headline)
            
            Spacer()
        }
    }
}


#Preview {
    HomeView()
}
