//
//  MyChildView.swift
//  jeunesParents
//
//  Created by Apprenant 154 on 21/10/2024.
//

import SwiftUI
import Charts

struct MyChildView: View {
    // État pour la navigation vers la vue de recherche
    @State private var isShowingSearchView = false
    //    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Image(systemName: "person.circle")
                    Spacer()
                    Button(action: {
                        isShowingSearchView = true  // Déclencher la navigation
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundStyle(Color.primaire)
                    Image(systemName: "bell")
                }
                .foregroundStyle(Color.primaire)
                .font(.system(size: 30))
                .padding()
                //                HStack {
                //                    if let parent = authViewModel.parent,
                //                       let firstChild = parent.enfants.first {
                //                        // Afficher dynamiquement le nom de l'enfant
                //                        Text("Bienvenue \(firstChild.nom) !")
                //                            .font(.system(size: 40)).bold()
                //                    }
                Spacer()
            }
            .padding()
            
            DateCarouselAndChartView()
            
            // NavigationLink déclenché par l'état isShowingSearchView
            NavigationLink(destination: SearchView(), isActive: $isShowingSearchView) {
                EmptyView()
                
                HStack {
                    //                    if let firstChild = authViewModel.parent?.enfants.first {
                    ////                        // Afficher dynamiquement l'âge de l'enfant
                    //                        Text("Développement à \(firstChild.age) ans")
                    //                            .font(.system(size: 20)).bold()
                    //                    }
                    RoundedRectangle(cornerRadius: 10)
                        .shadow(radius: 5)
                    RoundedRectangle(cornerRadius: 10)
                        .shadow(radius: 5)
                }
                .foregroundStyle(.white)
                .padding()
                
                VStack {
                    HStack {
                        //Mettre l'âge en dynamique selon l'enfant séléctionner qui se connecte
                        Text("Développement à 2 ans")
                            .font(.system(size: 20)).bold()
                        Spacer()
                    }
                    .padding()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .shadow(radius: 5)
                            .foregroundStyle(.white)
                        HStack {
                            Image("EngineChild")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                Text("Progrès moteurs")
                                    .font(.title3).bold()
                                Spacer()
                                Text("Capacité à courir, sauter sur place, monter des escaliers avec assistance.")
                            }
                            .padding()
                            Image(systemName: "bookmark")
                                .font(.system(size: 30))
                        }
                        .padding()
                    }
                    .padding()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .shadow(radius: 5)
                            .foregroundStyle(.white)
                        HStack {
                            Image("EngineChild")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                Text("Progrès moteurs")
                                    .font(.title3).bold()
                                Spacer()
                                Text("Capacité à courir, sauter sur place, monter des escaliers avec assistance.")
                            }
                            .padding()
                            Image(systemName: "bookmark")
                                .font(.system(size: 30))
                        }
                        .padding()
                    }
                    .padding()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .shadow(radius: 5)
                            .foregroundStyle(.white)
                        HStack {
                            Image("EngineChild")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading) {
                                Text("Progrès moteurs")
                                    .font(.title3).bold()
                                Spacer()
                                Text("Capacité à courir, sauter sur place, monter des escaliers avec assistance.")
                            }
                            .padding()
                            Image(systemName: "bookmark")
                                .font(.system(size: 30))
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }
}

// Exemple de SearchView pour la recherche
struct SearchView: View {
    var body: some View {
        Text("Recherche...")
            .font(.largeTitle)
    }
}

#Preview {
    MyChildView()
}
