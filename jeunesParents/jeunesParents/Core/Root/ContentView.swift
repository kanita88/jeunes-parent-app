////
////  ContentView.swift
////  jeunesParents
////
////  Created by Apprenant 172 on 09/10/2024.
////

import SwiftUI

struct ContentView: View {
    var body: some View {
//        AuthentificationView(authViewModel: AuthentificationViewModel(enfant: nil))
        HomeView(authViewModel: AuthentificationViewModel(enfant: nil))
    }
}
    
#Preview {
    ContentView()
}


