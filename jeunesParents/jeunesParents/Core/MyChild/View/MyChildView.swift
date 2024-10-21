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
    var body: some View {
        NavigationStack {
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
            
            Text("Bienvenue Name !")
                .font(.system(size: 40)).bold()
            
            DateCarouselView()
            
            // NavigationLink déclenché par l'état isShowingSearchView
            NavigationLink(destination: SearchView(), isActive: $isShowingSearchView) {
                EmptyView()
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
