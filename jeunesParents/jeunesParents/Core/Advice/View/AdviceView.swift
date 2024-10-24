////
////  AdviceView.swift
////  jeunesParents
////
////  Created by Klesya on 18/10/2024.
////
//
//import SwiftUI
//
//var jpBlue = Color(red: 0.29, green: 0.47, blue: 0.59)
//
//struct AdviceView: View {
//    @StateObject private var forumViewModel = ForumViewModel()
//    @StateObject private var articleViewModel = ArticleViewModel()
//    @State var searchBar: String = ""
//    var categories = ["Parent", "Enfant", "Grossesse", "Post-Partum", "Pro"]
//    @State var selectedCategory = ""
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack {
//                    AdviceSearchBar(searchText: $searchBar)
//                    
//                    CategorySelector(categories: categories, selectedCategory: $selectedCategory)
//                    
//                    ForumList(forumViewModel: forumViewModel, selectedCategory: selectedCategory)
//                    
//                    ArticleList(articleViewModel: articleViewModel, selectedCategory: selectedCategory)
//                }
//            }
//            .navigationTitle("Conseils")
//        }
//    }
//}
//
//struct AdviceSearchBar: View {
//    @Binding var searchText: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: "magnifyingglass")
//                .foregroundColor(.gray)
//            TextField("Rechercher un mot clef", text: $searchText)
//        }
//        .padding()
//        .frame(width: 289, height: 32)
//        .background(Color(red: 0.94, green: 0.95, blue: 0.98).opacity(0.8))
//        .cornerRadius(15)
//    }
//}
//
//struct CategorySelector: View {
//    var categories: [String]
//    @Binding var selectedCategory: String
//    
//    // Custom initializer
//    init(categories: [String], selectedCategory: Binding<String>) {
//        self.categories = categories
//        self._selectedCategory = selectedCategory
//    }
//    
//    var body: some View {
//        HStack {
//            ForEach(categories, id: \.self) { category in
//                Button(action: {
//                    selectedCategory = (selectedCategory == category) ? "" : category
//                }) {
//                    ZStack {
//                        Circle()
//                            .stroke(category == selectedCategory ? .clear : jpBlue, lineWidth: 1.5)
//                            .fill(category == selectedCategory ? AnyShapeStyle(LinearGradient(gradient: Gradient(colors: [jpBlue, .white]), startPoint: .top, endPoint: .bottom)) : AnyShapeStyle(Color.white))
//                            .frame(width: 69.0, height: 69.0)
//                        
//                        Text(category)
//                            .font(.system(size: 10))
//                            .foregroundColor(jpBlue)
//                    }
//                }
//            }
//        }
//        .padding(.top, 3.0)
//    }
//}
//
//struct ForumList: View {
//    @ObservedObject var forumViewModel: ForumViewModel
//    var selectedCategory: String
//    
//    init(forumViewModel: ForumViewModel, selectedCategory: String) {
//        self.forumViewModel = forumViewModel
//        self.selectedCategory = selectedCategory
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Forum")
//                .padding(.top, -1.0)
//                .foregroundColor(jpBlue)
//                .bold()
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 16.0)
//                .font(.title)
//            
//            ScrollView {
//                ForEach(forumViewModel.forums.filter { forum in
//                    selectedCategory.isEmpty || forum.category == selectedCategory
//                }) { forum in
//                    ForumRow(forum: forum)
//                }
//            }
//            .padding(.top, -12.0)
//            .frame(height: 300.0)
//        }
//    }
//}
//
//struct ForumRow: View {
//    var forum: Forum
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(forum.title)
//                    .lineLimit(1)
//                    .fontWeight(.semibold)
//                    .font(.system(size: 16))
//                
//                Text(forum.description)
//                    .lineLimit(2)
//                    .foregroundColor(.gray)
//                    .font(.system(size: 12))
//                
//                HStack(spacing: 10) {
//                    Text(formatDate(forum.publicationDate))
//                        .foregroundColor(.gray)
//                        .font(.system(size: 10))
//                    
//                    HStack(spacing: 0) {
//                        Image(systemName: "message.fill")
//                        Text("\(forum.comments.count)")
//                    }
//                    .foregroundColor(.gray)
//                    .font(.system(size: 10))
//                    
//                    Text(forum.category)
//                        .foregroundColor(.white)
//                        .padding(.leading, 6)
//                        .padding(.horizontal, 10.0)
//                        .font(.system(size: 9))
//                        .background(Color.gray)
//                        .cornerRadius(20)
//                        .padding(.leading, 6)
//                }
//                .padding(.top, -3.0)
//            }
//            
//            VStack {
//                Image(systemName: forum.resolu ? "checkmark.bubble.fill" : "bubble")
//                    .font(.system(size: 25))
//                Text(forum.resolu ? " Résolu " : "Non\nrésolu")
//                    .multilineTextAlignment(.center)
//                    .font(.system(size: 15))
//            }
//            .foregroundColor(Color(red: 0.29, green: 0.47, blue: 0.59))
//        }
//        .padding(.horizontal, 47.0)
//        .padding(.vertical, 16.0)
//        .background(Color(red: 0.94, green: 0.95, blue: 0.98))
//        .cornerRadius(24)
//        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
//    }
//}
//
//struct ArticleList: View {
//    @ObservedObject var articleViewModel: ArticleViewModel
//    var selectedCategory: String
//    
//    var body: some View {
//        VStack {
//            Text("Articles")
//                .padding(.top, 8)
//                .padding(.bottom, -50.0)
//                .foregroundStyle(jpBlue)
//                .bold()
//                .frame(maxWidth: .infinity,alignment: .leading)
//                .padding(.leading, 16.0)
//                .font(.title)
//            
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(articleViewModel.articles.filter { article in
//                        selectedCategory.isEmpty || article.category == selectedCategory
//                    }) { article in
//                        NavigationLink(destination: ArticleDetailView(article: article)) {
//                            ArticleCard(article: article)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ArticleCard: View {
//    var article: Article
//    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .frame(width: 170, height: 83)
//                .cornerRadius(25)
//                .foregroundStyle(Color(red: 0.94, green: 0.95, blue: 0.98))
//                .padding(.top, 160.0)
//                .overlay(content: {
//                    Text(article.title)  // Affichage du titre de l'article
//                        .foregroundStyle(.black)
//                        .multilineTextAlignment(.center)
//                        .bold()
//                        .font(.system(size: 10))
//                        .padding(.top, 200.0)
//                })
//            
//            AsyncImage(url: URL(string: article.imageURL)) { phase in
//                if let image = phase.image {
//                    // Image chargée avec succès
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 170, height: 170)
//                        .cornerRadius(25)
//                } else if phase.error != nil {
//                    // Erreur lors du chargement de l'image
//                    Text("Erreur de chargement de l'image")
//                        .foregroundColor(.red)
//                } else {
//                    // Indicateur de chargement pendant que l'image est en cours de téléchargement
//                    ProgressView()
//                        .frame(width: 140, height: 140)
//                }
//            }
//            
//            HStack(spacing:0) {
//                Image(systemName: "book.fill")
//                Text("\(article.readTime)min")
//            }
//            .padding(.top, -70.0)
//            .padding(.leading, 94.0)
//            .foregroundStyle(Color(red: 1, green: 0.94, blue: 0.65))
//        }
//    }
//}
//
//struct ArticleDetailView: View {
//    var article: Article
//    
//    var body: some View {
//        ScrollView {
//            Text(article.title)
//                .font(.title)
//                .bold()
//            
//            AsyncImage(url: URL(string: article.imageURL)) { phase in
//                if let image = phase.image {
//                    image.resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 300.0, height: 170)
//                        .cornerRadius(10)
//                } else if phase.error != nil {
//                    Text("Erreur de chargement de l'image")
//                        .foregroundColor(.red)
//                } else {
//                    ProgressView()
//                        .frame(width: 140, height: 140)
//                }
//            }
//            
//            HStack {
//                Text(formatDate(article.publicationDate))
//                Text(article.category)
//            }
//            .font(.caption)
//            .padding(.bottom)
//            
//            Text(article.content)
//                .multilineTextAlignment(.leading)
//            
//            Text("Commentaires")
//                .padding(.top)
//                .bold()
//                .frame(maxWidth: .infinity, alignment: .leading)
//            
//            Divider()
//            ForEach(article.comments) { comment in
//                HStack {
//                    Text(comment.username)
//                        .fontWeight(.semibold)
//                    Text(comment.content)
//                }
//                Divider()
//            }
//        }
//    }
//}
//
//func formatDate(_ date: Date) -> String {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd/MM/yyyy"  // Specify the date format
//    return dateFormatter.string(from: date)
//}
//
//#Preview {
//    AdviceView()
//}
