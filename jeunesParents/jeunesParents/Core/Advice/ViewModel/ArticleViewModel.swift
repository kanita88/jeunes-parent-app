//
//  ArticleViewModel.swift
//  jeunesParents
//
//  Created by Klesya on 21/10/2024.
//

import Foundation

func createDate(year: Int, month: Int, day: Int) -> Date {
    let dateComponents = DateComponents(year: year, month: month, day: day)
    return Calendar.current.date(from: dateComponents) ?? Date()
}

class ArticleViewModel : ObservableObject {
    @Published var articles : [Article] = []
    
    init() {
        self.articles = [
            Article(title: "Les bienfaits de l'allaitement",
                    description: "Découvrez les avantages de l'allaitement pour la santé du bébé et de la mère.",
                    comments: ["Très instructif !", "J'ai adoré cet article."],
                    publicationDate: createDate(year: 2023, month: 5, day: 12),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/3074935/pexels-photo-3074935.jpeg"), // Mère allaitant son bébé
            
            Article(title: "Comment gérer les crises de colère",
                    description: "Des conseils pratiques pour aider les parents à gérer les crises de colère de leurs enfants.",
                    comments: ["Merci pour ces astuces !", "Je vais essayer ces techniques."],
                    publicationDate: createDate(year: 2023, month: 6, day: 22),
                    readTime: 8,
                    imageURL: "https://images.pexels.com/photos/4868633/pexels-photo-4868633.jpeg"), // Enfant en colère
            
            Article(title: "Préparer l'arrivée d'un nouvel enfant",
                    description: "Stratégies pour aider les enfants à s'adapter à l'arrivée d'un nouveau bébé.",
                    comments: ["Article très utile !", "Des conseils précieux."],
                    publicationDate: createDate(year: 2023, month: 4, day: 30),
                    readTime: 6,
                    imageURL: "https://images.pexels.com/photos/1692050/pexels-photo-1692050.jpeg"), // Famille avec un nouveau-né
            
            Article(title: "Les étapes du développement de l'enfant",
                    description: "Un aperçu des différentes étapes de développement de la petite enfance.",
                    comments: ["Très intéressant !", "J'ai appris beaucoup de choses."],
                    publicationDate: createDate(year: 2023, month: 3, day: 10),
                    readTime: 7,
                    imageURL: "https://images.pexels.com/photos/8422173/pexels-photo-8422173.jpeg"), // Enfant jouant et apprenant
            
            Article(title: "Comment instaurer une routine de sommeil",
                    description: "Conseils pour établir une routine de sommeil saine pour votre enfant.",
                    comments: ["Cela a fonctionné pour nous !", "Merci pour ces conseils."],
                    publicationDate: createDate(year: 2023, month: 7, day: 19),
                    readTime: 4,
                    imageURL: "https://images.pexels.com/photos/2797865/pexels-photo-2797865.jpeg"), // Enfant endormi
            
            Article(title: "L'importance du jeu dans l'éducation",
                    description: "Comment le jeu contribue à l'apprentissage et au développement des enfants.",
                    comments: ["Un bon rappel sur l'importance du jeu.", "À lire absolument."],
                    publicationDate: createDate(year: 2023, month: 8, day: 5),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/3756036/pexels-photo-3756036.jpeg"), // Enfants jouant ensemble
            
            Article(title: "Équilibre entre vie professionnelle et familiale",
                    description: "Des stratégies pour équilibrer les responsabilités professionnelles et familiales.",
                    comments: ["Article très pertinent.", "Je me sens moins seule !"],
                    publicationDate: createDate(year: 2023, month: 9, day: 9),
                    readTime: 9,
                    imageURL: "https://images.pexels.com/photos/4079281/pexels-photo-4079281.jpeg"), // Parents travaillant à domicile
            
            Article(title: "Les premières expériences alimentaires",
                    description: "Guide pour introduire les aliments solides dans l'alimentation de votre bébé.",
                    comments: ["Merci pour ces conseils pratiques.", "Cela m'aide beaucoup."],
                    publicationDate: createDate(year: 2023, month: 10, day: 1),
                    readTime: 6,
                    imageURL: "https://images.pexels.com/photos/1001914/pexels-photo-1001914.jpeg"), // Bébé essayant de la nourriture
            
            Article(title: "La discipline positive",
                    description: "Techniques de discipline positive pour élever des enfants heureux et confiants.",
                    comments: ["Je suis fan de cette approche.", "À essayer !"],
                    publicationDate: createDate(year: 2023, month: 10, day: 11),
                    readTime: 7,
                    imageURL: "https://images.pexels.com/photos/28998255/pexels-photo-28998255/free-photo-of-une-mere-et-sa-fille-se-lient-d-amitie-au-coucher-du-soleil.jpeg"), // Parents discutant avec leurs enfants
            
            Article(title: "Comment faire face à la jalousie entre frères et sœurs",
                    description: "Stratégies pour aider les enfants à gérer la jalousie au sein de la fratrie.",
                    comments: ["Cela m'aide à comprendre mes enfants.", "Des conseils très pratiques."],
                    publicationDate: createDate(year: 2023, month: 11, day: 2),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/3771505/pexels-photo-3771505.jpeg") // Frères et sœurs jouant ensemble
        ]
    }
}
