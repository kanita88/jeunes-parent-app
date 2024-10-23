//
//  AdviceView.swift
//  jeunesParents
//
//  Created by Klesya on 18/10/2024.
//

import SwiftUI

struct AdviceView: View {
    @StateObject private var forumViewModel = ForumViewModel()
    @StateObject private var articleViewModel = ArticleViewModel()
    @State var searchBar : String = ""
    var jpBlue = Color(red: 0.29, green: 0.47, blue: 0.59)
    private var categories = ["Parent", "Enfant", "Grossesse", "Post-Partum", "Pro"]
    @State var selectedCategory = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField(text: $searchBar, label: {
                            Text("Rechercher un mot clef")
                        })
                    }
                    .padding()
                    .frame(width: 289, height: 32)
                    .background(Color(red: 0.94, green: 0.95, blue: 0.98).opacity(0.8))
                    .cornerRadius(15)
                    
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                if selectedCategory == category {
                                    selectedCategory = ""
                                } else {
                                    selectedCategory = category
                                }
                            }, label: {
                                ZStack {
                                    Circle()
                                        .stroke(category == selectedCategory ? .clear : jpBlue, lineWidth: 1.5)
                                        .fill(
                                            category == selectedCategory ?
                                            AnyShapeStyle(LinearGradient(
                                                stops: [
                                                    Gradient.Stop(color: Color(red: 0.29, green: 0.47, blue: 0.59), location: 0.00),
                                                    Gradient.Stop(color: .white, location: 1.00),
                                                ],
                                                startPoint: UnitPoint(x: 1.25, y: -0.19),
                                                endPoint: UnitPoint(x: -0.2, y: 1.14)
                                            ))
                                            : AnyShapeStyle(Color.white)
                                        )
                                        .frame(width: 69.0, height: 69.0)
                                        
                                    Text(category)
                                        .font(.system(size: 10))
                                        .foregroundColor(jpBlue)
                                }
                            })
                        }
                    }
                    .padding(.top, 3.0)
                    
                    Text("Forum")
                        .padding(.top, -1.0)
                        .foregroundStyle(jpBlue)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading, 16.0)
                        .font(.title)
                    
                    ScrollView {
                        ForEach(forumViewModel.forums.filter { forum in
                            selectedCategory.isEmpty || forum.category == selectedCategory
                        }) { forum in
                            HStack {
                                    VStack {
                                        Text(forum.title)
                                            .lineLimit(1)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 16))
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                        Text(forum.description)
                                            .lineLimit(2)
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 12))
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                        
                                        HStack(spacing: 10){
                                            Text(formatDate(forum.publicationDate))
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 10))
                                            
                                            HStack(spacing:0) {
                                                Image(systemName: "message.fill")
                                                Text("\(forum.comment.count)")
                                            }
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 10))
                                            
                                            Text(forum.category)
                                                .foregroundStyle(.white)
                                                .padding(.leading, 6)
                                                .padding(.horizontal, 10.0)
                                                .font(.system(size: 9))
                                                .background() {
                                                    Rectangle()
                                                        .foregroundStyle(.gray)
                                                        .frame(height: 13.0)
                                                        .cornerRadius(20)
                                                        .padding(.leading, 6)
                                                }
                                        }
                                        .padding(.top, -3.0)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                    }
                                    
                                    VStack {
                                        Image(systemName: forum.resolu ? "checkmark.bubble.fill" : "bubble")
                                            .font(.system(size: 25))
                                        Text(forum.resolu ? " Résolu " : "Non\nrésolu")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 15))
                                    }
                                    .foregroundColor(jpBlue)
                                }
                                .padding(.horizontal, 47.0)
                                .padding(.vertical, 16.0)
                                .background() {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 351)
                                        .background(Color(red: 0.94, green: 0.95, blue: 0.98))
                                        .cornerRadius(24)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            }
                        }
                    }
                    .padding(.top, -12.0)
                    .frame(height: 300.0)
                    
                    
                    Text("Articles")
                        .padding(.top, 8)
                        .padding(.bottom, -50.0)
                        .foregroundStyle(jpBlue)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading, 16.0)
                        .font(.title)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(articleViewModel.articles.filter { article in
                                selectedCategory.isEmpty || article.category == selectedCategory
                            }) { article in
                                NavigationLink(destination: {
                                    ScrollView {
                                        Text(article.title)
                                            .font(.title)
                                            .bold()
                                        
                                        AsyncImage(url: URL(string: article.imageURL)) { phase in
                                            if let image = phase.image {
                                                // Image chargée avec succès
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 300.0, height: 170)
                                                    .cornerRadius(10)
                                            } else if phase.error != nil {
                                                // Erreur lors du chargement de l'image
                                                Text("Erreur de chargement de l'image")
                                                    .foregroundColor(.red)
                                            } else {
                                                // Indicateur de chargement pendant que l'image est en cours de téléchargement
                                                ProgressView()
                                                    .frame(width: 140, height: 140)
                                            }
                                        }
                                        
                                        HStack {
                                            Text(formatDate(article.publicationDate))
                                            Text(article.category)
                                        }
                                        Text(article.content)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("Commentaires")
                                            .bold()
                                            .frame(alignment: .leading)
                                        
                                        ForEach(article.comments, id: \.self) { comment in
                                            Text(comment.username)
                                            Text(comment)
                                            Divider()
                                        }
                                    }
                                }, label: {
                                       ZStack {
                                           Rectangle()
                                               .frame(width: 170, height: 83)
                                               .cornerRadius(25)
                                               .foregroundStyle(Color(red: 0.94, green: 0.95, blue: 0.98))
                                               .padding(.top, 160.0)
                                               .overlay(content: {
                                                   Text(article.title)  // Affichage du titre de l'article
                                                       .foregroundStyle(.black)
                                                       .multilineTextAlignment(.center)
                                                       .bold()
                                                       .font(.system(size: 10))
                                                       .padding(.top, 200.0)
                                               })
                                           
                                           AsyncImage(url: URL(string: article.imageURL)) { phase in
                                               if let image = phase.image {
                                                   // Image chargée avec succès
                                                   image
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fill)
                                                       .frame(width: 170, height: 170)
                                                       .cornerRadius(25)
                                               } else if phase.error != nil {
                                                   // Erreur lors du chargement de l'image
                                                   Text("Erreur de chargement de l'image")
                                                       .foregroundColor(.red)
                                               } else {
                                                   // Indicateur de chargement pendant que l'image est en cours de téléchargement
                                                   ProgressView()
                                                       .frame(width: 140, height: 140)
                                               }
                                           }
                                           
                                           HStack(spacing:0) {
                                               Image(systemName: "book.fill")
                                               Text("\(article.readTime)min")
                                           }
                                           .padding(.top, -70.0)
                                           .padding(.leading, 94.0)
                                           .foregroundStyle(Color(red: 1, green: 0.94, blue: 0.65))
                                       }
                                   
                                })
                            }
                        }
                    }
                }
            }
            .navigationTitle("Conseils")
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"  // Spécifie le format jour/mois/année
        return dateFormatter.string(from: date)
    }
}

#Preview {
    AdviceView()
}
