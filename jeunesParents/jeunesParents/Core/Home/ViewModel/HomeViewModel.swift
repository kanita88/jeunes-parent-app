//
//  HomeViewModel.swift
//  jeunesParents
//
//  Created by Apprenant 172 on 21/10/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var selectSmile: Int? = nil
    
    // Exécuter une action lors de la sélection d'un émoji
    func moodSelected(index: Int) {
        selectSmile = index
    }
    
    // Retourner l'emoji correspondant à chaque index
    func emojiText(index: Int) -> String {
        switch index {
        case 0: return "😀" // Heureux
        case 1: return "🙂" // Neutre
        case 2: return "😟" // Triste
        case 3: return "😭" // Très triste
        default: return "🙂"
        }
    }
}
