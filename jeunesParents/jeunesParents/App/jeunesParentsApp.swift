//
//  jeunesParentsApp.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 09/10/2024.
//

import SwiftUI

@main
struct jeunesParentsApp: App {
    // Crée une instance d'AuthentificationViewModel pour l'utiliser globalement
        @StateObject private var authViewModel = AuthentificationViewModel()

    var body: some Scene {
        WindowGroup {
           ContentView()
                .environmentObject(authViewModel)
        }
    }
}
