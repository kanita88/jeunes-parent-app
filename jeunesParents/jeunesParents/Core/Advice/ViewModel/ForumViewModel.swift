//
//  ForumViewModel.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

class ForumViewModel : ObservableObject {
    @Published var forums: [Forum] = []
    
    init() {
        self.forums = [
            Forum(title: "Conseils pour l'allaitement",
                  theme: "Alimentation",
                  publicationDate: Date(),
                  description: "Des idées pour surmonter les difficultés liées à l'allaitement.",
                  comment: ["Essayez différentes positions", "Consultez une consultante en lactation"],
                  resolu: false),
            
            Forum(title: "Gérer les crises de colère chez les enfants",
                  theme: "Comportement",
                  publicationDate: Date(),
                  description: "Discussions autour des techniques pour calmer les crises de colère.",
                  comment: ["Prendre du recul", "Parler calmement", "Créer une routine"],
                  resolu: true),
            
            Forum(title: "Sommeil des bébés",
                  theme: "Sommeil",
                  publicationDate: Date(),
                  description: "Comment améliorer les nuits agitées des nourrissons ?",
                  comment: ["Utiliser une veilleuse", "Routine de coucher stricte"],
                  resolu: false),
            
            Forum(title: "Concilier travail et parentalité",
                  theme: "Organisation familiale",
                  publicationDate: Date(),
                  description: "Astuces pour équilibrer travail et vie de famille.",
                  comment: ["Établir un emploi du temps", "Prioriser les moments familiaux"],
                  resolu: true),
            
            Forum(title: "Choisir une garde d'enfant",
                  theme: "Modes de garde",
                  publicationDate: Date(),
                  description: "Comparaison entre crèches, assistantes maternelles et autres modes de garde.",
                  comment: ["Proximité et flexibilité", "Rencontrer plusieurs candidats"],
                  resolu: false),
            
            Forum(title: "Encourager les premiers pas de bébé",
                  theme: "Développement de l'enfant",
                  publicationDate: Date(),
                  description: "Des conseils pour aider bébé à marcher.",
                  comment: ["Laissez-le explorer", "Offrir du soutien mais sans forcer"],
                  resolu: true),
            
            Forum(title: "Alimentation équilibrée pour les enfants",
                  theme: "Nutrition",
                  publicationDate: Date(),
                  description: "Comment introduire des repas équilibrés et gérer les refus alimentaires.",
                  comment: ["Introduire petit à petit", "Rendre les repas amusants"],
                  resolu: false),
            
            Forum(title: "Gérer la rivalité entre frères et sœurs",
                  theme: "Fratrie",
                  publicationDate: Date(),
                  description: "Conseils pour réduire les tensions entre enfants.",
                  comment: ["Passer du temps seul avec chaque enfant", "Encourager la coopération"],
                  resolu: true),
            
            Forum(title: "Préparer l'aîné à l'arrivée d'un bébé",
                  theme: "Transition familiale",
                  publicationDate: Date(),
                  description: "Comment impliquer l'aîné dans la préparation pour un nouveau membre de la famille.",
                  comment: ["Impliquer l'aîné dans les préparatifs", "Expliquer les changements à venir"],
                  resolu: false),
            
            Forum(title: "Faire aimer les légumes aux enfants",
                  theme: "Nutrition",
                  publicationDate: Date(),
                  description: "Techniques pour encourager les enfants à manger des légumes.",
                  comment: ["Cacher les légumes dans des plats", "Les impliquer dans la préparation"],
                  resolu: true)
        ]
    }
}
