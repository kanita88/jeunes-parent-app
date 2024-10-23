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
            Article(
                    title: "Les bienfaits de l'allaitement",
                    description: "Découvrez les avantages de l'allaitement pour la santé du bébé et de la mère.",
                    comments: [
                        Comment(content: "Très instructif !", username: "EmmaDubois", publicationDate: createDate(year: 2023, month: 5, day: 13)),
                        Comment(content: "J'ai adoré cet article.", username: "LucasMartin", publicationDate: createDate(year: 2023, month: 5, day: 14))
                    ],
                    publicationDate: createDate(year: 2023, month: 5, day: 12),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/3074935/pexels-photo-3074935.jpeg",
                    category: "Post-Partum",
                    content: """
                    L'allaitement présente de nombreux bienfaits tant pour le bébé que pour la mère.
                    Pour le bébé, il assure une nutrition optimale, favorise un lien affectif avec sa mère,
                    et renforce son système immunitaire. De plus, l'allaitement peut réduire les risques
                    d'obésité et de diabète à long terme.
                    
                    Pour la mère, l'allaitement aide à récupérer après l'accouchement,
                    brûle des calories supplémentaires et diminue le risque de certains cancers.
                    
                    En conclusion, l'allaitement est un choix sain qui bénéficie à la fois au bébé et à la mère.
                    """
                ),
                
                Article(
                    title: "Comment gérer les crises de colère",
                    description: "Des conseils pratiques pour aider les parents à gérer les crises de colère de leurs enfants.",
                    comments: [
                        Comment(content: "Merci pour ces astuces !", username: "SophieRenaud", publicationDate: createDate(year: 2023, month: 6, day: 23)),
                        Comment(content: "Je vais essayer ces techniques.", username: "ThomasLeclerc", publicationDate: createDate(year: 2023, month: 6, day: 24))
                    ],
                    publicationDate: createDate(year: 2023, month: 6, day: 22),
                    readTime: 8,
                    imageURL: "https://images.pexels.com/photos/4868633/pexels-photo-4868633.jpeg",
                    category: "Enfant",
                    content: """
                    Les crises de colère chez les enfants sont normales et font partie de leur développement.
                    Il est essentiel pour les parents de rester calmes et de ne pas réagir avec colère.
                    Voici quelques stratégies pour gérer ces situations :
                    
                    1. Prenez du recul et respirez profondément.
                    2. Validez les émotions de votre enfant tout en lui expliquant la situation.
                    3. Créez une routine pour donner un cadre rassurant à votre enfant.
                    
                    En suivant ces conseils, vous pourrez mieux gérer les crises de colère et
                    renforcer votre relation avec votre enfant.
                    """
                ),
                
                Article(
                    title: "Préparer l'arrivée d'un nouvel enfant",
                    description: "Stratégies pour aider les enfants à s'adapter à l'arrivée d'un nouveau bébé.",
                    comments: [
                        Comment(content: "Article très utile !", username: "JulienBenoit", publicationDate: createDate(year: 2023, month: 4, day: 30)),
                        Comment(content: "Des conseils précieux.", username: "LauraCaron", publicationDate: createDate(year: 2023, month: 5, day: 1))
                    ],
                    publicationDate: createDate(year: 2023, month: 4, day: 30),
                    readTime: 6,
                    imageURL: "https://images.pexels.com/photos/1692050/pexels-photo-1692050.jpeg",
                    category: "Grossesse",
                    content: """
                    L'arrivée d'un nouvel enfant est une grande étape pour toute la famille.
                    Il est important de préparer l'aîné à ce changement afin de faciliter son adaptation.
                    Voici quelques conseils :
                    
                    - Impliquez-le dans les préparatifs pour le nouveau bébé.
                    - Expliquez-lui les changements à venir en termes simples.
                    - Accordez-lui du temps de qualité pour qu'il ne se sente pas délaissé.
                    
                    En suivant ces étapes, vous pourrez aider votre enfant à accueillir son nouveau frère ou sa sœur
                    avec enthousiasme et sérénité.
                    """
                ),
                
                Article(
                    title: "Les étapes du développement de l'enfant",
                    description: "Un aperçu des différentes étapes de développement de la petite enfance.",
                    comments: [
                        Comment(content: "Très intéressant !", username: "ClaraDurand", publicationDate: createDate(year: 2023, month: 3, day: 11)),
                        Comment(content: "J'ai appris beaucoup de choses.", username: "PierreDubois", publicationDate: createDate(year: 2023, month: 3, day: 12))
                    ],
                    publicationDate: createDate(year: 2023, month: 3, day: 10),
                    readTime: 7,
                    imageURL: "https://images.pexels.com/photos/8422173/pexels-photo-8422173.jpeg",
                    category: "Enfant",
                    content: """
                    Le développement de l'enfant se déroule en plusieurs étapes clés, allant de la naissance à
                    l'âge scolaire. Ces étapes incluent :
                    
                    - **0 à 1 an :** Développement sensoriel et moteur. L'enfant découvre le monde qui l'entoure.
                    - **1 à 3 ans :** Apprentissage du langage et développement social.
                    - **3 à 6 ans :** Développement de la pensée logique et de l'imagination.
                    
                    Comprendre ces étapes permet aux parents de soutenir efficacement le développement de leur enfant.
                    """
                ),
                
                Article(
                    title: "Comment instaurer une routine de sommeil",
                    description: "Conseils pour établir une routine de sommeil saine pour votre enfant.",
                    comments: [
                        Comment(content: "Cela a fonctionné pour nous !", username: "MathildeLemoine", publicationDate: createDate(year: 2023, month: 7, day: 20)),
                        Comment(content: "Merci pour ces conseils.", username: "JulesLeroux", publicationDate: createDate(year: 2023, month: 7, day: 21))
                    ],
                    publicationDate: createDate(year: 2023, month: 7, day: 19),
                    readTime: 4,
                    imageURL: "https://images.pexels.com/photos/2797865/pexels-photo-2797865.jpeg",
                    category: "Enfant",
                    content: """
                    Instaurer une routine de sommeil est crucial pour le bien-être de votre enfant. Voici quelques
                    conseils pratiques :
                    
                    - Créez un environnement calme et confortable pour dormir.
                    - Établissez des rituels de coucher réguliers, comme lire une histoire ou chanter une chanson.
                    - Évitez les écrans avant le coucher pour faciliter l'endormissement.
                    
                    Une bonne routine de sommeil aidera votre enfant à se sentir en sécurité et à mieux dormir.
                    """
                ),
                
                Article(
                    title: "L'importance du jeu dans l'éducation",
                    description: "Comment le jeu contribue à l'apprentissage et au développement des enfants.",
                    comments: [
                        Comment(content: "Un bon rappel sur l'importance du jeu.", username: "AliceMoreau", publicationDate: createDate(year: 2023, month: 8, day: 6)),
                        Comment(content: "À lire absolument.", username: "VictorGiraud", publicationDate: createDate(year: 2023, month: 8, day: 7))
                    ],
                    publicationDate: createDate(year: 2023, month: 8, day: 5),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/3756036/pexels-photo-3756036.jpeg",
                    category: "Enfant",
                    content: """
                    Le jeu est essentiel pour le développement des enfants. Il stimule la créativité,
                    favorise l'apprentissage social et aide à développer des compétences motrices.
                    Encourager le jeu libre permet aux enfants d'explorer, d'apprendre et de s'épanouir.
                    
                    Les parents et les éducateurs devraient promouvoir des occasions de jeu pour favoriser
                    un développement équilibré et heureux.
                    """
                ),
                
                Article(
                    title: "Aider les enfants à gérer le stress",
                    description: "Stratégies pour aider les enfants à faire face au stress et à l'anxiété.",
                    comments: [
                        Comment(content: "Article très pertinent.", username: "LéaBernard", publicationDate: createDate(year: 2023, month: 9, day: 10)),
                        Comment(content: "Je me sens moins seule !", username: "GabrielMarchand", publicationDate: createDate(year: 2023, month: 9, day: 11))
                    ],
                    publicationDate: createDate(year: 2023, month: 9, day: 9),
                    readTime: 6,
                    imageURL: "https://images.pexels.com/photos/28998255/pexels-photo-28998255/free-photo-of-une-mere-et-sa-fille-se-lient-d-amitie-au-coucher-du-soleil.jpeg",
                    category: "Enfant",
                    content: """
                    Le stress et l'anxiété peuvent affecter les enfants de manière significative.
                    Voici quelques stratégies pour les aider :
                    
                    - Enseignez-leur des techniques de respiration profonde.
                    - Écoutez leurs préoccupations et validez leurs sentiments.
                    - Encouragez l'expression créative à travers l'art ou l'écriture.
                    
                    En aidant les enfants à gérer leur stress, nous les préparons à affronter
                    les défis de la vie avec confiance.
                    """
                ),
                
                Article(
                    title: "Préparer votre enfant à l'école",
                    description: "Conseils pour aider les enfants à faire la transition vers l'école.",
                    comments: [
                        Comment(content: "Merci pour ces conseils pratiques.", username: "CélineRobert", publicationDate: createDate(year: 2023, month: 10, day: 2)),
                        Comment(content: "Cela m'aide beaucoup.", username: "NicolasLamy", publicationDate: createDate(year: 2023, month: 10, day: 3))
                    ],
                    publicationDate: createDate(year: 2023, month: 10, day: 1),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/8260495/pexels-photo-8260495.jpeg",
                    category: "Enfant",
                    content: """
                    La transition vers l'école peut être une étape stressante pour les enfants. Voici quelques
                    conseils pour les aider à se préparer :
                    
                    - Visitez l'école ensemble pour familiariser votre enfant avec les lieux.
                    - Parlez des activités qu'ils feront à l'école pour susciter leur intérêt.
                    - Établissez une routine de préparation le matin pour réduire le stress.
                    
                    En suivant ces conseils, vous aiderez votre enfant à aborder l'école avec confiance
                    et enthousiasme.
                    """
                ),
                
                Article(
                    title: "Les bienfaits de la méditation pour les enfants",
                    description: "Comment la méditation peut aider les enfants à gérer leurs émotions.",
                    comments: [
                        Comment(content: "Je suis fan de cette approche.", username: "ClaireVasseur", publicationDate: createDate(year: 2023, month: 10, day: 12)),
                        Comment(content: "À essayer !", username: "AntoineFournier", publicationDate: createDate(year: 2023, month: 10, day: 13))
                    ],
                    publicationDate: createDate(year: 2023, month: 10, day: 11),
                    readTime: 5,
                    imageURL: "https://images.pexels.com/photos/2597205/pexels-photo-2597205.jpeg",
                    category: "Enfant",
                    content: """
                    La méditation est un excellent outil pour aider les enfants à gérer leurs émotions et à
                    développer la concentration. Voici quelques bienfaits :
                    
                    - Réduction de l'anxiété et du stress.
                    - Amélioration de la concentration et de l'attention.
                    - Développement de l'empathie et de la compassion.
                    
                    Introduire la méditation dans la vie quotidienne des enfants peut les aider à se sentir
                    plus équilibrés et sereins.
                    """
                ),
                
                Article(
                    title: "Comprendre l'impact des écrans sur les enfants",
                    description: "Un aperçu des effets des écrans sur le développement des enfants.",
                    comments: [
                        Comment(content: "Cela m'aide à comprendre mes enfants.", username: "ChloéGarnier", publicationDate: createDate(year: 2023, month: 11, day: 3)),
                        Comment(content: "Des conseils très pratiques.", username: "PaulineChauvet", publicationDate: createDate(year: 2023, month: 11, day: 4))
                    ],
                    publicationDate: createDate(year: 2023, month: 11, day: 2),
                    readTime: 6,
                    imageURL: "https://images.pexels.com/photos/4867670/pexels-photo-4867670.jpeg",
                    category: "Enfant",
                    content: """
                    L'utilisation des écrans est de plus en plus fréquente chez les enfants, ce qui soulève des
                    préoccupations quant à son impact sur leur développement. Voici quelques points à
                    considérer :
                    
                    - Limitez le temps d'écran à des activités éducatives et créatives.
                    - Encouragez les interactions en personne pour développer des compétences sociales.
                    - Surveillez le contenu pour assurer un environnement sûr et approprié.
                    
                    En ayant une approche équilibrée, vous pouvez aider votre enfant à profiter des avantages
                    des écrans tout en minimisant les risques.
                    """
                )
        ]
    }
}
