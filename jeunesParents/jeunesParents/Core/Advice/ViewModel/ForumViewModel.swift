//
//  ForumViewModel.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

struct Commentt: Identifiable, Codable {
    var id = UUID()
    var articleId: UUID?
    var content: String
    var username: String
    var publicationDate: Date
}


class ForumViewModel : ObservableObject {
    @Published var forums: [Forum] = []
    
    init() {
        self.forums = [
            Forum(title: "Conseils pour l'allaitement",
                      theme: "Alimentation",
                      publicationDate: createDate(year: 2023, month: 5, day: 12),
                      description: "Des idées pour surmonter les difficultés liées à l'allaitement.",
                      comments: [
                          Commentt(content: "Essayez différentes positions", username: "EmmaDubois", publicationDate: createDate(year: 2023, month: 5, day: 12)),
                          Commentt(content: "Consultez une consultante en lactation", username: "LucasMartin", publicationDate: createDate(year: 2023, month: 5, day: 13)),
                          Commentt(content: "Ne perdez pas espoir !", username: "ClaireMoreau", publicationDate: createDate(year: 2023, month: 5, day: 14))
                      ],
                      resolu: false,
                      category: "Post-Partum"),
                
                Forum(title: "Gérer les crises de colère chez les enfants",
                      theme: "Comportement",
                      publicationDate: createDate(year: 2023, month: 7, day: 23),
                      description: "Discussions autour des techniques pour calmer les crises de colère.",
                      comments: [
                          Commentt(content: "Prendre du recul", username: "SophieRenaud", publicationDate: createDate(year: 2023, month: 7, day: 24)),
                          Commentt(content: "Parler calmement", username: "ThomasLeclerc", publicationDate: createDate(year: 2023, month: 7, day: 25)),
                          Commentt(content: "Créer une routine", username: "ClaraDurand", publicationDate: createDate(year: 2023, month: 7, day: 26)),
                          Commentt(content: "Encourager le dialogue", username: "JulienBenoit", publicationDate: createDate(year: 2023, month: 7, day: 27))
                      ],
                      resolu: true,
                      category: "Enfant"),
                
                Forum(title: "Sommeil des bébés",
                      theme: "Sommeil",
                      publicationDate: createDate(year: 2023, month: 11, day: 12),
                      description: "Comment améliorer les nuits agitées des nourrissons ?",
                      comments: [
                          Commentt(content: "Utiliser une veilleuse", username: "LauraCaron", publicationDate: createDate(year: 2023, month: 11, day: 13)),
                          Commentt(content: "Routine de coucher stricte", username: "JulienBenoit", publicationDate: createDate(year: 2023, month: 11, day: 14))
                      ],
                      resolu: false,
                      category: "Parent"),
                
                Forum(title: "Concilier travail et parentalité",
                      theme: "Organisation familiale",
                      publicationDate: createDate(year: 2023, month: 12, day: 22),
                      description: "Astuces pour équilibrer travail et vie de famille.",
                      comments: [
                          Commentt(content: "Établir un emploi du temps", username: "MathildeLemoine", publicationDate: createDate(year: 2023, month: 12, day: 23)),
                          Commentt(content: "Prioriser les moments familiaux", username: "NicolasLamy", publicationDate: createDate(year: 2023, month: 12, day: 24)),
                          Commentt(content: "Ne pas hésiter à demander de l'aide", username: "AliceMoreau", publicationDate: createDate(year: 2023, month: 12, day: 25))
                      ],
                      resolu: true,
                      category: "Pro"),
                
                Forum(title: "Choisir une garde d'enfant",
                      theme: "Modes de garde",
                      publicationDate: createDate(year: 2024, month: 1, day: 10),
                      description: "Comparaison entre crèches, assistantes maternelles et autres modes de garde.",
                      comments: [
                          Commentt(content: "Proximité et flexibilité", username: "ChloéGarnier", publicationDate: createDate(year: 2024, month: 1, day: 11)),
                          Commentt(content: "Rencontrer plusieurs candidats", username: "PaulineChauvet", publicationDate: createDate(year: 2024, month: 1, day: 12))
                      ],
                      resolu: false,
                      category: "Parent"),
                
                Forum(title: "Encourager les premiers pas de bébé",
                      theme: "Développement de l'enfant",
                      publicationDate: createDate(year: 2024, month: 2, day: 7),
                      description: "Des conseils pour aider bébé à marcher.",
                      comments: [
                          Commentt(content: "Laissez-le explorer", username: "VictorGiraud", publicationDate: createDate(year: 2024, month: 2, day: 8)),
                          Commentt(content: "Offrir du soutien mais sans forcer", username: "AliceMoreau", publicationDate: createDate(year: 2024, month: 2, day: 9)),
                          Commentt(content: "Utiliser des jouets pour l'encourager", username: "GabrielMarchand", publicationDate: createDate(year: 2024, month: 2, day: 10))
                      ],
                      resolu: true,
                      category: "Enfant"),
                
                Forum(title: "Alimentation équilibrée pour les enfants",
                      theme: "Nutrition",
                      publicationDate: createDate(year: 2024, month: 3, day: 14),
                      description: "Comment introduire des repas équilibrés et gérer les refus alimentaires.",
                      comments: [
                          Commentt(content: "Introduire petit à petit", username: "LéaBernard", publicationDate: createDate(year: 2024, month: 3, day: 15)),
                          Commentt(content: "Rendre les repas amusants", username: "ChloéGarnier", publicationDate: createDate(year: 2024, month: 3, day: 16)),
                          Commentt(content: "Essayer des recettes ludiques", username: "ClaireMoreau", publicationDate: createDate(year: 2024, month: 3, day: 17)),
                          Commentt(content: "Impliquer les enfants dans la cuisine", username: "VictorGiraud", publicationDate: createDate(year: 2024, month: 3, day: 18))
                      ],
                      resolu: false,
                      category: "Parent"),
                
                Forum(title: "Gérer la rivalité entre frères et sœurs",
                      theme: "Fratrie",
                      publicationDate: createDate(year: 2024, month: 4, day: 16),
                      description: "Conseils pour réduire les tensions entre enfants.",
                      comments: [
                          Commentt(content: "Passer du temps seul avec chaque enfant", username: "ClaireVasseur", publicationDate: createDate(year: 2024, month: 4, day: 17)),
                          Commentt(content: "Encourager la coopération", username: "AntoineFournier", publicationDate: createDate(year: 2024, month: 4, day: 18)),
                          Commentt(content: "Établir des règles claires", username: "SophieRenaud", publicationDate: createDate(year: 2024, month: 4, day: 19))
                      ],
                      resolu: true,
                      category: "Enfant"),
                
                Forum(title: "Préparer l'aîné à l'arrivée d'un bébé",
                      theme: "Transition familiale",
                      publicationDate: createDate(year: 2024, month: 4, day: 19),
                      description: "Comment impliquer l'aîné dans la préparation pour un nouveau membre de la famille.",
                      comments: [
                          Commentt(content: "Impliquer l'aîné dans les préparatifs", username: "SophieRenaud", publicationDate: createDate(year: 2024, month: 4, day: 20)),
                          Commentt(content: "Expliquer les changements à venir", username: "ThomasLeclerc", publicationDate: createDate(year: 2024, month: 4, day: 21))
                      ],
                      resolu: false,
                      category: "Grossesse"),
                
                Forum(title: "Faire aimer les légumes aux enfants",
                      theme: "Nutrition",
                      publicationDate: createDate(year: 2024, month: 7, day: 7),
                      description: "Techniques pour encourager les enfants à manger des légumes.",
                      comments: [
                          Commentt(content: "Cacher les légumes dans des plats", username: "JulienBenoit", publicationDate: createDate(year: 2024, month: 7, day: 8)),
                          Commentt(content: "Les impliquer dans la préparation", username: "LauraCaron", publicationDate: createDate(year: 2024, month: 7, day: 9)),
                          Commentt(content: "Rendre les légumes amusants", username: "VictorGiraud", publicationDate: createDate(year: 2024, month: 7, day: 10)),
                          Commentt(content: "Les présenter de manière créative", username: "ChloéGarnier", publicationDate: createDate(year: 2024, month: 7, day: 11))
                      ],
                      resolu: true,
                      category: "Enfant")
            ]
    }
}
